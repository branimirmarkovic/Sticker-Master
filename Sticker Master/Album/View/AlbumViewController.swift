//
//  AlbumViewModel.swift
//  Sticker Master
//
//  Created by Branimir Markovic on 29.8.22..
//

import UIKit


class AlbumViewController: UIViewController {
    
    private let collectionView: UICollectionView
    private let viewModel: AlbumViewModel
    
    private var stickerCellControllers: [[StickerCellController]] = [[]]
    
    init(viewModel: AlbumViewModel, collectionViewLayoutProvider: CollectionViewLayoutFactory) {
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayoutProvider.gridLayout())
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureLayout()
        configureTableView()
        bind()
        viewModel.createAlbum()
    }
    
    private func bind() {
        viewModel.onLoad = {
            self.stickerCellControllers.removeAll()
            for _ in 0...self.viewModel.numberOfCollections - 1 {
                self.stickerCellControllers.append([])
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()   
            }
        }
    }
    
    private func addSubviews() {
        view.addSubview(collectionView)
    }
    
    private func configureLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func configureTableView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(StickerCell.self, forCellWithReuseIdentifier: StickerCell.identifier)
    }
    
    
}

extension AlbumViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return viewModel.numberOfCollections
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfStickers(forCollectionAtIndex: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellController = StickerCellController(
            stickerViewModel: viewModel.stickerViewModel(
                collectionIndex:indexPath.section,
                stickerIndex: indexPath.row))
        
        stickerCellControllers[indexPath.section].append(cellController)
        return cellController.dequeueCell(with: collectionView, at: indexPath)
    }
}

extension AlbumViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        stickerCellControllers[indexPath.section][indexPath.row].cellTapped()
    }
}

class StickerCellController {
    
    private var cell: StickerCell?
    private let stickerViewModel: StickerViewModel
    
    init(stickerViewModel: StickerViewModel) {
        self.stickerViewModel = stickerViewModel
        self.bind()
    }
    
    func dequeueCell(with collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StickerCell.identifier, for: indexPath) as! StickerCell
        self.cell = cell
        
        cell.numberLabel.text = stickerViewModel.stickerTitle
        configureColour()
        
        return cell
    }
    
    func cellTapped() {
        stickerViewModel.addSticker()
        configureColour()
    }
    
    private func bind() {
        stickerViewModel.onStickerAdd = {
            self.configureColour()
        }
    }
    
    private func configureColour() {
        if stickerViewModel.missing{
            cell?.backgroundColor = .blue
        } else {
            cell?.backgroundColor = .red
        }
    }
    
}

class StickerCell: UICollectionViewCell {
    
    static let identifier = "sticker-cell"
    
    var numberLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews(){
        self.contentView.addSubview(numberLabel)
    }
    
    private func configureUI() {
        numberLabel.font = UIFont.preferredFont(forTextStyle: .body)
        numberLabel.numberOfLines = 2
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            numberLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            numberLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            numberLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

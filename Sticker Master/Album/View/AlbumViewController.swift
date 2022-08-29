//
//  AlbumViewModel.swift
//  Sticker Master
//
//  Created by Branimir Markovic on 29.8.22..
//

import UIKit


class AlbumViewController: UIViewController {
    
    private let tableView: UITableView = UITableView(frame: .zero, style: .grouped)
    private let viewModel: AlbumViewModel
    
    init(viewModel: AlbumViewModel) {
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
            DispatchQueue.main.async {
                self.tableView.reloadData()   
            }
        }
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func configureLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StickerCell.self, forCellReuseIdentifier: StickerCell.identifier)
    }
    
    
}

extension AlbumViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfCollections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StickerCell.identifier) 
        cell?.textLabel?.text = viewModel.stickerPrefix(forCollection: indexPath.section, atIndex: indexPath.row)
        cell?.detailTextLabel?.text = String(describing: viewModel.stickerNumber(forCollection: indexPath.section, atIndex: indexPath.row))
        return cell!
        
    }
    
    
}

extension AlbumViewController: UITableViewDelegate {
    
}

class StickerCell: UITableViewCell {
    static let identifier = "sticker-cell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

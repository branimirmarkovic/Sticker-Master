//
//  AlbumViewModel.swift
//  Sticker Master
//
//  Created by Branimir Markovic on 29.8.22..
//

import Foundation


class StickerViewModel {
    
    enum Error: Swift.Error {
        case noStickersToRemove
    }
    private var sticker: Sticker
    
    init(sticker: Sticker) {
        self.sticker = sticker
    }
    
    var onStickerAdd: (() -> Void)?
    
    func addSticker() {
        sticker.count += 1
        onStickerAdd?()
    }
    
    func removeSticker() throws {
        guard sticker.count > 0 else { throw Error.noStickersToRemove}
        sticker.count -= 1
    }
    
    var stickerPrefix: String {
        sticker.number.prefix.rawValue
    }
    
    var stickerNumber: String {
        "\(sticker.number.number)"
    }
    
    var stickerTitle: String {
        "\(stickerPrefix) \(stickerNumber)"
    }
    
    var missing: Bool {
        sticker.collected
    }
}

class StickerCollectionViewModel {
    private var collection: StickerCollection
    private var stickerViewModels: [StickerViewModel]
    
    init(collection: StickerCollection) {
        self.collection = collection
        self.stickerViewModels = collection.stickers.map({StickerViewModel(sticker: $0)})
    }
    
    var name: String {
        collection.name
    }
    
    var stickersCount: Int {
        stickerViewModels.count
    }
    
    func stickerViewModel(at index: Int) -> StickerViewModel {
        stickerViewModels[index]
    }
}


class AlbumViewModel {
    private var album: Album
    private var collectionViewModels: [StickerCollectionViewModel] = []
    private let albumProvider: AlbumProvider
    
    init(albumProvider: AlbumProvider) {
        self.album = Album(name: "", collections: [])
        self.albumProvider = albumProvider
    }
    
    var onLoad: (( )-> Void)?
    
    func createAlbum() {
        self.album = albumProvider.makeAlbum()
        self.collectionViewModels = album.collections.map({StickerCollectionViewModel(collection: $0)})
        onLoad?()
    }
    
    var onStickerAddStart: (() -> Void)?
    var onStickerAddFinish: (() -> Void)?
    
    func addSticker(collection: Int, index: Int) {
        onStickerAddStart?()
        album.collections[collection].stickers[index].count += 1
        onStickerAddFinish?()
    }
    
    var onStickerRemoveStart: (() -> Void)?
    var onStickerRemoveFinish: (() -> Void)?
    var onStickerRemoveError: (() -> Void)?
    
    func removeSticker(collection: Int, index: Int) {
        guard album.collections[collection].stickers[index].count > 1 else {
            onStickerRemoveError?()
            return
        }
        onStickerAddStart?()
        album.collections[collection].stickers[index].count += 1
        onStickerRemoveFinish?()
    }
    
    func  missingStickers() -> [Sticker] {
        var missingStickers: [Sticker] = []
        album.collections.forEach { collection in
            collection.stickers.forEach { sticker in
                if sticker.collected == false {
                    missingStickers.append(sticker)
                }
            }
        }
        return missingStickers
    }
    
    func ownedStickers() -> [Sticker] {
        var ownedStickers: [Sticker] = []
        album.collections.forEach { collection in
            collection.stickers.forEach { sticker in
                if sticker.collected == true {
                    ownedStickers.append(sticker)
                }
            }
        }
        return ownedStickers
    }
    
    
    
    var numberOfCollections: Int {
        album.collections.count
    }
    
    var numberOfAllStickers: Int {
        var result: Int = 0
        self.collectionViewModels.forEach { viewModel in
            result += viewModel.stickersCount
        }
        
        return result
    }
    
    func stickerViewModel(collectionIndex: Int, stickerIndex: Int) -> StickerViewModel {
        collectionViewModels[collectionIndex].stickerViewModel(at: stickerIndex)
    }
    
    func numberOfStickers(for collectionIndex: Int) -> Int {
        album.collections[collectionIndex].stickers.count
    }
    
    func numberOfStickers(forCollectionAtIndex index: Int) -> Int {
        collectionViewModels[index].stickersCount
    }
    
    var isAlbumCompleted: Bool {
        missingStickers().count > 0
    }
    
    var numberOfMissingStickers: Int {
        missingStickers().count
    }
    
    var numberOfOwnedStickers: Int {
        ownedStickers().count
    }
    
    func stickerNumber(forCollection collectionIndex: Int, atIndex index: Int) -> Int? {
        album.collections[collectionIndex].stickers[index].number.number
    }
    
    func stickerPrefix(forCollection collectionIndex: Int, atIndex index: Int) -> String? {
        album.collections[collectionIndex].stickers[index].number.prefix.rawValue
    }
    
    func isStickerMissing(forCollection collectionIndex: Int, atIndex index: Int) -> Bool {
        album.collections[collectionIndex].stickers[index].collected
    }
    
    func collectionName(at index: Int) -> String {
        album.collections[index].name
    }
}

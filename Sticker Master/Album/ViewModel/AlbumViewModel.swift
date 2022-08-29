//
//  AlbumViewModel.swift
//  Sticker Master
//
//  Created by Branimir Markovic on 29.8.22..
//

import Foundation


class AlbumViewModel {
    private var album: Album
    private let albumProvider: AlbumProvider
    
    init(albumProvider: AlbumProvider) {
        self.album = Album(name: "", collections: [])
        self.albumProvider = albumProvider
    }
    
    var onLoad: (( )-> Void)?
    
    func createAlbum() {
        self.album = albumProvider.makeAlbum()
        onLoad?()
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
    
    func  numberOfStickers(forCollectionAtIndex index: Int) -> Int {
        album.collections[index].stickers.count
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
}

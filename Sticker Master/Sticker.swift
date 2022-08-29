//
//  Sticker.swift
//  Sticker Master
//
//  Created by Branimir Markovic on 29.8.22..
//

import Foundation

struct Album {
    var colletions: [StickerCollection] = []
}

struct StickerCollection {
    var name: String
    var stickers: [Sticker] 
}


struct Sticker {
    var collected: Bool
    var number: StickerNumber
}

struct StickerNumber {
    var number: Int
    var prefix: String?
}


class AlbumViewModel {
    private let album: Album
    
    init(album: Album) {
        self.album = album
    }
    
    func  missingStickers() -> [Sticker] {
        var missingStickers: [Sticker] = []
        album.colletions.forEach { collection in
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
        album.colletions.forEach { collection in
            collection.stickers.forEach { sticker in
                if sticker.collected == true {
                    ownedStickers.append(sticker)
                }
            }
        }
        return ownedStickers
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
}


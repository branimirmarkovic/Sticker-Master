//
//  LocalQatarWorldCupAlbumProvider.swift
//  Sticker Master
//
//  Created by Branimir Markovic on 29.8.22..
//

import Foundation


class LocalQatarWorldCupAlbumProvider: AlbumProvider {
    func makeAlbum() -> Album {
        Album(
            name: "Fifa World Cup 2022",
            collections: makeAllCollections()
            )
    }
    
    private func makeCollection(for type: CollectionPrefix, range: ClosedRange<Int>) -> StickerCollection{
        var emptyCollection = StickerCollection(name: type.rawValue, stickers: [])
        for number in range {
            let sticker = Sticker(
                collected: false,
                number: StickerNumber(
                    number: number,
                    prefix: type))
            emptyCollection.stickers.append(sticker)
        }
        return emptyCollection
    }
    
    private func makeAllCollections() -> [StickerCollection] {
        var array = [StickerCollection]()
        CollectionPrefix.allCases.forEach { collection in
            if collection == .fwc {
                array.append(makeCollection(for: .fwc, range: 0...29))
            } else {
                array.append(makeCollection(for: collection, range: 1...19))
            }
        }
        return array
    }
    
    
}

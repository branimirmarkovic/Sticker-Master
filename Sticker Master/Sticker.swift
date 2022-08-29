//
//  Sticker.swift
//  Sticker Master
//
//  Created by Branimir Markovic on 29.8.22..
//

import Foundation

protocol AlbumProvider {
    func makeAlbum() -> Album
}


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

enum CollectionPrefix: String, CaseIterable {
    case fwc = "FWC"
    case qat = "QAT"
    case ecu = "ECU"
    case sen = "SEN"
    case ned = "NED"
    case eng = "ENG"
    case irn = "IRN"
    case usa = "USA"
    case wal = "WAL"
    case arg = "ARG"
    case ksa = "KSA"
    case mex = "MEX"
    case pol = "POL"
    case fra = "FRA"
    case aus = "AUS"
    case den = "DEN"
    case tun = "TUN"
    case esp = "ESP"
    case crc = "CRC"
    case ger = "GER"
    case jpn = "JPN"
    case bel = "BEL"
    case can = "CAN"
    case mar = "MAR"
    case cro = "CRO"
    case bra = "BRA"
    case srb = "SRB"
    case sui = "SUI"
    case cmr = "CMR"
    case por = "POR"
    case gha = "GHA"
    case uru = "URU"
    case kor = "KOR"
}

struct Album {
    var name: String
    var collections: [StickerCollection]
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
    var prefix: CollectionPrefix
}


class AlbumViewModel {
    private let album: Album
    
    init(album: Album) {
        self.album = album
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


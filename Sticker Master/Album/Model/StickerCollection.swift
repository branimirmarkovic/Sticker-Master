//
//  StickerCollection.swift
//  Sticker Master
//
//  Created by Branimir Markovic on 29.8.22..
//

import Foundation


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



struct StickerCollection {
    var name: String
    var stickers: [Sticker] 
}

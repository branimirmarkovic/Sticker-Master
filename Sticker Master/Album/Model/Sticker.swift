//
//  Sticker.swift
//  Sticker Master
//
//  Created by Branimir Markovic on 29.8.22..
//

import Foundation


struct Sticker {
    var count: Int = 0
    var number: StickerNumber
    
    var collected: Bool {
        return count > 0
    }
    
    var duplicatesCount: Int {
        guard collected else {return 0}
        return count - 1
    }
}

struct StickerNumber {
    var number: Int
    var prefix: CollectionPrefix
}





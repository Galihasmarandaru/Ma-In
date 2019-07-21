//
//  GameConstant.swift
//  Ma-In
//
//  Created by Galih Asmarandaru on 20/07/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation
import CoreGraphics

struct GameConstants {
    
    struct PhysicsCategories {
        static let noCategory: UInt32 = 0
        static let allCategory: UInt32 = UInt32.max
        static let playerCategory: UInt32 = 0x1
        static let groundCategory: UInt32 = 0x1 << 1
        static let finishCategory: UInt32 = 0x1 << 2
        static let collectibleCategory: UInt32 = 0x1 << 3
        static let enemyCategory: UInt32 = 0x1 << 4
        static let frameCategory: UInt32 = 0x1 << 5
        static let ceilingCategory: UInt32 = 0x1 << 6
    }
    
    struct ZPositions {
        static let farBGZ: CGFloat = 0
        static let closeBGZ: CGFloat = 1
        static let worldZ: CGFloat = 2
        static let objectZ: CGFloat = 3
        static let playerZ: CGFloat = 4
        static let hudZ: CGFloat = 5
    }
    
    struct StringConstants {
        static let diceSelector = "DiceSelector"
        static let diceTap = "DiceTap"
        static let ruleOfGame = "ruleOfGame"
        static let letsPlayButton = "letsPlayButton"
        static let pausedKey = "Paused"
        
        static let numOfRoll = ["one", "two", "three", "four", "five", "six"]
    }
    
}















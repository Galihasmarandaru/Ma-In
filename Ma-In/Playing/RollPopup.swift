//
//  RollPopup.swift
//  Ma-In
//
//  Created by Galih Asmarandaru on 20/07/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import SpriteKit

class RollPopup: SKSpriteNode {
    
    var buttonHandlerDelegate: PopupButtonHandlerDelegate
    
    init(withTitle title: String, and texture: SKTexture, buttonHandlerDelegate: PopupButtonHandlerDelegate) {
        self.buttonHandlerDelegate = buttonHandlerDelegate
        
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

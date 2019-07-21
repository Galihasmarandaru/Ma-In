//
//  OpeningClass.swift
//  Ma-In
//
//  Created by Galih Asmarandaru on 20/07/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import SpriteKit

class OpeningClass: SKScene {
    var sceneManagerDelegate: SceneManagerDelegate?
    
    override func didMove(to view: SKView) {
        layoutView()
    }
    
    func layoutView() {
        let background = SKSpriteNode(imageNamed: GameConstants.StringConstants.ruleOfGame)
        background.size = size
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = GameConstants.ZPositions.farBGZ
        addChild(background)
        
        let startButton = SpriteKitButton(defaultButtonImage: GameConstants.StringConstants.letsPlayButton, action: goToLevelScene, index: 0)
        startButton.scale(to: frame.size, width: false, multiplier: 0.06)
        startButton.position =  CGPoint(x: 462, y: 245)
        startButton.zPosition = GameConstants.ZPositions.hudZ
        addChild(startButton)
    }
    
    func goToLevelScene(_: Int) {
        sceneManagerDelegate?.presentLevelScene(for: 0)
    }
}

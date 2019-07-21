//
//  GameScene.swift
//  Ma-In
//
//  Created by Galih Asmarandaru on 18/07/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import SpriteKit
import GameplayKit

enum Player: Int {    
    case Player1 = 1
    case Player2
}

enum GameState {
    case ready, ongoing, paused, finished
}

class GameScene: SKScene {
    
    weak var viewController: GameViewController?
    var sceneManagerDelegate: SceneManagerDelegate?
    
    var popup: RollPopup?
    var world: Int = 0
    var scoreLabel: SKLabelNode!
    var playerLabel: SKLabelNode!
    
    var gameState = GameState.ready {
        willSet {
            switch newValue {
            case .ongoing:
                print("run")
//                player.state = .running
//                pauseEnemies(bool: false)
            case .paused:
                print("stop")
//                player.state = .idle
//                pauseEnemies(bool: true)
            case .finished:
                print("stop")
//                player.state = .idle
//                pauseEnemies(bool: true)
            default:
                break
            }
        }
    }
    
//    init(size: CGSize, sceneManagerDelegate: SceneManagerDelegate) {
//        self.sceneManagerDelegate = sceneManagerDelegate
//        super.init(size: size)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    // declare string player position
    var currentSpacePlayer1: String = "A0"
    var currentSpacePlayer2: String = "B0"
    
    // move step
    var movesRemaining: Int = 4
    var whosTurn: Player = .Player1
    
    // create node
    var player1Piece: SKSpriteNode = SKSpriteNode()
    var player2Piece: SKSpriteNode = SKSpriteNode()
    
    
    override func didMove(to view: SKView) {
        
        // input name of node to the code and looping every node
        for node in children {
            if node.name == "Player1Piece"{
                if let someNode: SKSpriteNode = node as? SKSpriteNode {
                    player1Piece = someNode
                }
            } else if node.name == "Player2Piece"{
                if let someNode: SKSpriteNode = node as? SKSpriteNode {
                    player2Piece = someNode
                }
            }
        }
        gameState = .ongoing
        showRoll()
    }
    
    // moving node player
    func movePiece() {
        
        // bila lebih besar dari 4
        if ( movesRemaining > 0) {
            // create currentSpace
            // currentSpace = space --> currentSpacePlayer1("A0")
            let currentSpace: String = returnPlayerSpace(player: whosTurn)
            
            // create space number
            var spaceNumber: String = currentSpace // "A0" // space number masih "A0" // space number become 0
            
            // firstCharacter adalah hasil dari remove an spaceNumber, dimana space number meremove A
            let firstCharacter: Character = spaceNumber.remove(at: spaceNumber.startIndex) //get "A"
            
            // step of moving node
            let nextNumber: Int = Int(spaceNumber)! + 1 // 1 karena akan berpindah setiap node 1 langkah, spaceNumber menjadi "0", karena di firstCharacter telah dihapus
            
            if nextNumber > 16 {
                let nextNumber = 1
                let nextSpace: String = String(firstCharacter) + String(nextNumber) // "A1"
                
                for node in children {
                    if (node.name == nextSpace) {
                        let moveAction: SKAction = SKAction.move(to: node.position, duration: 0.5)
                        moveAction.timingMode = .easeOut
                        let wait: SKAction = SKAction.wait(forDuration: 0.2)
                        
                        let runAction: SKAction = SKAction.run {
                            self.setThePlayerSpace(space: nextSpace, player: self.whosTurn) // nextSpace = "A1", .Player1
                            self.movesRemaining = self.movesRemaining - 1
                            
                            self.movePiece()
                        }
                        
                        returnPlayerPiece(player: whosTurn).run(SKAction.sequence([moveAction, wait, runAction]))
                    }
                }
            } else {
                let nextSpace: String = String(firstCharacter) + String(nextNumber) // "A1"
                
                for node in children {
                    if (node.name == nextSpace) {
                        let moveAction: SKAction = SKAction.move(to: node.position, duration: 0.5)
                        moveAction.timingMode = .easeOut
                        let wait: SKAction = SKAction.wait(forDuration: 0.2)
                        
                        let runAction: SKAction = SKAction.run {
                            self.setThePlayerSpace(space: nextSpace, player: self.whosTurn) // nextSpace = "A1", .Player1
                            self.movesRemaining = self.movesRemaining - 1
                            
                            self.movePiece()
                        }
                        
                        returnPlayerPiece(player: whosTurn).run(SKAction.sequence([moveAction, wait, runAction]))
                    }
                }
            }
            
        } else {
            if (whosTurn == .Player1) {
                whosTurn = .Player2
            } else {
                whosTurn = .Player1
            }
        }
    }

    
    func returnPlayerPiece(player: Player) -> SKSpriteNode {
        var playerPiece: SKSpriteNode = SKSpriteNode()
        
        if (player == .Player1) {
            playerPiece = player1Piece // node playerPiece = player1Piece
        } else if (player == .Player2) {
            playerPiece = player2Piece
        }
        
        return playerPiece
    }
    
    func setThePlayerSpace(space: String, player: Player) {
        
        if (player == .Player1) {
            currentSpacePlayer1 = space // currentSpacePlayer1 menjadi "A1"
        } else if (player == .Player2) {
            currentSpacePlayer2 = space
        }
        
    }
    
    // return to the start node player
    func returnPlayerSpace(player: Player) -> String {
        // membuat string kosong
        var space: String = ""
        
        // player 1 being indetified
        if (player == .Player1) {
            // A0
            space = currentSpacePlayer1
        } else if (player == .Player2) {
            // A0
            space = currentSpacePlayer2
        }
        
        return space
        
    }
    
    func buttonHandler(index: Int) {
        if gameState == .ongoing {
            
//            gameState = .paused
            var num = 1
            let runNum = Int.random(in: 1...5)
            
            movesRemaining = runNum
            scoreLabel = SKLabelNode()
            
//            self.playerLabel = SKLabelNode()
//            self.playerLabel.fontSize = 60.0
            
            
            scoreLabel.fontSize = 200.0
            

            scoreLabel.text = String(num)
//            playerLabel.text = "Player 1 Turn"
            
            let wait = SKAction.wait(forDuration: 0.2)
            let waitSeq = SKAction.wait(forDuration: (Double(runNum) * 0.6))
//            let waitPlayer = SKAction.wait(forDuration: (Double(runNum) * 0.6))
            let block = SKAction.run {
                num = num + 1
                self.scoreLabel.text = "\(num - 1)"
            }
            
            let sequence = SKAction.sequence([wait, block])
            scoreLabel.run(SKAction.repeat(sequence, count: runNum))
            
            let act = SKAction.run {
                self.scoreLabel.removeFromParent()
                self.movePiece()
            }
            
//            let showPlayer = SKAction.run {
//                self.playerLabel.text = "Player 2 Turn"
//            }
            
            let seq = SKAction.sequence([waitSeq, act])
//            let ply = SKAction.sequence([waitPlayer, showPlayer])
            
            scoreLabel.run(SKAction.repeatForever(seq))
//            playerLabel.run(SKAction.repeatForever(ply))
            
            scoreLabel.scale(to: size, width: false, multiplier: 0.1)
            scoreLabel.position = CGPoint(x: frame.midX, y: frame.maxY - size.height*0.5)
            scoreLabel.zPosition = GameConstants.ZPositions.hudZ
            addChild(scoreLabel)
            
//            createAndShowPopup(type: 0, title: GameConstants.StringConstants.pausedKey)
//
//            playerLabel.scale(to: size, width: false, multiplier: 0.1)
//            playerLabel.position = CGPoint(x: frame.midX, y: frame.maxY - size.height*0.5)
//            playerLabel.zPosition = GameConstants.ZPositions.hudZ
//            addChild(playerLabel)
        }
    }
    
    func showRoll() {
        
        let pauseButton = SpriteKitButton(defaultButtonImage: GameConstants.StringConstants.diceTap, action: buttonHandler, index: 0)
        pauseButton.scale(to: frame.size, width: false, multiplier: 0.09)
        pauseButton.position = CGPoint(x: frame.midX, y: frame.maxY - pauseButton.size.height/0.15)
        pauseButton.zPosition = GameConstants.ZPositions.hudZ
        addChild(pauseButton)
    }
    
    func createAndShowPopup(type: Int, title: String) {
        switch type {
        case 0:
            // pause
            popup = RollPopup(withTitle: title, and: SKTexture(imageNamed: GameConstants.StringConstants.diceSelector), buttonHandlerDelegate: self)
        default:
            print("none")

        }
        popup!.position = CGPoint(x: frame.midX, y: frame.midY)
        popup!.zPosition = GameConstants.ZPositions.hudZ
        popup!.scale(to: frame.size, width: true, multiplier: 0.8)
        addChild(popup!)
    }
    
//    override func update(_ currentTime: CFTimeInterval) {
//        <#code#>
//    }
}

extension GameScene: PopupButtonHandlerDelegate {

    func popupButtonHandler(index: Int) {
        switch index {
        case 0:
            //Menu
            sceneManagerDelegate?.presentMenuScene()
        case 1:
            //Play
            sceneManagerDelegate?.presentLevelScene(for: world)
        case 2:
            //Cancel
            popup!.run(SKAction.fadeOut(withDuration: 0.2), completion: {
                self.popup!.removeFromParent()
                self.gameState = .ongoing
            })
        default:
            break
        }
    }

}

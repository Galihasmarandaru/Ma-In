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

class GameScene: SKScene {
    
    var playerCash: [Double] = [400_000, 400_000]
    var playerInsurance = [[false, false, false, false],[false, false, false, false]]
    
    // declare string player position
    var currentSpacePlayer1: String = "A0"
    var currentSpacePlayer2: String = "A0"
    
    // move step
    var moves: Int = 10
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

    }
    
    // when being click
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        movesRemaining = moves

        movePiece()
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
    
    // everytime player pass go(cutting down your income everytime pass go)
    func playerPassGo(player: Player){
        var given: Double = 50_000
        
        // player identification
        if (player == .Player1) {
            given -= countPremium(player: .Player1)
            playerCash[0] += given
        } else if (player == .Player2) {
            given -= countPremium(player: .Player2)
            playerCash[1] += given
            
        }
        
    }
    
    
    
    // cutting down your cash every turn / cutting down your income every time pass go
    func countPremium (player: Player) -> Double {
        var premium: Double = 0
        var i = 0
        
        // player identification
        if (player == .Player1) {
            
            // validation of each type of player 1 insurance
            while (i < 4) {
                if (playerInsurance[0][i]) {
                    premium += 2_000
                }
                i += 1
            }
        } else if (player == .Player2) {
            
            // validation of each type of player 2 insurance
            while (i < 4) {
                if (playerInsurance[1][i]) {
                    premium += 2_000
                }
                i += 1
            }
        }
        return premium
    }
    
    // everytime player landed on Move freely space or A9
    func moveFreely (player: Player) {
        
        if (player == .Player1) {
            
        } else if (player == .Player2) {
            
        }
        
    }
    
//    override func update(_ currentTime: CFTimeInterval) {
//        <#code#>
//    }
}

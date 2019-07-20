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
    
    //Validations of Income or Outcome
    var isIncome = [false,false]
    
    // player's cash data dynacmically
    var player1Cash: Double = 400_000{
        didSet{
            self.player1CashLabel.text = "$\(self.player1Cash)"
        }
    }
    var player2Cash: Double = 400_000{
        didSet{
            self.player2CashLabel.text = "$\(self.player2Cash)"
        }
    }
    
    var player1CashChange: Double = 0{
        didSet{
            self.player1CashChangeLabel.text = "+$\(self.player1CashChange)"
        }
    }
    
    var player2CashChange: Double = 0{
        didSet{
            self.player2CashChangeLabel.text = "+$\(self.player2CashChange)"
        }
    }
    
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
    
    // create the Player HUD
    var player1CashLabel: SKLabelNode = SKLabelNode()
    var player2CashLabel: SKLabelNode = SKLabelNode()
    var player1CashChangeLabel: SKLabelNode = SKLabelNode()
    var player2CashChangeLabel: SKLabelNode = SKLabelNode()
    
    
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
            player1Cash += given
            player1CashChange = given
            isIncome[0] = true
        } else if (player == .Player2) {
            given -= countPremium(player: .Player2)
            player2Cash += given
            player2CashChange = given
            isIncome[1] = true
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
    
    func mysteryCardRoll(player: Player){
        var rngMysteryCard = Int.random(in: 1...10)
        let given200: Double = 200_000
        // animation start
        // ......
        switch rngMysteryCard {
        // Back to Start
        case 1:
            if (player == .Player1){
                
            } else if (player == .Player2) {
                
            }
        // Enemies Back to Start
        case 2:
            if (player == .Player1){
                
            } else if (player == .Player2) {
                
            }
        // Go to Insurance you want
        case 3:
            if (player == .Player1){
                
            } else if (player == .Player2) {
                
            }
        // Enemies go to Insurance
        case 4:
            if (player == .Player1){
                
            } else if (player == .Player2) {
                
            }
        // Go to Surgery
        case 5:
            if (player == .Player1){
                
            } else if (player == .Player2) {
                
            }
        // Enemies go to Surgery
        case 6:
            if (player == .Player1){
                
            } else if (player == .Player2) {
                
            }
        // Get Money 200K
        case 7:
            if (player == .Player1){
                player1Cash += given200
                player1CashChange = given200
                isIncome[0] = true
            } else if (player == .Player2) {
                player2Cash += given200
                player2CashChange = given200
                isIncome[1] = true
            }
        // Enemy got money 200K
        case 8:
            if (player == .Player1){
                player2Cash += given200
                player2CashChange = given200
                isIncome[1] = true
            } else if (player == .Player2) {
                player1Cash += given200
                player1CashChange = given200
                isIncome[0] = false
            }
        // Go to Flooding
        case 9:
            if (player == .Player1){
                
            } else if (player == .Player2) {
                
            }
        // Enemy go to Flooding
        case 10:
            if (player == .Player1){
                
            } else if (player == .Player2) {
                
            }
        default: break;
        }
    }
    
    func accident(player: Player, currentSpace: String){
        switch currentSpace {
        case "Flooding":
            break;
        default:
            break;
        }
    }
    
//    override func update(_ currentTime: CFTimeInterval) {
//        <#code#>
//    }
}

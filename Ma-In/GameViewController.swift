//
//  GameViewController.swift
//  Ma-In
//
//  Created by Galih Asmarandaru on 18/07/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

var backgroundMusicPlayer: AVAudioPlayer!

class GameViewController: UIViewController {    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        presentMenuScene()
        playSounds()
    }
    
    func playSounds() {
        let path = Bundle.main.path(forResource: "bg", ofType: "mp3")
        let url = URL(fileURLWithPath: path!)
        backgroundMusicPlayer = try! AVAudioPlayer(contentsOf: url)
        backgroundMusicPlayer.numberOfLoops = -1
        backgroundMusicPlayer.play()

    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension GameViewController: SceneManagerDelegate {
    
    func presentLevelScene(for world: Int) {
        let scene = GameScene(size: view.bounds.size)
//        scene.scaleMode = .aspectFill
//        scene.world = world
        scene.sceneManagerDelegate = self
        present2(scene: scene)
    }
    
//    func presentGameScene(for level: Int, in world: Int) {
//        <#code#>
//    }
//
    func presentMenuScene() {
        let scene = OpeningClass(size: view.bounds.size)
//        scene.scaleMode = .aspectFill
        scene.sceneManagerDelegate = self
        present(scene: scene)
    }
    
    func present(scene: SKScene) {
        if let view = self.view as! SKView? {
            
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
            view.showsPhysics = false
        }
    }
    
    func present2(scene: SKScene) {
        if let view = self.view as! SKView? {
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
                
                view.ignoresSiblingOrder = true
            }
        }
    }

}

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
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var buttonRoll: UIButton!
    
    var items:[String] = ["1", "2", "3", "4", "5", "6"]
//    var scrollTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
        }
        
//        playSounds()
        setupCollectionView()
    }
    
//    func playSounds() {
//        let path = Bundle.main.path(forResource: "background", ofType: "wav")
//        let url = URL(fileURLWithPath: path!)
//        backgroundMusicPlayer = try! AVAudioPlayer(contentsOf: url)
//        backgroundMusicPlayer.numberOfLoops = -1
//        backgroundMusicPlayer.play()
//
//    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension GameViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionView", for: indexPath) as? collectionRoll else { return UICollectionViewCell() }
        
        cell.rollCollection.text = self.items[indexPath.item]
        
        //Rekursif
        
//        var rowIndex = indexPath.row
//        let numberOfRecord: Int = self.items.count - 1
//
//        if (rowIndex < numberOfRecord) {
//            rowIndex = rowIndex + 1
//        } else {
//            rowIndex = 0
//        }
//
//        scrollTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.startTimer(theTimer:)), userInfo: rowIndex, repeats: true)
        
        return cell
    }
    
//    @objc func startTimer(theTimer: Timer) {
//        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveLinear,.repeat], animations: {
//            self.collectionView.scrollToItem(at: IndexPath(row: theTimer.userInfo! as! Int, section: 0), at: .centeredHorizontally, animated: false)
//        }, completion: nil)
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")
    }
}

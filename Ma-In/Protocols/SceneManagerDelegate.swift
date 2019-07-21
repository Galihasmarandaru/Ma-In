//
//  SceneManagerDelegate.swift
//  Ma-In
//
//  Created by Galih Asmarandaru on 20/07/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation

protocol SceneManagerDelegate {
    
    func presentLevelScene(for world: Int)
//    func presentGameScene(for level: Int, in world: Int)
    func presentMenuScene()
    
}

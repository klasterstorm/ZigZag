//
//  GameViewController.swift
//  ZigZag
//
//  Created by Даниленко Данила Сергеевич on 18.12.2019.
//  Copyright © 2019 Даниленко Данила Сергеевич. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            let testScene = GameScene()
            testScene.size = view.bounds.size
            testScene.scaleMode = SKSceneScaleMode.aspectFill
            testScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            view.presentScene( testScene )
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

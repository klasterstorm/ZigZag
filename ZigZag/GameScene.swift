//
//  GameScene.swift
//  ZigZag
//
//  Created by Даниленко Данила Сергеевич on 18.12.2019.
//  Copyright © 2019 Даниленко Данила Сергеевич. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    
    var player = SKSpriteNode()
    var images: [UIImage] = []
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        images = downloadImages(imagePath: "1")

        backgroundColor = SKColor.white
        createSmallBlocks(blockCount: 5)
       
    }
    
    func createSmallBlocks(blockCount: Int){
        let randomIcons = images[randomPick: blockCount]
        
        
        var sizePlus = 0
        var i = 0
        let blockSize = Int(UIScreen.main.bounds.width)/5
        
        if blockCount % 2 == 0 {
            sizePlus = blockSize*((blockCount+2)/2)-blockSize/2
        } else {
            sizePlus = blockSize*((blockCount+2)/2)
        }
        for icon in randomIcons {
            i = i + 1
            let texture = SKTexture(image: icon)
            player = SKSpriteNode(texture: texture)
//            player.color = UIColor.red
//            player.colorBlendFactor = 1.0
            player.size = CGSize(width: blockSize-blockSize/10, height: blockSize-blockSize/10)
            player.position = CGPoint(x: blockSize*i-sizePlus, y: Int(-UIScreen.main.bounds.height/1.5))
            addChild(player)
        }
    }
    
    
    func downloadImages(imagePath: String) -> [UIImage] {
        var imageArray: [UIImage] = []
        for i in 1...50 {
            if let bundlePath = Bundle.main.path(forResource: String(i), ofType: "png") {
                if let image = UIImage(contentsOfFile: bundlePath) {
                    imageArray.append(image)
                }
            }
        }
        return imageArray
    }
    
    
}
extension Array {
    /// Picks `n` random elements (partial Fisher-Yates shuffle approach)
    subscript (randomPick n: Int) -> [Element] {
        var copy = self
        for i in stride(from: count - 1, to: count - n - 1, by: -1) {
            copy.swapAt(i, Int(arc4random_uniform(UInt32(i + 1))))
        }
        return Array(copy.suffix(n))
    }
}

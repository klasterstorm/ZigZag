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
    
    
    var images: [UIImage] = []
    
// Рандомим размер поля [1x5, 2x5, 3x5, 4x5, 5x5]
// Рандомим от размера поле длину пиктограммы
// Повторяем 3 раза и рандомим заново размер поля
    
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        images = downloadImages()

        backgroundColor = SKColor.white
        
        
    }
    
    func initGame(){
        createBlocks(pook: 3)
        createSmallBlocks(blockCount: 8)
    }
    
    func createBlocks(pook: Int) {
        for i in -2...2 {
            for j in 0...pook {
                let node = Block(image: images.randomElement()!,
                                 position: CGPoint(x: Helper.shared.getConstaint(key: .blockSize)*i,
                                                   y: Helper.shared.getConstaint(key: .blockSize)*j-(Helper.shared.getConstaint(key: .blockSize)/2*pook)))
                self.addChild(node)
            }
        }
    }
    
    
    
    func createSmallBlocks(blockCount: Int){
        let randomIcons = images[randomPick: blockCount]
        
        
        var sizePlus = 0
        var i = 0
        let blockSize = Int(UIScreen.main.bounds.width)/(blockCount+2)
        
        if blockCount % 2 == 0 {
            sizePlus = blockSize*((blockCount+2)/2)-blockSize/2
        } else {
            sizePlus = blockSize*((blockCount+2)/2)
        }
        for icon in randomIcons {
            i = i + 1
            let texture = SKTexture(image: icon)
            let smallBlock = SKSpriteNode(texture: texture)
//            player.color = UIColor.red
//            player.colorBlendFactor = 1.0
            smallBlock.size = CGSize(width: blockSize-blockSize/10, height: blockSize-blockSize/10)
            smallBlock.position = CGPoint(x: blockSize*i-sizePlus, y: Int(-UIScreen.main.bounds.height/2.8))
            addChild(smallBlock)
        }
    }
    
    
    func downloadImages() -> [UIImage] {
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

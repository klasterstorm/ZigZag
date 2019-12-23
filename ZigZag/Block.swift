//
//  Block.swift
//  ZigZag
//
//  Created by Даниленко Данила Сергеевич on 22.12.2019.
//  Copyright © 2019 Даниленко Данила Сергеевич. All rights reserved.
//

import Foundation
import SpriteKit

class Block: SKSpriteNode {
    
    let blockSize = Double(Helper.shared.getConstaint(key: .blockSize))/1.1
    var i = 0
    var j = 0
    var isMoving = false
    
    init(image: UIImage, position: CGPoint, i: Int, j: Int) {
        super.init(texture: nil,
                   color: UIColor.clear,
                   size: CGSize(width: blockSize,
                                height: blockSize))
        
        self.position = position
        
        let texture = SKTexture(image: image)
        let block = SKSpriteNode(texture: texture,
                                 size: CGSize(width: blockSize,
                                              height: blockSize))
        block.isUserInteractionEnabled = false
        self.i = i
        self.j = j
        self.addChild(block)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func colorize(){
        let colorize = SKAction.colorize(with: UIColor.red, colorBlendFactor: 1, duration: 0.05)
        self.run(colorize)
    }

    func invertColorize(){
        self.removeAllActions()
        self.color = UIColor.clear
    }
}


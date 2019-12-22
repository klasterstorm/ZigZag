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
    
    init(image: UIImage, position: CGPoint) {
        super.init(texture: nil,
                   color: UIColor.white,
                   size: CGSize(width: blockSize,
                                height: blockSize))
        
        self.position = position
        
        let texture = SKTexture(image: image)
        let block = SKSpriteNode(texture: texture,
                                 size: CGSize(width: blockSize,
                                              height: blockSize))
        self.addChild(block)
        
        print(Int(UIScreen.main.bounds.width/getCef()))
        print(Int(UIScreen.main.bounds.width))
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


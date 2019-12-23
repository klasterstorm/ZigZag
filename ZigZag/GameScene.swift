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
    var fieldSize = 0
    var imagesOnField: [UIImage] = []
    
// Рандомим размер поля [1x5, 2x5, 3x5, 4x5, 5x5]
// Рандомим от размера поле длину пиктограммы
// Повторяем 3 раза и рандомим заново размер поля
    
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        images = downloadImages()
        backgroundColor = SKColor.white
        initGame()
        initAttempt()
    }
    
     var firstNode: Block? = nil
    
    
    /// Меняет два выбранных нода местами
    func swapNodes(nodeOne: Block, nodeTwo: Block){
           nodeOne.colorize()
           let move = SKAction.move(to: nodeOne.position, duration: 0.3)
           let move2 = SKAction.move(to: nodeTwo.position, duration: 0.3)
           let i = nodeOne.i
           let j = nodeOne.j
           nodeOne.i = nodeTwo.i
           nodeOne.j = nodeTwo.j
           nodeTwo.i = i
           nodeTwo.j = j
           move.timingMode = .easeIn
           move2.timingMode = .easeIn
           nodeTwo.run(move, completion: {
               nodeTwo.invertColorize()
               nodeTwo.isMoving = false
           })
           nodeOne.run(move2,completion: {
               nodeOne.invertColorize()
               nodeOne.isMoving = false
           })
       }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan")
        let touch = touches.first
        let positionInScene = touch?.location(in: self.scene!)
        let touchedNode = self.atPoint(positionInScene!)
        if let touchedNode = touchedNode as? Block {
            if touchedNode.isMoving == false {
                if firstNode != nil && firstNode?.isMoving == false {
                    if firstNode != touchedNode {
                        print("touchesBegan 1")
                        firstNode!.isMoving = true
                        touchedNode.isMoving = true
                        swapNodes(nodeOne: touchedNode, nodeTwo: firstNode!)
                        firstNode = nil
                    }
                } else {
                    if touchedNode.isMoving == false {
                        touchedNode.colorize()
                        firstNode = touchedNode
                        print("touchesBegan 2")
                    }
                }
            }
        } else if let touchedNode = touchedNode.parent as? Block {
            if touchedNode.isMoving == false {
                if firstNode != nil && firstNode?.isMoving == false  {
                    if firstNode != touchedNode {
                        print("touchesBegan 3")
                        firstNode!.isMoving = true
                        touchedNode.isMoving = true
                        swapNodes(nodeOne: touchedNode, nodeTwo: firstNode!)
                        firstNode = nil
                    }
                } else {
                    if touchedNode.isMoving == false {
                        touchedNode.colorize()
                        firstNode = touchedNode
                        print("touchesBegan 4")
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesMoved")
        let touch = touches.first
        let positionInScene = touch?.location(in: self.scene!)
        let touchedNode = self.atPoint(positionInScene!)
        if let touchedNode = touchedNode as? Block {
            if !touchedNode.isMoving {
                print("touchesMoved 2")
            }
        } else if let touchedNode = touchedNode.parent as? Block {
            if !touchedNode.isMoving {
                print("touchesMoved 2")
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesEnded")
        let touch = touches.first
        let positionInScene = touch?.location(in: self.scene!)
        let touchedNode = self.atPoint(positionInScene!)
        if let touchedNode = touchedNode as? Block {
            if !touchedNode.isMoving {
                print("touchesEnded 2")
            }
        } else if let touchedNode = touchedNode.parent as? Block {
            if !touchedNode.isMoving {
                print("touchesEnded 2")
            }
        }
    }
    
    func initGame(){
        fieldSize = Int.random(in: 0...4)
        createBlocks(size: fieldSize)
    }
    
    func initAttempt(){
        for child in self.children {
            if child.name == "smallBlock" {
                child.removeAllActions()
                child.removeAllChildren()
                child.removeFromParent()
            }
        }
        let blockCount = Int.random(in: 4...4+fieldSize)
        createSmallBlocks(blockCount: blockCount,
                          randomIcons: imagesOnField[randomPick: blockCount])
    }
    
    func createBlocks(size: Int) {
        imagesOnField.removeAll()
        for i in -2...2 {
            for j in 0...size {
                let image = images.randomElement()
                let node = Block(image: image!,
                                 position: CGPoint(x: Helper.shared.getConstaint(key: .blockSize)*i,
                                                   y: Helper.shared.getConstaint(key: .blockSize)*j-(Helper.shared.getConstaint(key: .blockSize)/2*size)),
                                 i: i, j: j)
                self.imagesOnField.append(image!)
                self.addChild(node)
            }
        }
    }
    
    func createSmallBlocks(blockCount: Int, randomIcons: [UIImage]){
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
            smallBlock.name = "smallBlock"
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

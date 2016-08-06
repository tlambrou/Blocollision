//
//  StageH.swift
//  bloctorials
//
//  Created by Tassos Lambrou on 7/9/16.
//  Copyright © 2016 Ssos Games. All rights reserved.
//

import Foundation
import SpriteKit


class StageH: SKSpriteNode {
    
    
    /* Grid array dimensions */
    let spaces = columns
    var stageArray: [Block] = []
    
    var cellWidth = 0
    var cellHeight = 0
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        /* Enable own touch implefmentation for this node */
        userInteractionEnabled = true
        
        /* Calculate individual cell dimensions */
        cellWidth = Int(self.size.width) / spaces
        
        cellHeight = Int(self.size.height)
        
        /* Populate grid with blocks */
        for stageX in 0..<spaces {
            let block = Block()
            //Convert the row/column position into a stage screen position
            block.position.x = CGFloat(stageX*cellWidth + (cellWidth/2))
            block.position.y = CGFloat(0 + CGFloat((cellHeight/2)))
            
            block.size.width = CGFloat(cellWidth)*0.87
            block.size.height = CGFloat(cellHeight)*0.87
            
            //Add block as a child of the grid node
            addChild(block)
            
            //Add block to the stageArray at the x,y position
            stageArray.append(block)
            
//            randomActiveBlock(stageX)
            
//            let x = block.position.x
//            let y = block.position.y
//            let labelX = SKLabelNode(text: "\(x)")
//            labelX.fontName = "Helvetica"
//            labelX.fontSize = 40
//            labelX.zPosition = 100
//            block.addChild(labelX)
//            let labelY = SKLabelNode(text: "\(y)")
//            labelY.fontName = "Helvetica"
//            labelY.fontSize = 40
//            labelY.position.offset(dx: CGFloat(0), dy: CGFloat(-45))
//            labelY.zPosition = 100
//            block.addChild(labelY)
        }

        
        
    }
    
    
    func addBlockToEmptyStage() {
        var blockCreated: Bool = false
        var rand = Int.random(spaces)
        var block = stageArray[rand]
        var index = 0
        
        while blockCreated == false {
            if block.state == .inactive {
                let typeRand = Int.random(3)+1
                switch typeRand {
                //case 0?
                case 1:
                    block.state = .red
                    block.stack = 5
                case 2:
                    block.state = .blue
                    block.stack = 5
                case 3:
                    block.state = .green
                    block.stack = 5
                default:
                    print("switch statement in addBlockToEmptyStage didn't work")
                }
                
                blockCreated = true
            } else if block.state != .inactive && index < spaces{
                rand = Int.random(spaces)
                block = stageArray[rand]
                index += 1
            } else {
                break
            }
            
        }
    }
    
    func stageRegen() {
        
        for gridSpace in 0..<spaces {
            
            if stageArray[gridSpace].state == .inactive {
                
                randomActiveBlock(gridSpace)
                
            }
        }
        
    }
    
    
    func randomActiveBlock(x: Int) {
        var blockCreated: Bool = false
        let block = stageArray[x]
        
        while blockCreated == false {
            if block.state == .inactive {
                let typeRand = Int.random(3)+1
                switch typeRand {
                //case 0?
                case 1:
                    block.state = .red
                    block.stack = 5
                case 2:
                    block.state = .blue
                    block.stack = 5
                case 3:
                    block.state = .green
                    block.stack = 5
                default:
                    print("switch statement in addBlockToEmptyGrid didn't work")
                }
                
                blockCreated = true
                
            }
        }
    }

    
}

    
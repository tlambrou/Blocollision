//
//  Grid.swift
//  iSoBlocks
//
//  Created by Tassos Lambrou on 7/9/16.
//  Copyright © 2016 SsosSoft. All rights reserved.
//

import Foundation
import SpriteKit

let rows = 3
let columns = 3

var cellWidth = 0
var cellHeight = 0


class Grid: SKSpriteNode {
    
    
    /* Grid array dimensions */
    
    /* Individual cell dimension, calculated in setup*/
    var label:SKLabelNode!
    
    /* block Array */
    var gridArray = [[Block]]()
    //
    //    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    //        /* Called when a touch begins */
    //
    //        /* There will only be one touch as multi touch is not enabled by default */
    //
    //        for touch in touches {
    //
    //            /* Grab position of touch relative to the grid */
    //            let location  = touch.locationInNode(self)
    //
    //            /* Calculate grid array position */
    //            let gridX = Int(location.x) / cellWidth
    //            let gridY = Int(location.y) / cellHeight
    //
    //        }
    //
    //
    //    }
    //}
    
    /* You are required to implement this for your subclass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        /* Enable own touch implementation for this node */
        isUserInteractionEnabled = true
        
        /* Calculate individual cell dimensions */
        cellWidth = Int(size.width) / columns
        cellHeight = Int(size.height) / rows
        /* Populate grid with blocks */
        populateGrid()
    }
    
    
    func populateGrid() {
        /* Populate the grid with blocks */
        
        /* Loop through columns */
        for gridX in 0..<columns {
            
            /* Initialize empty column */
            gridArray.append([])
            
            /* Loop through rows */
            for gridY in 0..<rows {
                
                /* Create a new block at row / column position */
                addBlockAtGrid(x:gridX, y:gridY)
//                randomActiveBlock(gridX, y: gridY)
            }
        }
    }
    
    func addBlockAtGrid(x: Int, y: Int) {
        //Initialize a new block object
        let block = Block()
        
        //Convert the row/column position into a grid screen position
        let gridPosition = CGPoint(x: x*cellWidth + (cellWidth/2), y: y*cellHeight + (cellHeight/2))
        block.position = gridPosition

        block.size.width = CGFloat(cellWidth)*0.87
        block.size.height = CGFloat(cellHeight)*0.87
//        block.xScale = CGFloat((320.0/CGFloat(rows))/(60.0))
//        block.yScale = CGFloat((320.0/CGFloat(columns))/(60.0))
        
        //Add block as a child of the grid node
        addChild(block)
        
       
        
//        let label = SKLabelNode(text: "\(x),\(y)")
//        label.fontSize = 40
//        label.zPosition = 100
//        block.addChild(label)
        
        //Add block to the gridArray at the x,y position
        gridArray[x].append(block)
        
        
    }
    
    func randomActiveBlock(_ x: Int, y: Int) {
        var blockCreated: Bool = false
        let block = gridArray[x][y]
        let factorialValue = factorialWeights()
        
        while blockCreated == false {
            if block.state == .inactive {
                let typeRand = Int.random(numBlocks)+1
                switch typeRand {
                case 1:
                    block.state = .red
                    block.stack = factorialValue
                case 2:
                    block.state = .blue
                    block.stack = factorialValue
                case 3:
                    block.state = .green
                    block.stack = factorialValue
                case 4:
                    block.state = .yellow
                    block.stack = factorialValue
                default:
                    print("switch statement in randomActiveBlock() didn't work")
                }
                
                blockCreated = true
            
            }
        }
    }
    
    
    
    func countBlocks(_ blockstate: BlockType) -> Int{
        /* Process array and update block status */
        var population: Int = 0
        
        
        
        /* Loop through columns */
        for gridX in 0..<columns {
            
            /* Loop through rows */
            for gridY in 0..<rows {
                
                if gridArray[gridX][gridY].state == blockstate {
                    population += 1
                    
                    
                }
            }
        }
        return population
    }
    
    
        
}

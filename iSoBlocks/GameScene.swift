//
//  GameScene.swift
//  iSoBlocks
//
//  Created by Tassos Lambrou on 7/9/16.
//  Copyright (c) 2016 Ssos Games. All rights reserved.
//

import SpriteKit

enum swipeType {
    case up, down, left, right
}

class GameScene: SKScene {
    
    var gridNode: Grid!
    var topStageNode: StageH!
    var bottomStageNode: StageH!
    var leftStageNode: StageV!
    var rightStageNode: StageV!
    var restartButton: MSButtonNode!
    
    
    func swipedUp(sender:UISwipeGestureRecognizer) {
        swipe(.up)
    }
    
    func swipedDown(sender:UISwipeGestureRecognizer) {
        swipe(.down)
    }
    
    func swipedLeft(sender:UISwipeGestureRecognizer) {
        swipe(.left)
    }
    
    func swipedRight(sender:UISwipeGestureRecognizer) {
        swipe(.right)
    }
    
    
//    func swipedUp(sender:UISwipeGestureRecognizer){
//        let preSwipeGrid = gridNode
//        
//        
//        // loop through the columns
//        for gridX in 0..<columns{
//            
//            // loop through the rows
//            for gridY in (rows-1).stride(through: 1, by: -1) {
//                
//                // Is the row we're on, on the edge (aka wall row)?
//                if gridY == rows-1 {
//                    let dummyType: BlockType = .inactive
//                    gridNode.gridArray[gridX][gridY].stacked = true
//                    
//                    // If block along the wall is active...
//                    if preSwipeGrid.gridArray[gridX][gridY].state != dummyType  {
//                        
//                        // If the adjacent block is inactive...
//                        if preSwipeGrid.gridArray[gridX][gridY-1].state == dummyType {
//                            
//                            // Do not change the value if on the wall and adjacent value is inactive
//                            gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX][gridY].state
//                        }
//                            
//                            //Otherwise if the adjacent block is active...
//                        else if preSwipeGrid.gridArray[gridX][gridY-1].state != dummyType {
//                            // APPLY COLLISION RULES!!
//                            let block1: BlockType = preSwipeGrid.gridArray[gridX][gridY].state
//                            let block2: BlockType = preSwipeGrid.gridArray[gridX][gridY-1].state
//                            
//                            
//                            if block1 == block2 {
//                                gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX][gridY].state
//                            } else {
//                                gridNode.gridArray[gridX][gridY].state = battle(block1, block2: block2)
//                            }
//                        }
//                    }
//                        
//                        //Otherwise if the block along the wall is inactive...
//                    else if preSwipeGrid.gridArray[gridX][gridY].state == dummyType {
//                        
//                        // Change the value to the adjacent cell's value
//                        gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX][gridY-1].state
//                        
//                    }
//                    
//                } else {
//                    //                    let block0 = gridNode.gridArray[gridX][gridY+1]
//                    //                    let block1 = gridNode.gridArray[gridX][gridY]
//                    //                    let block2 = gridNode.gridArray[gridX][gridY-1]
//                    //
//                    //                    // check to see if block above is immoveable and is the same
//                    //                    if block0.stackedUp == true && block1.state == block0.state {
//                    //
//                    //                        gridNode.gridArray[gridX][gridY].state =
//                    //                    }
//                    //set the value of the gridArray equal to the value at the previous row (no conditional)
//                    //stops at the last row (can't have a row = -1)
//                    
//                    gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX][gridY-1].state
//                }
//            }
//            
//            //set the zeroith row equal to what's in the stage
//            
//            gridNode.gridArray[gridX][0].state = bottomStageNode.stageArray[gridX].state
//            
//            //reset the stage to all .inactive
//            
//            bottomStageNode.stageArray[gridX].state = .inactive
//        }
//        
//        //add a new block to the empty stage
//        
//        bottomStageNode.addBlockToEmptyStage()
//        
//    }
//    
//    
//    
//    func swipedDown(sender:UISwipeGestureRecognizer){
//        let preSwipeGrid = gridNode
//        
//        //loop through the columns
//        for gridX in 0..<columns{
//            
//            //loop through the rows
//            for gridY in 0..<rows-1 {
//                
//                // Is the row we're on, on the edge (aka wall row)?
//                if gridY == 0 {
//                    let dummyType: BlockType = .inactive
//                    
//                    // If block along the wall is active...
//                    if preSwipeGrid.gridArray[gridX][gridY].state != dummyType  {
//                        
//                        // If the adjacent block is inactive...
//                        if preSwipeGrid.gridArray[gridX][gridY+1].state == dummyType {
//                            
//                            // Do not change the value if on the wall and adjacent value is inactive
//                            gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX][gridY].state
//                        }
//                            
//                            //Otherwise if the adjacent block is active...
//                        else if preSwipeGrid.gridArray[gridX][gridY+1].state != dummyType {
//                            
//                            // APPLY COLLISION RULES!!
//                            let block1: BlockType = preSwipeGrid.gridArray[gridX][gridY].state
//                            let block2: BlockType = preSwipeGrid.gridArray[gridX][gridY+1].state
//                            
//                            gridNode.gridArray[gridX][gridY].state = battle(block1, block2: block2)
//                        }
//                    }
//                        
//                        //Otherwise if the block along the wall is inactive...
//                    else if preSwipeGrid.gridArray[gridX][gridY].state == dummyType {
//                        
//                        // Change the value to the adjacent cell's value
//                        gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX][gridY+1].state
//                        
//                    }
//                    
//                } else {
//                    
//                    //set the value of the gridArray equal to the value at the previous row (no conditional)
//                    //stops at the last row (can't have a row = -1)
//                    
//                    gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX][gridY+1].state
//                }
//            }
//            
//            //set the top row equal to what's in the stage
//            
//            gridNode.gridArray[gridX][rows-1].state = topStageNode.stageArray[gridX].state
//            
//            //reset the stage to all .inactive
//            
//            topStageNode.stageArray[gridX].state = .inactive
//        }
//        
//        //add a new block to the empty stage
//        
//        topStageNode.addBlockToEmptyStage()
//        
//        
//    }
//    
//    func swipedLeft(sender:UISwipeGestureRecognizer){
//        
//        let preSwipeGrid = gridNode
//        
//        //loop through the rows
//        for gridY in 0..<rows{
//            
//            //loop through the columns
//            for gridX in 0..<columns-1 {
//                
//                
//                // Is the row we're on, on the edge (aka wall row)?
//                if gridX == 0 {
//                    let dummyType: BlockType = .inactive
//                    
//                    // If block along the wall is active...
//                    if preSwipeGrid.gridArray[gridX][gridY].state != dummyType  {
//                        
//                        // If the adjacent block is inactive...
//                        if preSwipeGrid.gridArray[gridX+1][gridY].state == dummyType {
//                            
//                            // Do not change the value if on the wall and adjacent value is inactive
//                            gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX][gridY].state
//                        }
//                            
//                            //Otherwise if the adjacent block is active...
//                        else if preSwipeGrid.gridArray[gridX+1][gridY].state != dummyType {
//                            
//                            // APPLY COLLISION RULES!!
//                            let block1: BlockType = preSwipeGrid.gridArray[gridX][gridY].state
//                            let block2: BlockType = preSwipeGrid.gridArray[gridX+1][gridY].state
//                            
//                            gridNode.gridArray[gridX][gridY].state = battle(block1, block2: block2)
//                        }
//                    }
//                        
//                        //Otherwise if the block along the wall is inactive...
//                    else if preSwipeGrid.gridArray[gridX][gridY].state == dummyType {
//                        
//                        // Change the value to the adjacent cell's value
//                        gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX+1][gridY].state
//                        
//                    }
//                    
//                } else {
//                    
//                    //set the value of the gridArray equal to the value at the previous row (no conditional)
//                    //stops at the last row (can't have a row = -1)
//                    
//                    gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX+1][gridY].state
//                }
//                
//                //set the value of the gridArray equal to the value at the previous column (no conditional)
//                //stops at the last column (can't have a column = -1)
//                
//                //gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX+1][gridY].state
//            }
//            
//            //set the top column equal to what's in the stage
//            
//            gridNode.gridArray[columns-1][gridY].state = rightStageNode.stageArray[gridY].state
//            
//            //reset the stage to all .inactive
//            
//            rightStageNode.stageArray[gridY].state = .inactive
//        }
//        
//        //add a new block to the empty stage
//        
//        rightStageNode.addBlockToEmptyStage()
//        
//    }
//    
//    func swipedRight(sender:UISwipeGestureRecognizer){
//        
//        let preSwipeGrid = gridNode
//        
//        //loop through the rows
//        for gridY in 0..<rows{
//            
//            //loop through the columns
//            for gridX in (columns-1).stride(through: 1, by: -1) {
//                
//                
//                // Is the row we're on, on the edge (aka wall row)?
//                if gridX == columns-1 {
//                    let dummyType: BlockType = .inactive
//                    
//                    // If block along the wall is active...
//                    if preSwipeGrid.gridArray[gridX][gridY].state != dummyType  {
//                        
//                        // If the adjacent block is inactive...
//                        if preSwipeGrid.gridArray[gridX-1][gridY].state == dummyType {
//                            
//                            // Do not change the value if on the wall and adjacent value is inactive
//                            gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX][gridY].state
//                        }
//                            
//                            //Otherwise if the adjacent block is active...
//                        else if preSwipeGrid.gridArray[gridX-1][gridY].state != dummyType {
//                            
//                            // APPLY COLLISION RULES!!
//                            let block1: BlockType = preSwipeGrid.gridArray[gridX][gridY].state
//                            let block2: BlockType = preSwipeGrid.gridArray[gridX-1][gridY].state
//                            
//                            gridNode.gridArray[gridX][gridY].state = battle(block1, block2: block2)
//                        }
//                    }
//                        
//                        //Otherwise if the block along the wall is inactive...
//                    else if preSwipeGrid.gridArray[gridX][gridY].state == dummyType {
//                        
//                        // Change the value to the adjacent cell's value
//                        gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX-1][gridY].state
//                        
//                    }
//                    
//                } else {
//                    
//                    //set the value of the gridArray equal to the value at the previous row (no conditional)
//                    //stops at the last row (can't have a row = -1)
//                    
//                    gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX-1][gridY].state
//                }
//                
//                //set the value of the gridArray equal to the value at the previous column (no conditional)
//                //stops at the last column (can't have a column = -1)
//                
//                //gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX-1][gridY].state
//            }
//            
//            //set the top column equal to what's in the stage
//            
//            gridNode.gridArray[0][gridY].state = leftStageNode.stageArray[gridY].state
//            
//            //reset the stage to all .inactive
//            
//            leftStageNode.stageArray[gridY].state = .inactive
//        }
//        
//        //add a new block to the empty stage
//        
//        leftStageNode.addBlockToEmptyStage()
//        
//    }
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        gridNode = childNodeWithName("gridNode") as! Grid
        topStageNode = childNodeWithName("topStage") as! StageH
        bottomStageNode = childNodeWithName("bottomStage") as! StageH
        leftStageNode = childNodeWithName("leftStage") as! StageV
        rightStageNode = childNodeWithName("rightStage") as! StageV
        /* Set UI connections */
        restartButton = self.childNodeWithName("restartButton") as! MSButtonNode
        
        topStageNode.addBlockToEmptyStage()
        bottomStageNode.addBlockToEmptyStage()
        leftStageNode.addBlockToEmptyStage()
        rightStageNode.addBlockToEmptyStage()
        
        restartButton.selectedHandler = {
            
            /* Grab reference to the SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Restart GameScene */
            skView.presentScene(scene)
        }
        
        let swipeRight:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipedRight(_:)))
        swipeRight.direction = .Right
        view.addGestureRecognizer(swipeRight)
        
        
        let swipeLeft:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipedLeft(_:)))
        swipeLeft.direction = .Left
        view.addGestureRecognizer(swipeLeft)
        
        
        let swipeUp:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipedUp(_:)))
        swipeUp.direction = .Up
        view.addGestureRecognizer(swipeUp)
        
        
        let swipeDown:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(GameScene.swipedDown(_:)))
        swipeDown.direction = .Down
        view.addGestureRecognizer(swipeDown)
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        //        for touch in touches {
        //
        //        }
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
    }
    
    func swipe(swipeDirection: swipeType) {
//        let preSwipeGrid:Grid = gridNode
        var xStart: Int
        var xEnd: Int
        var yStart: Int
        var yEnd: Int
        var xIncrement: Int = 1
        var yIncrement: Int = 1
//        var stage: AnyObject?
        var stageRegen: Bool = false
        
        
        switch swipeDirection {
        case .up:
            print("swiped up")
//            stage = bottomStageNode
            xStart = 0
            xEnd = columns-1
            yStart = rows-1
            yEnd = 0
            xIncrement = 1
            yIncrement = -1
            
        case .down:
            print("swiped down")
//            stage = topStageNode
            xStart = columns-1
            xEnd = 0
            yStart = 0
            yEnd = rows-1
            xIncrement = -1
            yIncrement = 1
            
        case .left:
            print("swiped left")
//            stage = rightStageNode
            xStart = 0
            xEnd = columns-1
            yStart = 0
            yEnd = rows-1
            xIncrement = 1
            yIncrement = 1
            
        case .right:
            print("swiped right")
//            stage = leftStageNode
            xStart = columns-1
            xEnd = 0
            yStart = rows-1
            yEnd = 0
            xIncrement = -1
            yIncrement = -1
            
            
        }
//        
//        if xStart > xEnd { xIncrement = -1 // down, right
//        } else if xStart < xEnd { xIncrement = 1 // up, left
//        } else if yStart > yEnd { yIncrement = -1 // up, right
//        } else if yStart < yEnd { yIncrement = 1 } // down, left
        
        // If direction of swipe is vertical...
        if (swipeDirection == .up) || (swipeDirection == .down) {
            
            // loop through the columns
            for gridX in xStart.stride(through: xEnd, by: xIncrement){
                
                // loop through the rows
                for gridY in yStart.stride(through: yEnd, by: yIncrement) {
                    
                    // Create some variable references for simplification
                    let currentBlock = gridNode.gridArray[gridX][gridY].state
                    
                    // Is it the last row?
                    if gridY == yEnd {
                        
                        // Is it a swipe up?
                        if swipeDirection == .up {
                            
                            // Is the stage value active at this column?
                            if bottomStageNode.stageArray[gridX].state != .inactive {
                                
                                // Is the current block different?
                                if currentBlock != bottomStageNode.stageArray[gridX].state {
                                    
                                    // Perform battle and store the result in current block
                                    gridNode.gridArray[gridX][gridY].state = battle(currentBlock, block2: bottomStageNode.stageArray[gridX].state)
                                    
                                    // Set the stage regen bool equal to true
                                    stageRegen = true
                                    
                                }
                            }
                            
                        } else if swipeDirection == .down {
                         
                            // Is the stage value active at this column?
                            if topStageNode.stageArray[gridX].state != .inactive {
                                
                                // Is the current block different?
                                if currentBlock != topStageNode.stageArray[gridX].state {
                                    
                                    // Perform battle and store the result in current block
                                    gridNode.gridArray[gridX][gridY].state = battle(currentBlock, block2: topStageNode.stageArray[gridX].state)
                                    
                                    // Set the stage regen bool equal to true
                                    stageRegen = true
                                    
                                }
                            }

                            
                        }
                        
                    } else {
                        
                        let nextBlock = gridNode.gridArray[gridX][gridY+yIncrement].state
                        
                        // Are the current and adjacent blocks different?...
                        if currentBlock != nextBlock {
                            
                            
                            let resourcePath = NSBundle.mainBundle().pathForResource("Penguin", ofType: "sks")
                            let rock = MSReferenceNode(URL: NSURL (fileURLWithPath: resourcePath!))
                            
                            
                            // Clear the next block state to inactive...
                            gridNode.gridArray[gridX][gridY+yIncrement].state = .inactive
                            
                            
                            
                            // If so perform a battle and set the current block equal to the winner
                            gridNode.gridArray[gridX][gridY].state = battle(currentBlock, block2: nextBlock)
                            
                            
                            
                            
                        } else {
                            
                            // Since they must be equal, do nothing to either value
                            
                        }

                    }
                    
                    
                
                }
                
                // Is the regen bool equal to true?
                if stageRegen == true {
                    
                    // Is the swipe up?
                    if swipeDirection == .up {
                        
                        // Clear the stage
                        bottomStageNode.stageArray[gridX].state = .inactive
                        
                        //Is the swipe down?
                    } else if swipeDirection == .down {
                        
                        // Clear the stage
                        topStageNode.stageArray[gridX].state = .inactive
                        
                    }
                }

                
            }
        
            // Is the swipe Up?
            if swipeDirection == .up {
                
                // Is the stage regen bool equal to true?
                if stageRegen == true {
                    
                    // Add a new block to the stage
                    bottomStageNode.addBlockToEmptyStage()
                    
                    // Reset the stage regen bool to false
                    stageRegen = false
                    
                }
                
                // Is the swip down?
            } else if swipeDirection == .down {
                
                // Is the stage regen bool equal to true?
                if stageRegen == true {
                    
                    // Add a new block to the stage
                    topStageNode.addBlockToEmptyStage()
                    
                    // Reset the stage regen bool to false
                    stageRegen = false
                    
                }

            }
            
        }
        
        
        // If direction of swipe is horizontal
        if (swipeDirection == .left) || (swipeDirection == .right) {
            
            // loop through the columns
            for gridY in yStart.stride(through: yEnd, by: yIncrement){
                
                // loop through the rows
                for gridX in xStart.stride(through: xEnd, by: xIncrement) {
                    
                    // Create some variable references for simplification
                    let currentBlock = gridNode.gridArray[gridX][gridY].state
                    
                    
                    // Is it the last row?
                    if gridX == xEnd {
                        
                        // Is it a swipe up?
                        if swipeDirection == .left {
                            
                            // Is the stage value active at this column?
                            if rightStageNode.stageArray[gridY].state != .inactive {
                                
                                // Is the current block different?
                                if currentBlock != rightStageNode.stageArray[gridY].state {
                                    
                                    // Perform battle and store the result in current block
                                    gridNode.gridArray[gridX][gridY].state = battle(currentBlock, block2: rightStageNode.stageArray[gridY].state)
                                    
                                    // Set the stage regen bool equal to true
                                    stageRegen = true
                                    
                                }
                            }
                            
                        } else if swipeDirection == .right {
                            
                            // Is the stage value active at this column?
                            if leftStageNode.stageArray[gridY].state != .inactive {
                                
                                // Is the current block different?
                                if currentBlock != leftStageNode.stageArray[gridY].state {
                                    
                                    // Perform battle and store the result in current block
                                    gridNode.gridArray[gridX][gridY].state = battle(currentBlock, block2: leftStageNode.stageArray[gridY].state)
                                    
                                    // Set the stage regen bool equal to true
                                    stageRegen = true
                                    
                                }
                            }
                            
                            
                        }
                        
                    } else {
                        
                        let nextBlock = gridNode.gridArray[gridX+xIncrement][gridY].state
                        
                        // Are the current and adjacent blocks different?...
                        if currentBlock != nextBlock {
                            
                            // If so perform a battle and set the current block equal to the winner
                            gridNode.gridArray[gridX][gridY].state = battle(currentBlock, block2: nextBlock)
                            
                            // Clear the next block state to inactive...
                            gridNode.gridArray[gridX+xIncrement][gridY].state = .inactive
                            
                            
                        } else {
                            
                            // Since they must be equal, do nothing to either value
                            
                        }
                        
                    }
                    
                    
                    
                }
             
                // Is the regen bool equal to true?
                if stageRegen == true {
                    
                    // Is the swipe left?
                    if swipeDirection == .left {
                        
                        // Clear the stage
                        rightStageNode.stageArray[gridY].state = .inactive
                        
                    } else if swipeDirection == .right {
                        
                        // Clear the stage
                        leftStageNode.stageArray[gridY].state = .inactive
                        
                    }
                }
            
                
            }
            
            // Is the swipe Up?
            if swipeDirection == .left {
                
                // Is the stage regen bool equal to true?
                if stageRegen == true {
                    
                    // Add a new block to the stage
                    rightStageNode.addBlockToEmptyStage()
                    
                    // Reset the stage regen bool to false
                    stageRegen = false
                    
                }
                
                // Is the swip down?
            } else if swipeDirection == .right {
                
                // Is the stage regen bool equal to true?
                if stageRegen == true {
                    
                    // Add a new block to the stage
                    leftStageNode.addBlockToEmptyStage()
                    
                    // Reset the stage regen bool to false
                    stageRegen = false
                    
                }
                
            }
            
        }

        
    }
    
    //                // Is the row we're on, on the edge (aka wall row)?
    //                if gridY == yEnd {
    //
    //                    //creating some simplified references
    //                    let typeInactive: BlockType = .inactive
    ////                    gridNode.gridArray[gridX][gridY].stacked = true
    //
    //
    //                    // If block along the wall is active...
    //                    if preSwipeGrid.gridArray[gridX][gridY].state != typeInactive  {
    //
    //                        //CHECK IF SWIPE IS VERTICAL
    //                        if swipeDirection == .up || swipeDirection == .down
    //                        {
    //                            // If the adjacent block is inactive...
    //                            if preSwipeGrid.gridArray[gridX][gridY+yIncrement].state == typeInactive {
    //
    //                                // Do not change the value if on the wall and adjacent value is inactive
    //                                gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX][gridY].state
    //                            }
    //
    //                                //Otherwise if the adjacent block is active...
    //                            else if preSwipeGrid.gridArray[gridX][gridY+yIncrement].state != typeInactive {
    //                                // APPLY COLLISION RULES!!
    //                                let block1: BlockType = preSwipeGrid.gridArray[gridX][gridY].state
    //                                let block2: BlockType = preSwipeGrid.gridArray[gridX][gridY+yIncrement].state
    //
    //
    //                                if block1 == block2 {
    //                                    gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX][gridY].state
    //                                } else {
    //                                    gridNode.gridArray[gridX][gridY].state = battle(block1, block2: block2)
    //                                }
    //                            }
    //
    //                            //REPEAT CODE FOR HORIZONTAL
    //
    //                            //check to see if swipe direction is horizontal
    //                        } else if swipeDirection == .left || swipeDirection == .right {
    //
    //                            // If the adjacent block is inactive...
    //                            if preSwipeGrid.gridArray[gridX+xIncrement][gridY].state == typeInactive {
    //
    //                                // Do not change the value if on the wall and adjacent value is inactive
    //                                gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX][gridY].state
    //                            }
    //
    //                                //Otherwise if the adjacent block is active...
    //                            else if preSwipeGrid.gridArray[gridX+xIncrement][gridY].state != typeInactive {
    //
    //                                // APPLY COLLISION RULES!!
    //                                let block1: BlockType = preSwipeGrid.gridArray[gridX][gridY].state
    //                                let block2: BlockType = preSwipeGrid.gridArray[gridX+xIncrement][gridY].state
    //
    //
    //                                if block1 == block2 {
    //                                    gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX][gridY].state
    //                                } else {
    //                                    gridNode.gridArray[gridX][gridY].state = battle(block1, block2: block2)
    //                                }
    //                            }
    //
    //                        }
    //
    //                    }
    //                        //INACTIVE
    //                        //Otherwise if the block along the wall is inactive...
    //                    else if preSwipeGrid.gridArray[gridX][gridY].state == typeInactive {
    //
    //                        // Change the value to the adjacent cell's value
    //                        gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX][gridY-1].state
    //
    //                    }
    //
    //                }
    //
    //                    //ALL OTHER AISLES
    //                else {
    //
    //                    //CHECK FOR HORIZONTAL OR VERTICAL FOR NON-FIRST AISLES
    //                    //IF VERTICAL
    //                    if swipeDirection == .up || swipeDirection == .down
    //                    {
    //                        //Reference points in the grid
    //                        let previousBlock = gridNode.gridArray[gridX][gridY-yIncrement]
    //                        let currentBlock = gridNode.gridArray[gridX][gridY]
    //                        let nextBlock = gridNode.gridArray[gridX][gridY+yIncrement]
    //
    //
    //                        // Check to see if the previous block is stacked, active, and equal to current
    //                        if previousBlock.stacked == true && currentBlock.state != previousBlock.state{
    //
    //                            //Set the current block equal to the results of a battle
    //                            gridNode.gridArray[gridX][gridY].state = battle(currentBlock.state, block2: nextBlock.state)
    //
    //                            // Check to see if winner is the same as the previous block
    //                            if gridNode.gridArray[gridX][gridY].state == previousBlock.state {
    //
    //                                // Set the current block stacked bool equal to true
    //                                gridNode.gridArray[gridX][gridY].stacked = true
    //
    //                            // Otherwise...
    //                            } else {
    //
    //                                // Set the current block stacked bool equal to false
    //                                 gridNode.gridArray[gridX][gridY].stacked = false
    //
    //                            }
    //                        }
    //
    //
    //
    
    //                        // Check to see if the current block is inactive
    //                        if (currentBlock.state == .inactive){
    //
    //                            // Set the current block equal to the next block
    //                            gridNode.gridArray[gridX][gridY].state = nextBlock.state
    //
    //                        }
    //                        // If previous block is stacked and equal in state...
    //                        else if (currentBlock.state != .inactive) && (previousBlock.stacked == true) && (currentBlock.state == previousBlock.state) {
    //
    //                            // Set the stacked property to true
    //                            gridNode.gridArray[gridX][gridY].stacked = true
    //
    //                            // Check to see if the next block is active and not equal to the current block
    //                            if (nextBlock.state != .inactive) && (nextBlock.state != currentBlock.state){
    //
    //                                // Set the current block equal to the winner of the battle between current block and next block
    //                                gridNode.gridArray[gridX][gridY].state = battle(currentBlock.state, block2: nextBlock.state)
    //
    //                                // Check to see who won
    //                                if gridNode.gridArray[gridX][gridY].state != previousBlock.state {
    //                                    gridNode.gridArray[gridX][gridY].stacked = false
    //                                }
    //
    //                                // Set the next block equal to zero (so as not to calculate in the next stack evaluation
    //                                gridNode.gridArray[gridX][gridY+xIncrement].state = .inactive
    //
    //                            // Check to see if the next block is inactive
    //                            } else if (nextBlock.state == .inactive) && (currentBlock.state != .inactive){
    //
    //                                // Set the current block equal to itself
    //                                gridNode.gridArray[gridX][gridY].state = currentBlock.state
    //
    //                                // Check to see if the
    //                            }
    //                            //
    //                        }
    
    //                        else if (currentBlock.state != .inactive) && (previousBlock.stacked == true) && (currentBlock.state != previousBlock.state) {
    //
    //                        }
    //
    //                        //IF HORIZONTAL
    //                    } else if swipeDirection == .left || swipeDirection == .right {
    //
    //                    }
    //                    //                    let block0 = gridNode.gridArray[gridX][gridY+1]
    //                    //                    let block1 = gridNode.gridArray[gridX][gridY]
    //                    //                    let block2 = gridNode.gridArray[gridX][gridY-1]
    //                    //
    //                    //                    // check to see if block above is immoveable and is the same
    //                    //                    if block0.stackedUp == true && block1.state == block0.state {
    //                    //
    //                    //                        gridNode.gridArray[gridX][gridY].state =
    //                    //                     }
    //                    //set the value of the gridArray equal to the value at the previous row (no conditional)
    //                    //stops at the last row (can't have a row = -1)
    //
    //                    gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX][gridY-1].state
    //                }
    //            }
    //
    //            //set the zeroith row equal to what's in the stage
    //
    //            gridNode.gridArray[gridX][0].state = stage!.stageArray[gridX].state
    //
    //            //reset the stage to all .inactive
    //
    //            stage!.stageArray[gridX].state = .inactive
    //        }
    //
    //        //add a new block to the empty stage
    //
    //        stage!.addBlockToEmptyStage()
    //
    //    }
    
    func battle(block1: BlockType, block2: BlockType) -> BlockType {
        let rock: BlockType = .rock
        let paper: BlockType = .paper
        let scissors: BlockType = .scissors
        let inactive: BlockType = .inactive
        
        //rock vs paper...
        if ((block1 == rock) && (block2 == paper)) || ((block1 == paper) && (block2 == rock)) {
            //paper wins!!
            return paper
            
            //paper vs scissors
        } else if ((block1 == paper) && (block2 == scissors)) || ((block1 == scissors) && (block2 == paper)) {
            //scissors wins!!
            return scissors
            
            //scissors vs rock
        } else if ((block1 == scissors) && (block2 == rock)) || ((block1 == rock) && (block2 == scissors)) {
            //rock wins!!
            return rock
            
            // rock vs nothing
        } else if ((block1 == inactive) && (block2 == rock)) || ((block1 == rock) && (block2 == inactive)) {
            //rock wins!!
            return rock
            
            // paper vs nothing
        } else if ((block1 == inactive) && (block2 == paper)) || ((block1 == paper) && (block2 == inactive)) {
            //paper wins!!
            return paper
            
            // scissors vs nothing
        } else if ((block1 == inactive) && (block2 == scissors)) || ((block1 == scissors) && (block2 == inactive)) {
            //paper wins!!
            return scissors
            
            // nothing vs nothing
        } else if ((block1 == inactive) && (block2 == inactive)) || ((block1 == inactive) && (block2 == inactive)) {
            //nothing wins!!
            return inactive
            
            // rock vs rock
        } else if ((block1 == rock) && (block2 == rock)) || ((block1 == rock) && (block2 == rock)) {
            //rock wins!!
            return rock
            
            // paper vs paper
        } else if ((block1 == paper) && (block2 == paper)) || ((block1 == paper) && (block2 == paper)) {
            //paper wins!!
            return paper
            
            // scissors vs scissors
        } else if ((block1 == scissors) && (block2 == scissors)) || ((block1 == scissors) && (block2 == scissors)) {
            //scissors wins!!
            return scissors
        }
            
        else{
            return block1
            
        }
        
        
    }
}

func xRef(x: Int, swipe: swipeType) -> Int {
    
    var xNew: Int = x
    
    // If swipe direction...
    if swipe == .up {
        switch x {
        case 0: xNew = 0
        case 1: xNew = 1
        case 2: xNew = 2
        case 3: xNew = 3
        default:
            xNew = x
        }
    } else if swipe == .down {
        switch x {
        case 0: xNew = 3
        case 1: xNew = 2
        case 2: xNew = 1
        case 3: xNew = 0
        default:
            xNew = x
        }
    } else if swipe == .left {
        switch x {
        case 0: xNew = 0
        case 1: xNew = 1
        case 2: xNew = 2
        case 3: xNew = 3
        default:
            xNew = x
        }
    } else if swipe == .right {
        switch x {
        case 0: xNew = 3
        case 1: xNew = 2
        case 2: xNew = 1
        case 3: xNew = 0
        default:
            xNew = x
        }
    }
    return xNew
}

func yRef(y: Int, swipe: swipeType) -> Int {
    
    var yNew: Int = y
    
    // If swipe direction...
    if swipe == .up {
        switch y {
        case 0: yNew = 0
        case 1: yNew = 1
        case 2: yNew = 2
        case 3: yNew = 3
        default:
            yNew = y
        }
    } else if swipe == .down {
        switch y {
        case 0: yNew = 3
        case 1: yNew = 2
        case 2: yNew = 1
        case 3: yNew = 0
        default:
            yNew = y
        }
    } else if swipe == .left {
        switch y {
        case 0: yNew = 3
        case 1: yNew = 2
        case 2: yNew = 1
        case 3: yNew = 0
        default:
            yNew = y
        }
    } else if swipe == .right {
        switch y {
        case 0: yNew = 1
        case 1: yNew = 2
        case 2: yNew = 3
        case 3: yNew = 4
        default:
            yNew = y
        }
    }
    return yNew
}




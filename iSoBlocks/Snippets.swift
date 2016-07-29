//
//  Snippets.swift
//  iSoBlocks
//
//  Created by Tassos Lambrou on 7/19/16.
//  Copyright © 2016 Ssos Games. All rights reserved.
//

import Foundation



// ATTEMPT AT A COORDINATE REFERENCE SYSTEM

//
//func xRef(x: Int, swipe: swipeType) -> Int {
//
//    var xNew: Int = x
//
//    // If swipe direction...
//    if swipe == .up {
//        switch x {
//        case 0: xNew = 0
//        case 1: xNew = 1
//        case 2: xNew = 2
//        case 3: xNew = 3
//        default:
//            xNew = x
//        }
//    } else if swipe == .down {
//        switch x {
//        case 0: xNew = 3
//        case 1: xNew = 2
//        case 2: xNew = 1
//        case 3: xNew = 0
//        default:
//            xNew = x
//        }
//    } else if swipe == .left {
//        switch x {
//        case 0: xNew = 0
//        case 1: xNew = 1
//        case 2: xNew = 2
//        case 3: xNew = 3
//        default:
//            xNew = x
//        }
//    } else if swipe == .right {
//        switch x {
//        case 0: xNew = 3
//        case 1: xNew = 2
//        case 2: xNew = 1
//        case 3: xNew = 0
//        default:
//            xNew = x
//        }
//    }
//    return xNew
//}
//
//func yRef(y: Int, swipe: swipeType) -> Int {
//
//    var yNew: Int = y
//
//    // If swipe direction...
//    if swipe == .up {
//        switch y {
//        case 0: yNew = 0
//        case 1: yNew = 1
//        case 2: yNew = 2
//        case 3: yNew = 3
//        default:
//            yNew = y
//        }
//    } else if swipe == .down {
//        switch y {
//        case 0: yNew = 3
//        case 1: yNew = 2
//        case 2: yNew = 1
//        case 3: yNew = 0
//        default:
//            yNew = y
//        }
//    } else if swipe == .left {
//        switch y {
//        case 0: yNew = 3
//        case 1: yNew = 2
//        case 2: yNew = 1
//        case 3: yNew = 0
//        default:
//            yNew = y
//        }
//    } else if swipe == .right {
//        switch y {
//        case 0: yNew = 1
//        case 1: yNew = 2
//        case 2: yNew = 3
//        case 3: yNew = 4
//        default:
//            yNew = y
//        }
//    }
//    return yNew
//}
//




//FIRST ATTEMPT AT A SINGLE SWIPE FUNCTION...

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




//BEFORE I MANUALLY SET INCREMENTS IN SIDE THE SWIPE FUNCTION....

//
//        if xStart > xEnd { xIncrement = -1 // down, right
//        } else if xStart < xEnd { xIncrement = 1 // up, left
//        } else if yStart > yEnd { yIncrement = -1 // up, right
//        } else if yStart < yEnd { yIncrement = 1 } // down, left




//BEFORE IT WAS IN A SINGLE FUNCTION.....

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







//2ND VERSION SWIPE FUNCTION
//func swipe(swipeDirection: swipeType) {
//    var xStart: Int
//    var xEnd: Int
//    var yStart: Int
//    var yEnd: Int
//    var xIncrement: Int = 1
//    var yIncrement: Int = 1
//    var stageRegen: Bool = false
//    
//    timeElapsed = 0
//    
//    switch swipeDirection {
//    case .up:
//        //print("swiped up")
//        xStart = 0
//        xEnd = columns-1
//        yStart = rows-1
//        yEnd = 0
//        xIncrement = 1
//        yIncrement = -1
//        
//    case .down:
//        //print("swiped down")
//        xStart = columns-1
//        xEnd = 0
//        yStart = 0
//        yEnd = rows-1
//        xIncrement = -1
//        yIncrement = 1
//        
//    case .left:
//        //print("swiped left")
//        xStart = 0
//        xEnd = columns-1
//        yStart = 0
//        yEnd = rows-1
//        xIncrement = 1
//        yIncrement = 1
//        
//    case .right:
//        //print("swiped right")
//        xStart = columns-1
//        xEnd = 0
//        yStart = rows-1
//        yEnd = 0
//        xIncrement = -1
//        yIncrement = -1
//        
//        
//    }
//    
//    
//    
//    
//    // If direction of swipe is vertical...
//    if (swipeDirection == .up) || (swipeDirection == .down) {
//        
//        // loop through the columns
//        for gridX in xStart.stride(through: xEnd, by: xIncrement){
//            
//            // loop through the rows
//            for gridY in yStart.stride(through: yEnd, by: yIncrement) {
//                
//                
//                // Create some variable references for simplification
//                let currentBlock = gridNode.gridArray[gridX][gridY].state
//                let current = gridNode.gridArray[gridX][gridY]
//                
//                
//                //MARK: Last Row Vertical
//                // Is it the last row?
//                if gridY == yEnd {
//                    
//                    //MARK: Swipe Up
//                    // Is it a swipe up?
//                    if swipeDirection == .up {
//                        let next = bottomStageNode.stageArray[gridX]
//                        
//                        // Is the stage value active at this column?
//                        if bottomStageNode.stageArray[gridX].state != .inactive {
//                            
//                            // Is the current block different?
//                            if currentBlock != bottomStageNode.stageArray[gridX].state {
//                                
//                                // Combine Stacks
//                                gridNode.gridArray[gridX][gridY].stack += bottomStageNode.stageArray[gridX].stack
//                                
//                                // Perform collision & store the result
//                                let result: Outcome = collision(gridNode.gridArray[gridX][gridY], block2: bottomStageNode.stageArray[gridX])
//                                
//                                // Set the current equal to the winner state
//                                gridNode.gridArray[gridX][gridY].state = result.winnner.state
//                                
//                                
//                                //                                    // Perform battle and store the result in current block
//                                //                                    gridNode.gridArray[gridX][gridY].state = battle(currentBlock, block2: bottomStageNode.stageArray[gridX].state)
//                                
//                                // Set the stage regen bool equal to true
//                                stageRegen = true
//                                
//                            }
//                        }
//                        
//                        
//                    } else if swipeDirection == .down {
//                        
//                        let next = topStageNode.stageArray[gridX]
//                        
//                        // Is the stage value active at this column?
//                        if topStageNode.stageArray[gridX].state != .inactive {
//                            
//                            // Is the current block different?
//                            if currentBlock != topStageNode.stageArray[gridX].state {
//                                
//                                // Combine Stacks
//                                gridNode.gridArray[gridX][gridY].stack += topStageNode.stageArray[gridX].stack
//                                
//                                // Perform collision & store the result
//                                let result: Outcome = collision(gridNode.gridArray[gridX][gridY], block2: topStageNode.stageArray[gridX])
//                                
//                                // Set the current equal to the winner state
//                                gridNode.gridArray[gridX][gridY].state = result.winnner.state
//                                
//                                //                                    // Perform battle and store the result in current block
//                                //                                    gridNode.gridArray[gridX][gridY].state = battle(currentBlock, block2: topStageNode.stageArray[gridX].state)
//                                
//                                // Set the stage regen bool equal to true
//                                stageRegen = true
//                                
//                            }
//                        }
//                        
//                        
//                    }
//                    
//                } else {
//                    
//                    let nextBlock = gridNode.gridArray[gridX][gridY+yIncrement].state
//                    
//                    // Are the current and adjacent blocks different?...
//                    if currentBlock != nextBlock {
//                        
//                        
//                        //INSERT ANIMATION!!!!!
//                        
//                        
//                        
//                        // Create collision
//                        animateCollision(gridNode.gridArray[gridX][gridY], block2: gridNode.gridArray[gridX][gridY+yIncrement])
//                        
//                        // Combine Stacks
//                        gridNode.gridArray[gridX][gridY].stack += gridNode.gridArray[gridX][gridY+yIncrement].stack
//                        
//                        // Clear the next block state to inactive...
//                        gridNode.gridArray[gridX][gridY+yIncrement].state = .inactive
//                        
//                        
//                        // If so perform a battle and set the current block equal to the winner
//                        
//                        gridNode.gridArray[gridX][gridY].state = battle(currentBlock, block2: nextBlock)
//                        
//                        
//                        
//                        
//                    } else {
//                        
//                        // Since they must be equal, do nothing to either value
//                        
//                    }
//                    
//                }
//                
//                
//                
//            }
//            
//            // Is the regen bool equal to true?
//            if stageRegen == true {
//                
//                // Is the swipe up?
//                if swipeDirection == .up {
//                    
//                    // Clear the stage
//                    bottomStageNode.stageArray[gridX].state = .inactive
//                    
//                    //Is the swipe down?
//                } else if swipeDirection == .down {
//                    
//                    // Clear the stage
//                    topStageNode.stageArray[gridX].state = .inactive
//                    
//                }
//            }
//            
//            
//        }
//        
//        // Is the swipe Up?
//        if swipeDirection == .up {
//            
//            // Is the stage regen bool equal to true?
//            if stageRegen == true {
//                
//                // Add a new block to the stage
//                bottomStageNode.addBlockToEmptyStage()
//                
//                // Reset the stage regen bool to false
//                stageRegen = false
//                
//            }
//            
//            // Is the swipe down?
//        } else if swipeDirection == .down {
//            
//            // Is the stage regen bool equal to true?
//            if stageRegen == true {
//                
//                // Add a new block to the stage
//                topStageNode.addBlockToEmptyStage()
//                
//                // Reset the stage regen bool to false
//                stageRegen = false
//                
//            }
//            
//        }
//        
//    }
//    
//    
//    // If direction of swipe is horizontal
//    if (swipeDirection == .left) || (swipeDirection == .right) {
//        
//        // loop through the columns
//        for gridY in yStart.stride(through: yEnd, by: yIncrement){
//            
//            // loop through the rows
//            for gridX in xStart.stride(through: xEnd, by: xIncrement) {
//                
//                // Create some variable references for simplification
//                let currentBlock = gridNode.gridArray[gridX][gridY].state
//                
//                
//                //MARK: Last Row Horizontal
//                // Is it the last row?
//                if gridX == xEnd {
//                    
//                    //MARK: Swipe Left
//                    // Is it a swipe left?
//                    if swipeDirection == .left {
//                        
//                        // Is the stage value active at this column?
//                        if rightStageNode.stageArray[gridY].state != .inactive {
//                            
//                            // Is the current block different?
//                            if currentBlock != rightStageNode.stageArray[gridY].state {
//                                
//                                // Combine Stacks
//                                gridNode.gridArray[gridX][gridY].stack += rightStageNode.stageArray[gridY].stack
//                                
//                                // Perform battle and store the result in current block
//                                gridNode.gridArray[gridX][gridY].state = battle(currentBlock, block2: rightStageNode.stageArray[gridY].state)
//                                
//                                // Set the stage regen bool equal to true
//                                stageRegen = true
//                                
//                            }
//                        }
//                        
//                        //MARK: Swipe Right
//                    } else if swipeDirection == .right {
//                        
//                        // Is the stage value active at this column?
//                        if leftStageNode.stageArray[gridY].state != .inactive {
//                            
//                            // Is the current block different?
//                            if currentBlock != leftStageNode.stageArray[gridY].state {
//                                
//                                // Combine Stacks
//                                gridNode.gridArray[gridX][gridY].stack += leftStageNode.stageArray[gridY].stack
//                                
//                                // Perform battle and store the result in current block
//                                gridNode.gridArray[gridX][gridY].state = battle(currentBlock, block2: leftStageNode.stageArray[gridY].state)
//                                
//                                // Set the stage regen bool equal to true
//                                stageRegen = true
//                                
//                            }
//                        }
//                        
//                        
//                    }
//                    
//                    //MARK: Horizontal Swipe Main Gameboard Rules
//                    
//                } else {
//                    
//                    //Create a reference variable to make cleaner
//                    let nextBlock = gridNode.gridArray[gridX+xIncrement][gridY].state
//                    
//                    // Are the current and adjacent blocks different?...
//                    if currentBlock != nextBlock {
//                        
//                        animateCollision(gridNode.gridArray[gridX][gridY], block2: gridNode.gridArray[gridX+xIncrement][gridY])
//                        
//                        // Combine Stacks
//                        gridNode.gridArray[gridX][gridY].stack += gridNode.gridArray[gridX+xIncrement][gridY].stack
//                        
//                        // Clear the next block state to inactive...
//                        gridNode.gridArray[gridX+xIncrement][gridY].state = .inactive
//                        
//                        // If so perform a battle and set the current block equal to the winner
//                        gridNode.gridArray[gridX][gridY].state = battle(currentBlock, block2: nextBlock)
//                        
//                        
//                        
//                        
//                    } else {
//                        
//                        // Since they must be equal, do nothing to either value
//                        
//                    }
//                    
//                }
//                
//                
//                
//            }
//            
//            // Is the regen bool equal to true?
//            if stageRegen == true {
//                
//                // Is the swipe left?
//                if swipeDirection == .left {
//                    
//                    // Clear the stage
//                    rightStageNode.stageArray[gridY].state = .inactive
//                    
//                } else if swipeDirection == .right {
//                    
//                    // Clear the stage
//                    leftStageNode.stageArray[gridY].state = .inactive
//                    
//                }
//            }
//            
//            
//        }
//        
//        // Is the swipe Up?
//        if swipeDirection == .left {
//            
//            // Is the stage regen bool equal to true?
//            if stageRegen == true {
//                
//                // Add a new block to the stage
//                rightStageNode.addBlockToEmptyStage()
//                
//                // Reset the stage regen bool to false
//                stageRegen = false
//                
//            }
//            
//            // Is the swipe down?
//        } else if swipeDirection == .right {
//            
//            // Is the stage regen bool equal to true?
//            if stageRegen == true {
//                
//                // Add a new block to the stage
//                leftStageNode.addBlockToEmptyStage()
//                
//                // Reset the stage regen bool to false
//                stageRegen = false
//                
//            }
//            
//        }
//        
//    }
//    
//    
//}





// ROCK PAPER SCISSORS COLLISION RULES
//func collision(block1: Block, block2: Block) -> Outcome {
//    let rock: BlockType = .rock
//    let paper: BlockType = .paper
//    let scissors: BlockType = .scissors
//    let inactive: BlockType = .inactive
//    let block1State = block1.state
//    let block2State = block2.state
//    
//    //rock vs paper...
//    if (block1State == rock) && (block2State == paper) {
//        //block2 wins!!
//        return Outcome(winnner: block2, loser: block1, tie: 2)
//        
//        //paper vs rock
//    } else if (block1State == paper) && (block2State == rock) {
//        //block1 wins!!
//        return Outcome(winnner: block1, loser: block2, tie: 1)
//        
//        //paper vs scissors
//    } else if (block1State == paper) && (block2State == scissors){
//        //block2 wins!!
//        return Outcome(winnner: block2, loser: block1, tie: 2)
//        
//        //scissors vs paper
//    } else if (block1State == scissors) && (block2State == paper) {
//        //block1 wins!!
//        return Outcome(winnner: block1, loser: block2, tie: 1)
//        
//        //scissors vs rock
//    } else if (block1State == scissors) && (block2State == rock){
//        //block2 wins!!
//        return Outcome(winnner: block2, loser: block1, tie: 2)
//        
//        //rock vs scissors
//    } else if (block1State == rock) && (block2State == scissors) {
//        //block1 wins!!
//        return Outcome(winnner: block1, loser: block2, tie: 1)
//        
//        // nothing vs rock
//    } else if (block1State == inactive) && (block2State == rock) {
//        //block2 wins!!
//        return Outcome(winnner: block2, loser: block1, tie: 2)
//        
//        // rock vs nothing
//    } else if (block1State == rock) && (block2State == inactive) {
//        //block1 wins!!
//        return Outcome(winnner: block1, loser: block2, tie: 1)
//        
//        // paper vs nothing
//    } else if (block1State == paper) && (block2State == inactive) {
//        //block1 wins!!
//        return Outcome(winnner: block1, loser: block2, tie: 1)
//        
//        // nothing vs paper
//    } else if (block1State == inactive) && (block2State == paper) {
//        //block2 wins!!
//        return Outcome(winnner: block2, loser: block1, tie: 2)
//        
//        // scissors vs nothing
//    } else if (block1State == scissors) && (block2State == inactive) {
//        //block1 wins!!
//        return Outcome(winnner: block1, loser: block2, tie: 1)
//        
//        // nothing vs scissors
//    } else if (block1State == inactive) && (block2State == scissors){
//        //block2 wins!!
//        return Outcome(winnner: block2, loser: block1, tie: 2)
//        
//        // nothing vs nothing
//    } else if ((block1State == inactive) && (block2State == inactive)) || ((block1State == inactive) && (block2State == inactive)) {
//        //tie!!
//        return Outcome(winnner: block1, loser: block2, tie: 0)
//        
//        // rock vs rock
//    } else if ((block1State == rock) && (block2State == rock)) || ((block1State == rock) && (block2State == rock)) {
//        //tie!!
//        return Outcome(winnner: block1, loser: block2, tie: 0)
//        
//        // paper vs paper
//    } else if ((block1State == paper) && (block2State == paper)) || ((block1State == paper) && (block2State == paper)) {
//        //tie!!
//        return Outcome(winnner: block1, loser: block2, tie: 0)
//        
//        // scissors vs scissors
//    } else if ((block1State == scissors) && (block2State == scissors)) || ((block1State == scissors) && (block2State == scissors)) {
//        //tie!!
//        return Outcome(winnner: block1, loser: block2, tie: 0)
//    }
//        
//    else{
//        
//        print("collision rules did not work")
//        return Outcome(winnner: block1, loser: block2, tie: 0)
//        
//        
//    }
//    
//    
//}





// OLD BATTLE FUNCTION
//func battle(block1: BlockType, block2: BlockType) -> BlockType {
//    let red: BlockType = .red
//    let blue: BlockType = .blue
//    let green: BlockType = .green
//    let inactive: BlockType = .inactive
//    
//    //red vs blue...
//    if ((block1 == red) && (block2 == blue)) || ((block1 == blue) && (block2 == red)) {
//        //blue wins!!
//        return blue
//        
//        //blue vs green
//    } else if ((block1 == blue) && (block2 == green)) || ((block1 == green) && (block2 == blue)) {
//        //green wins!!
//        return green
//        
//        //green vs red
//    } else if ((block1 == green) && (block2 == red)) || ((block1 == red) && (block2 == green)) {
//        //red wins!!
//        return red
//        
//        // red vs nothing
//    } else if ((block1 == inactive) && (block2 == red)) || ((block1 == red) && (block2 == inactive)) {
//        //red wins!!
//        return red
//        
//        // blue vs nothing
//    } else if ((block1 == inactive) && (block2 == blue)) || ((block1 == blue) && (block2 == inactive)) {
//        //blue wins!!
//        return blue
//        
//        // green vs nothing
//    } else if ((block1 == inactive) && (block2 == green)) || ((block1 == green) && (block2 == inactive)) {
//        //blue wins!!
//        return green
//        
//        // nothing vs nothing
//    } else if ((block1 == inactive) && (block2 == inactive)) || ((block1 == inactive) && (block2 == inactive)) {
//        //nothing wins!!
//        return inactive
//        
//        // red vs red
//    } else if ((block1 == red) && (block2 == red)) || ((block1 == red) && (block2 == red)) {
//        //red wins!!
//        return red
//        
//        // blue vs blue
//    } else if ((block1 == blue) && (block2 == blue)) || ((block1 == blue) && (block2 == blue)) {
//        //blue wins!!
//        return blue
//        
//        // green vs green
//    } else if ((block1 == green) && (block2 == green)) || ((block1 == green) && (block2 == green)) {
//        //green wins!!
//        return green
//    }
//        
//    else{
//        return block1
//        
//    }
//    
//    
//}


// AddBlockToEmptyGrid
//
//func addBlockToEmptyGrid() {
//    var blockCreated: Bool = false
//    var xRand = Int.random(columns)
//    var yRand = Int.random(rows)
//    var block = gridArray[xRand][yRand]
//    var index = 0
//    
//    while blockCreated == false {
//        if block.state == .inactive {
//            let typeRand = Int.random(3)+1
//            switch typeRand {
//            //case 0?
//            case 1:
//                block.state = .red
//            case 2:
//                block.state = .blue
//            case 3:
//                block.state = .green
//            default:
//                print("switch statement in addBlockToEmptyGrid didn't work")
//            }
//            
//            blockCreated = true
//        } else if block.state != .inactive && index < rows*columns{
//            xRand = Int.random(columns)
//            yRand = Int.random(rows)
//            block = gridArray[xRand][yRand]
//            index += 1
//            
//        } else {
//            break
//        }
//        
//    }
//}




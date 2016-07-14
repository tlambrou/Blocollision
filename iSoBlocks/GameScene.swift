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
    
    
    
    func swipedUp(sender:UISwipeGestureRecognizer){
        let preSwipeGrid = gridNode
        
        
        // loop through the columns
        for gridX in 0..<columns{
            
            // loop through the rows
            for gridY in (rows-1).stride(through: 1, by: -1) {
                
                // Is the row we're on, on the edge (aka wall row)?
                if gridY == rows-1 {
                    let dummyType: BlockType = .inactive
                    
                    // If block along the wall is active...
                    if preSwipeGrid.gridArray[gridX][gridY].state != dummyType  {
                        
                        // If the adjacent block is inactive...
                        if preSwipeGrid.gridArray[gridX][gridY-1].state == dummyType {
                            
                            // Do not change the value if on the wall and adjacent value is inactive
                            gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX][gridY].state
                        }
                            
                            //Otherwise if the adjacent block is active...
                        else if preSwipeGrid.gridArray[gridX][gridY-1].state != dummyType {
                            // APPLY COLLISION RULES!!
                            let block1: BlockType = preSwipeGrid.gridArray[gridX][gridY].state
                            let block2: BlockType = preSwipeGrid.gridArray[gridX][gridY-1].state

                            gridNode.gridArray[gridX][gridY].state = battle(block1, block2: block2)
                        }
                    }
                        
                        //Otherwise if the block along the wall is inactive...
                    else if preSwipeGrid.gridArray[gridX][gridY].state == dummyType {
                        
                        // Change the value to the adjacent cell's value
                        gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX][gridY-1].state
                        
                    }
                    
                } else {
                    
                    //set the value of the gridArray equal to the value at the previous row (no conditional)
                    //stops at the last row (can't have a row = -1)
                    
                    gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX][gridY-1].state
                }
            }
            
            //set the zeroith row equal to what's in the stage
            
            gridNode.gridArray[gridX][0].state = bottomStageNode.stageArray[gridX].state
            
            //reset the stage to all .inactive
            
            bottomStageNode.stageArray[gridX].state = .inactive
        }
        
        //add a new block to the empty stage
        
        bottomStageNode.addBlockToEmptyStage()
        
    }
    
    
    
    func swipedDown(sender:UISwipeGestureRecognizer){
        let preSwipeGrid = gridNode
        
        //loop through the columns
        for gridX in 0..<columns{
            
            //loop through the rows
            for gridY in 0..<rows-1 {
                
                // Is the row we're on, on the edge (aka wall row)?
                if gridY == 0 {
                    let dummyType: BlockType = .inactive
                    
                    // If block along the wall is active...
                    if preSwipeGrid.gridArray[gridX][gridY].state != dummyType  {
                        
                        // If the adjacent block is inactive...
                        if preSwipeGrid.gridArray[gridX][gridY+1].state == dummyType {
                            
                            // Do not change the value if on the wall and adjacent value is inactive
                            gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX][gridY].state
                        }
                            
                            //Otherwise if the adjacent block is active...
                        else if preSwipeGrid.gridArray[gridX][gridY+1].state != dummyType {
                            
                            // APPLY COLLISION RULES!!
                            let block1: BlockType = preSwipeGrid.gridArray[gridX][gridY].state
                            let block2: BlockType = preSwipeGrid.gridArray[gridX][gridY+1].state
                            
                            gridNode.gridArray[gridX][gridY].state = battle(block1, block2: block2)
                        }
                    }
                        
                        //Otherwise if the block along the wall is inactive...
                    else if preSwipeGrid.gridArray[gridX][gridY].state == dummyType {
                        
                        // Change the value to the adjacent cell's value
                        gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX][gridY+1].state
                        
                    }
                    
                } else {
                    
                    //set the value of the gridArray equal to the value at the previous row (no conditional)
                    //stops at the last row (can't have a row = -1)
                    
                    gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX][gridY+1].state
                }
            }
            
            //set the top row equal to what's in the stage
            
            gridNode.gridArray[gridX][rows-1].state = topStageNode.stageArray[gridX].state
            
            //reset the stage to all .inactive
            
            topStageNode.stageArray[gridX].state = .inactive
        }
        
        //add a new block to the empty stage
        
        topStageNode.addBlockToEmptyStage()
        
        
    }
    
    func swipedLeft(sender:UISwipeGestureRecognizer){
        
        let preSwipeGrid = gridNode
        
        //loop through the rows
        for gridY in 0..<rows{
            
            //loop through the columns
            for gridX in 0..<columns-1 {
                
                
                // Is the row we're on, on the edge (aka wall row)?
                if gridX == 0 {
                    let dummyType: BlockType = .inactive
                    
                    // If block along the wall is active...
                    if preSwipeGrid.gridArray[gridX][gridY].state != dummyType  {
                        
                        // If the adjacent block is inactive...
                        if preSwipeGrid.gridArray[gridX+1][gridY].state == dummyType {
                            
                            // Do not change the value if on the wall and adjacent value is inactive
                            gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX][gridY].state
                        }
                            
                            //Otherwise if the adjacent block is active...
                        else if preSwipeGrid.gridArray[gridX+1][gridY].state != dummyType {
                            
                            // APPLY COLLISION RULES!!
                            let block1: BlockType = preSwipeGrid.gridArray[gridX][gridY].state
                            let block2: BlockType = preSwipeGrid.gridArray[gridX+1][gridY].state
                            
                            gridNode.gridArray[gridX][gridY].state = battle(block1, block2: block2)
                        }
                    }
                        
                        //Otherwise if the block along the wall is inactive...
                    else if preSwipeGrid.gridArray[gridX][gridY].state == dummyType {
                        
                        // Change the value to the adjacent cell's value
                        gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX+1][gridY].state
                        
                    }
                    
                } else {
                    
                    //set the value of the gridArray equal to the value at the previous row (no conditional)
                    //stops at the last row (can't have a row = -1)
                    
                    gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX+1][gridY].state
                }
                
                //set the value of the gridArray equal to the value at the previous column (no conditional)
                //stops at the last column (can't have a column = -1)
                
                //gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX+1][gridY].state
            }
            
            //set the top column equal to what's in the stage
            
            gridNode.gridArray[columns-1][gridY].state = rightStageNode.stageArray[gridY].state
            
            //reset the stage to all .inactive
            
            rightStageNode.stageArray[gridY].state = .inactive
        }
        
        //add a new block to the empty stage
        
        rightStageNode.addBlockToEmptyStage()
        
    }
    
    func swipedRight(sender:UISwipeGestureRecognizer){
        
        let preSwipeGrid = gridNode
        
        //loop through the rows
        for gridY in 0..<rows{
            
            //loop through the columns
            for gridX in (columns-1).stride(through: 1, by: -1) {
                
                
                // Is the row we're on, on the edge (aka wall row)?
                if gridX == columns-1 {
                    let dummyType: BlockType = .inactive
                    
                    // If block along the wall is active...
                    if preSwipeGrid.gridArray[gridX][gridY].state != dummyType  {
                        
                        // If the adjacent block is inactive...
                        if preSwipeGrid.gridArray[gridX-1][gridY].state == dummyType {
                            
                            // Do not change the value if on the wall and adjacent value is inactive
                            gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX][gridY].state
                        }
                            
                            //Otherwise if the adjacent block is active...
                        else if preSwipeGrid.gridArray[gridX-1][gridY].state != dummyType {
                            
                            // APPLY COLLISION RULES!!
                            let block1: BlockType = preSwipeGrid.gridArray[gridX][gridY].state
                            let block2: BlockType = preSwipeGrid.gridArray[gridX-1][gridY].state
                            
                            gridNode.gridArray[gridX][gridY].state = battle(block1, block2: block2)
                        }
                    }
                        
                        //Otherwise if the block along the wall is inactive...
                    else if preSwipeGrid.gridArray[gridX][gridY].state == dummyType {
                        
                        // Change the value to the adjacent cell's value
                        gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX-1][gridY].state
                        
                    }
                    
                } else {
                    
                    //set the value of the gridArray equal to the value at the previous row (no conditional)
                    //stops at the last row (can't have a row = -1)
                    
                    gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX-1][gridY].state
                }
                
                //set the value of the gridArray equal to the value at the previous column (no conditional)
                //stops at the last column (can't have a column = -1)
                
                //gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX-1][gridY].state
            }
            
            //set the top column equal to what's in the stage
            
            gridNode.gridArray[0][gridY].state = leftStageNode.stageArray[gridY].state
            
            //reset the stage to all .inactive
            
            leftStageNode.stageArray[gridY].state = .inactive
        }
        
        //add a new block to the empty stage
        
        leftStageNode.addBlockToEmptyStage()
        
    }
    
    
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
    
    //    func swipe(swipeDirection: swipeType) {
    //
    //        let preSwipeGrid = gridNode
    //
    //        //loop through the columns
    //        for gridX in 0..<columns{
    //
    //            //loop through the rows
    //            for gridY in (rows-1).stride(through: 1, by: -1) {
    //
    //                //set the value of the gridArray equal to the value at the previous row (no conditional)
    //                //stops at the last row (can't have a row = -1)
    //
    //                gridNode.gridArray[gridX][gridY].state = preSwipeGrid.gridArray[gridX][gridY-1].state
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
    
    func battle(block1: BlockType, block2: BlockType) -> BlockType {
        let rock: BlockType = .rock
        let paper: BlockType = .paper
        let scissors: BlockType = .scissors
        
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
        } else {
            return .inactive
        }
        
        
    }
}



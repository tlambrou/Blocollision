//
//  GameScene.swift
//  iSoBlocks
//
//  Created by Tassos Lambrou on 7/9/16.
//  Copyright (c) 2016 Ssos Games. All rights reserved.
//
import Foundation
import SpriteKit

enum swipeType {
    case up, down, left, right
}

struct Outcome {
    var winnner:Block
    var loser:Block
    //Int that is 0 if tied, 1 if block 1 wins, and 2 if block 2 wins
    var tie: Int
}



var idle: Bool = false
var instShown: Bool = false
var firstInstShown: Bool = false
var scoreLabel: SKLabelNode!

var score: Int = 0 {
didSet {
    scoreLabel.text = String(score)
} }

var timeElapsed: Int = 0 {
didSet {
    if timeElapsed > 180 && firstInstShown == false {
        idle = true
    } else if timeElapsed > 600 && firstInstShown == true {
        idle = true
    } else if timeElapsed < 180 {
        idle = false
    }
}
}


class GameScene: SKScene {
    
    
    var gridNode: Grid!
    var topStageNode: StageH!
    var bottomStageNode: StageH!
    var leftStageNode: StageV!
    var rightStageNode: StageV!
    var restartButton: MSButtonNode!
    var swipeInstructions: SKSpriteNode!
    
    
    
    func swipedUp(sender:UISwipeGestureRecognizer) {
        swipe(.up)
        
        // Check for complete rows
        rowsCheck()
        
        // Check for complete columns
        columnsCheck()
    }
    
    func swipedDown(sender:UISwipeGestureRecognizer) {
        swipe(.down)
        
        // Check for complete rows
        rowsCheck()
        
        // Check for complete columns
        columnsCheck()
    }
    
    func swipedLeft(sender:UISwipeGestureRecognizer) {
        swipe(.left)
        
        // Check for complete rows
        rowsCheck()
        
        // Check for complete columns
        columnsCheck()
    }
    
    func swipedRight(sender:UISwipeGestureRecognizer) {
        swipe(.right)
        
        // Check for complete rows
        rowsCheck()
        
        // Check for complete columns
        columnsCheck()
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
        swipeInstructions = childNodeWithName("swipeInstructions") as! SKSpriteNode
        scoreLabel = childNodeWithName("scoreLabel") as! SKLabelNode
        swipeInstructions.alpha = CGFloat(0)
        
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
        
        timeElapsed = 0
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        timeElapsed += 1
        //        print("timeElapsed: \(timeElapsed)")
        //        print("idle: \(idle)")
        //        print("instShown: \(instShown)")
        //        print("firstInstShown: \(firstInstShown)")
        //        print("alpha: \(swipeInstructions.alpha)")
        if instShown == false && idle == true {
            instShown = true
            
            let fadeUp = SKAction.fadeAlphaTo(1.0, duration: NSTimeInterval(1.0))
            let fadeDown = SKAction.fadeAlphaTo(0.55, duration: NSTimeInterval(1.0))
            
            let sequence = SKAction.repeatActionForever(SKAction.sequence([fadeUp, fadeDown]))
            swipeInstructions.runAction(sequence)
            firstInstShown = true
            
        } else if instShown == true && idle == false {
            instShown = false
            let fadeDown = SKAction.fadeAlphaTo(0, duration: NSTimeInterval(0.5))
            swipeInstructions.removeAllActions()
            swipeInstructions.runAction(fadeDown)
            
            
        }
        
    }
    
    //MAIN SWIPE FUNCTION
    func swipe(swipeDirection: swipeType) {
        var xStart: Int
        var xEnd: Int
        var yStart: Int
        var yEnd: Int
        var xIncrement: Int = 1
        var yIncrement: Int = 1
        var stageRegen: Bool = false
        
        timeElapsed = 0
        
        switch swipeDirection {
        case .up:
            //print("swiped up")
            xStart = 0
            xEnd = columns-1
            yStart = rows-1
            yEnd = 0
            xIncrement = 1
            yIncrement = -1
            
        case .down:
            //print("swiped down")
            xStart = columns-1
            xEnd = 0
            yStart = 0
            yEnd = rows-1
            xIncrement = -1
            yIncrement = 1
            
        case .left:
            //print("swiped left")
            xStart = 0
            xEnd = columns-1
            yStart = 0
            yEnd = rows-1
            xIncrement = 1
            yIncrement = 1
            
        case .right:
            //print("swiped right")
            xStart = columns-1
            xEnd = 0
            yStart = rows-1
            yEnd = 0
            xIncrement = -1
            yIncrement = -1
            
            
        }
        
        
        // If direction of swipe is vertical...
        if (swipeDirection == .up) || (swipeDirection == .down) {
            
            // loop through the columns
            for gridX in xStart.stride(through: xEnd, by: xIncrement){
                
                // loop through the rows
                for gridY in yStart.stride(through: yEnd, by: yIncrement) {
                    
                    if gridY != yEnd {
                        // Set the current & next blocks
                        let currentBlock = gridNode.gridArray[gridX][gridY]
                        let nextBlock = gridNode.gridArray[gridX][gridY+yIncrement]
                        
                        // Perform the collision rules
                        collisionRules(currentBlock, nextBlock: nextBlock)
                        
                        // Check to see if the Stage Regen needs to be reset
                        if ((nextBlock.state != .inactive) && (currentBlock.state == nextBlock.state)) || ((nextBlock.state != .inactive) && (currentBlock.state == .inactive)) {
                            stageRegen = true
                        }
                        
                        //MARK: Last Row Vertical
                        // Is it the last row?
                    } else if gridY == yEnd {
                        
                        let currentBlock = gridNode.gridArray[gridX][gridY]
                        
                        //MARK: Swipe Up
                        // Is it a swipe up?
                        if swipeDirection == .up {
                            
                            
                            // Change the Next Block to the Stage
                            let nextBlock = bottomStageNode.stageArray[gridX]
                            
                            // Check to see if the Stage Regen needs to be reset
                            if ((nextBlock.state != .inactive) && (currentBlock.state == nextBlock.state)) || ((nextBlock.state != .inactive) && (currentBlock.state == .inactive)) {
                                stageRegen = true
                            }
                            
                            // Perform the collision rules
                            collisionRules(currentBlock, nextBlock: nextBlock)
                            
                            
                            
                        }
                            
                            //MARK: Swipe Down
                            // Is it a swipe down?
                        else if swipeDirection == .down {
                            let nextBlock = topStageNode.stageArray[gridX]
                            
                            // Check to see if the Stage Regen needs to be reset
                            if ((nextBlock.state != .inactive) && (currentBlock.state == nextBlock.state)) || ((nextBlock.state != .inactive) && (currentBlock.state == .inactive)) {
                                stageRegen = true
                            }
                            
                            // Perform the collision rules
                            collisionRules(currentBlock, nextBlock: nextBlock)
                            
                            
                            
                        }
                        
                        
                    }
                    
                }
                
                // Is the regen bool equal to true?
                if stageRegen == true {
                    
                    // Is it swipe up?
                    if swipeDirection == .up {
                        
                        // Clear the stage
                        bottomStageNode.stageArray[gridX].state = .inactive
                        
                        // Is it swipe down?
                    } else if swipeDirection == .down {
                        
                        // Clear the stage
                        topStageNode.stageArray[gridX].state = .inactive
                        
                    }
                }
            }
            
            // Is the swipe up & stage regen is true?
            if swipeDirection == .up && stageRegen == true {
                
                // Add a new block to the stage
                bottomStageNode.addBlockToEmptyStage()
                
                // Reset the stage regen bool to false
                stageRegen = false
                
                //Is the swipe down & stage regen is true?
            } else if swipeDirection == .down && stageRegen == true {
                
                // Add a new block to the stage
                topStageNode.addBlockToEmptyStage()
                
                // Reset the stage regen bool to false
                stageRegen = false
            }
        }
        
        
        // If direction of swipe is horizontal...
        if (swipeDirection == .left) || (swipeDirection == .right) {
            
            // loop through the rows
            for gridY in yStart.stride(through: yEnd, by: yIncrement){
                
                // loop through the columns
                for gridX in xStart.stride(through: xEnd, by: xIncrement) {
                    
                    if gridX != xEnd {
                        // Set the current & next blocks
                        let currentBlock = gridNode.gridArray[gridX][gridY]
                        let nextBlock = gridNode.gridArray[gridX+xIncrement][gridY]
                        
                        // Perform the collision rules
                        collisionRules(currentBlock, nextBlock: nextBlock)
                        
                        // Check to see if the Stage Regen needs to be reset
                        if ((nextBlock.state != .inactive) && (currentBlock.state == nextBlock.state)) || ((nextBlock.state != .inactive) && (currentBlock.state == .inactive)) {
                            stageRegen = true
                        }
                        
                        //MARK: Last Column Horizontal
                        // Is it the last column?
                    } else if gridX == xEnd {
                        
                        let currentBlock = gridNode.gridArray[gridX][gridY]
                        
                        //MARK: Swipe Left
                        // Is it a swipe left?
                        if swipeDirection == .left {
                            
                            
                            // Change the Next Block to the Stage
                            let nextBlock = rightStageNode.stageArray[gridY]
                            
                            // Check to see if the Stage Regen needs to be reset
                            if ((nextBlock.state != .inactive) && (currentBlock.state == nextBlock.state)) || ((nextBlock.state != .inactive) && (currentBlock.state == .inactive)) {
                                stageRegen = true
                            }
                            
                            //                            print(currentBlock.position)
                            
                            // Perform the collision rules
                            collisionRules(currentBlock, nextBlock: nextBlock)
                            
                            
                            
                        }
                            
                            //MARK: Swipe Right
                            // Is it a swipe right?
                        else if swipeDirection == .right {
                            let nextBlock = leftStageNode.stageArray[gridY]
                            
                            // Check to see if the Stage Regen needs to be reset
                            if ((nextBlock.state != .inactive) && (currentBlock.state == nextBlock.state)) || ((nextBlock.state != .inactive) && (currentBlock.state == .inactive)) {
                                stageRegen = true
                            }
                            
                            // Perform the collision rules
                            collisionRules(currentBlock, nextBlock: nextBlock)
                            
                            
                            
                        }
                        
                        
                    }
                    
                }
                
                // Is the regen bool equal to true?
                if stageRegen == true {
                    
                    // Is it swipe left?
                    if swipeDirection == .left {
                        
                        // Clear the stage
                        rightStageNode.stageArray[gridY].state = .inactive
                        
                        // Is it swipe right?
                    } else if swipeDirection == .right {
                        
                        // Clear the stage
                        leftStageNode.stageArray[gridY].state = .inactive
                        
                    }
                }
            }
            
            // Is the swipe left & stage regen is true?
            if swipeDirection == .left && stageRegen == true {
                
                // Add a new block to the stage
                rightStageNode.addBlockToEmptyStage()
                
                // Reset the stage regen bool to false
                stageRegen = false
                
                //Is the swipe right & stage regen is true?
            } else if swipeDirection == .right && stageRegen == true {
                
                // Add a new block to the stage
                leftStageNode.addBlockToEmptyStage()
                
                // Reset the stage regen bool to false
                stageRegen = false
            }
        }
        
        
        
    }
    
    func battle(block1: BlockType, block2: BlockType) -> BlockType {
        let red: BlockType = .red
        let blue: BlockType = .blue
        let green: BlockType = .green
        let inactive: BlockType = .inactive
        
        //red vs blue...
        if ((block1 == red) && (block2 == blue)) || ((block1 == blue) && (block2 == red)) {
            //blue wins!!
            return blue
            
            //blue vs green
        } else if ((block1 == blue) && (block2 == green)) || ((block1 == green) && (block2 == blue)) {
            //green wins!!
            return green
            
            //green vs red
        } else if ((block1 == green) && (block2 == red)) || ((block1 == red) && (block2 == green)) {
            //red wins!!
            return red
            
            // red vs nothing
        } else if ((block1 == inactive) && (block2 == red)) || ((block1 == red) && (block2 == inactive)) {
            //red wins!!
            return red
            
            // blue vs nothing
        } else if ((block1 == inactive) && (block2 == blue)) || ((block1 == blue) && (block2 == inactive)) {
            //blue wins!!
            return blue
            
            // green vs nothing
        } else if ((block1 == inactive) && (block2 == green)) || ((block1 == green) && (block2 == inactive)) {
            //blue wins!!
            return green
            
            // nothing vs nothing
        } else if ((block1 == inactive) && (block2 == inactive)) || ((block1 == inactive) && (block2 == inactive)) {
            //nothing wins!!
            return inactive
            
            // red vs red
        } else if ((block1 == red) && (block2 == red)) || ((block1 == red) && (block2 == red)) {
            //red wins!!
            return red
            
            // blue vs blue
        } else if ((block1 == blue) && (block2 == blue)) || ((block1 == blue) && (block2 == blue)) {
            //blue wins!!
            return blue
            
            // green vs green
        } else if ((block1 == green) && (block2 == green)) || ((block1 == green) && (block2 == green)) {
            //green wins!!
            return green
        }
            
        else{
            return block1
            
        }
        
        
    }
    
    func collision(block1: Block, block2: Block) -> Outcome {
        let red: BlockType = .red
        let blue: BlockType = .blue
        let green: BlockType = .green
        let inactive: BlockType = .inactive
        let block1State = block1.state
        let block2State = block2.state
        
        //red vs blue...
        if (block1State == red) && (block2State == blue) {
            //Do nothing
            return Outcome(winnner: block1, loser: block2, tie: 0)
            
            //blue vs red
        } else if (block1State == blue) && (block2State == red) {
            //Do nothing
            return Outcome(winnner: block1, loser: block2, tie: 0)
            
            //blue vs green
        } else if (block1State == blue) && (block2State == green){
            //Do nothing
            return Outcome(winnner: block2, loser: block1, tie: 0)
            
            //green vs blue
        } else if (block1State == green) && (block2State == blue) {
            //Do nothing
            return Outcome(winnner: block1, loser: block2, tie: 0)
            
            //green vs red
        } else if (block1State == green) && (block2State == red){
            //Do nothing
            return Outcome(winnner: block2, loser: block1, tie: 0)
            
            //red vs green
        } else if (block1State == red) && (block2State == green) {
            //Do nothing
            return Outcome(winnner: block1, loser: block2, tie: 0)
            
            // nothing vs red
        } else if (block1State == inactive) && (block2State == red) {
            //block2 wins!!
            return Outcome(winnner: block2, loser: block1, tie: 2)
            
            // red vs nothing
        } else if (block1State == red) && (block2State == inactive) {
            //block1 wins!!
            return Outcome(winnner: block1, loser: block2, tie: 1)
            
            // blue vs nothing
        } else if (block1State == blue) && (block2State == inactive) {
            //block1 wins!!
            return Outcome(winnner: block1, loser: block2, tie: 1)
            
            // nothing vs blue
        } else if (block1State == inactive) && (block2State == blue) {
            //block2 wins!!
            return Outcome(winnner: block2, loser: block1, tie: 2)
            
            // green vs nothing
        } else if (block1State == green) && (block2State == inactive) {
            //block1 wins!!
            return Outcome(winnner: block1, loser: block2, tie: 1)
            
            // nothing vs green
        } else if (block1State == inactive) && (block2State == green){
            //block2 wins!!
            return Outcome(winnner: block2, loser: block1, tie: 2)
            
            // nothing vs nothing
        } else if ((block1State == inactive) && (block2State == inactive)) || ((block1State == inactive) && (block2State == inactive)) {
            // combine
            return Outcome(winnner: block1, loser: block2, tie: 1)
            
            // red vs red
        } else if ((block1State == red) && (block2State == red)) || ((block1State == red) && (block2State == red)) {
            // combine
            return Outcome(winnner: block1, loser: block2, tie: 1)
            
            // blue vs blue
        } else if ((block1State == blue) && (block2State == blue)) || ((block1State == blue) && (block2State == blue)) {
            // combine
            return Outcome(winnner: block1, loser: block2, tie: 1)
            
            // green vs green
        } else if ((block1State == green) && (block2State == green)) || ((block1State == green) && (block2State == green)) {
            // combine
            return Outcome(winnner: block1, loser: block2, tie: 1)
        }
            
        else{
            
            print("collision rules did not work")
            return Outcome(winnner: block1, loser: block2, tie: 0)
            
            
        }
        
        
    }
    
    func animateCollision(block1: Block, block2: Block) {
        
        let result: Outcome = collision(block1, block2: block2)
        
        let winBlock = result.winnner
        let loseBlock = result.loser
        let tie = result.tie
        
        var winAssetString = ""
        var loseAssetString = ""
        var winAssetString2 = ""
        var loseAssetString2 = ""
        
        switch winBlock.state {
        case .red:
            winAssetString = "RoundRectCoral"
        case .blue:
            winAssetString = "RoundRectTeal"
        case .green:
            winAssetString = "RoundRectGreen"
        case .inactive:
            winAssetString = "RoundRect"
            
        }
        
        switch loseBlock.state {
        case .red:
            loseAssetString = "RoundRectCoral"
        case .blue:
            loseAssetString = "RoundRectTeal"
        case .green:
            loseAssetString = "RoundRectGreen"
        case .inactive:
            loseAssetString = "RoundRect"
            
        }
        
        switch winBlock.state {
        case .red:
            winAssetString2 = "RoundRectCoral"
        case .blue:
            winAssetString2 = "RoundRectTeal"
        case .green:
            winAssetString2 = "RoundRectGreen"
        case .inactive:
            winAssetString2 = "RoundRect"
            
        }
        
        switch loseBlock.state {
        case .red:
            loseAssetString2 = "RoundRectCoral"
        case .blue:
            loseAssetString2 = "RoundRectTeal"
        case .green:
            loseAssetString2 = "RoundRectGreen"
        case .inactive:
            loseAssetString2 = "RoundRect"
            
        }
        
        if (tie == 0) && (winBlock == block2) && (loseBlock.state != .inactive) {
            
            let winNode = SKSpriteNode(imageNamed: winAssetString)
            let scale = SKAction.scaleTo(1.35, duration: 0.1)
            let descale = SKAction.scaleTo(1, duration: 0.1)
            let destination = loseBlock.position
            let move = SKAction.moveTo(destination, duration: 0.2)
            let remove = SKAction.removeFromParent()
            let wait = SKAction.waitForDuration(0.4)
            
            winNode.position = winBlock.position
            /* Position winNode at the location of the winning block */
            winNode.anchorPoint = winBlock.anchorPoint
            winNode.size = winBlock.size
            let loseNode = SKSpriteNode(imageNamed: loseAssetString)
            loseNode.position = loseBlock.position
            loseNode.size = loseBlock.size
            loseNode.anchorPoint = loseBlock.anchorPoint
            loseNode.zPosition = 2
            winNode.zPosition = 3
            gridNode.addChild(loseNode)
            gridNode.addChild(winNode)
            let collisionSeq = SKAction.sequence([scale, move, descale, remove])
            winNode.runAction(collisionSeq)
            loseNode.runAction(SKAction.sequence([wait, remove]))
            
            
        } else if (tie == 0) && (winBlock == block1) && (loseBlock.state != .inactive){
            
            
            let winNode2 = SKSpriteNode(imageNamed: winAssetString2)
            let scale2 = SKAction.scaleTo(1.35, duration: 0.1)
            let descale2 = SKAction.scaleTo(1, duration: 0.1)
            let destination2 = winBlock.position
            let move2 = SKAction.moveTo(destination2, duration: 0.2)
            let remove2 = SKAction.removeFromParent()
            //            let wait2 = SKAction.waitForDuration(0.4)
            
            winNode2.position = winBlock.position
            /* Position winNode at the location of the winning block */
            winNode2.anchorPoint = winBlock.anchorPoint
            winNode2.size = winBlock.size
            let loseNode2 = SKSpriteNode(imageNamed: loseAssetString2)
            loseNode2.position = loseBlock.position
            loseNode2.size = loseBlock.size
            loseNode2.anchorPoint = loseBlock.anchorPoint
            loseNode2.zPosition = 2
            winNode2.zPosition = 3
            
            gridNode.addChild(loseNode2)
            gridNode.addChild(winNode2)
            
            let collisionSeq2 = SKAction.sequence([scale2, descale2, remove2])
            winNode2.runAction(collisionSeq2)
            loseNode2.runAction(SKAction.sequence([move2, remove2]))
            
            
            
        } else if (tie == 2) && loseBlock.state != .inactive {
            
            let winNode = SKSpriteNode(imageNamed: winAssetString)
//            let scale = SKAction.scaleTo(1.35, duration: 0.1)
//            let descale = SKAction.scaleTo(1, duration: 0.1)
            let destination = loseBlock.position
            let move = SKAction.moveTo(destination, duration: 0.2)
            let remove = SKAction.removeFromParent()
            let wait = SKAction.waitForDuration(0.4)
            
            winNode.position = winBlock.position
            /* Position winNode at the location of the winning block */
            winNode.anchorPoint = winBlock.anchorPoint
            winNode.size = winBlock.size
            let loseNode = SKSpriteNode(imageNamed: loseAssetString)
            loseNode.position = loseBlock.position
            loseNode.size = loseBlock.size
            loseNode.anchorPoint = loseBlock.anchorPoint
            loseNode.zPosition = 2
            winNode.zPosition = 3
            //
            //            print("winNode State: \(winBlock.state)")
            //            print("winNode Position: \(winNode.position)")
            //            print("loseNode Position: \(loseNode.position)")
            gridNode.addChild(loseNode)
            gridNode.addChild(winNode)
            let collisionSeq = SKAction.sequence([ move, wait, remove])
            winNode.runAction(collisionSeq)
            loseNode.runAction(SKAction.sequence([wait, remove]))
            
            
        } else if (tie == 1) && loseBlock.state != .inactive {
            
            let winNode2 = SKSpriteNode(imageNamed: winAssetString2)
            let scale2 = SKAction.scaleTo(1.35, duration: 0.1)
            let descale2 = SKAction.scaleTo(1, duration: 0.1)
            let destination2 = winBlock.position
            let move2 = SKAction.moveTo(destination2, duration: 0.2)
            let remove2 = SKAction.removeFromParent()
            //            let wait2 = SKAction.waitForDuration(0.4)
            
            winNode2.position = winBlock.position
            /* Position winNode at the location of the winning block */
            winNode2.anchorPoint = winBlock.anchorPoint
            winNode2.size = winBlock.size
            let loseNode2 = SKSpriteNode(imageNamed: loseAssetString2)
            loseNode2.position = loseBlock.position
            loseNode2.size = loseBlock.size
            loseNode2.anchorPoint = loseBlock.anchorPoint
            loseNode2.zPosition = 2
            winNode2.zPosition = 3
            //
            //            print("winNode2 State: \(winBlock.state)")
            //            print("winNode2 Position: \(winNode2.position)")
            //            print("loseNode2 Position: \(loseNode2.position)")
            
            gridNode.addChild(loseNode2)
            gridNode.addChild(winNode2)
            
            let collisionSeq2 = SKAction.sequence([scale2, descale2, remove2])
            winNode2.runAction(collisionSeq2)
            loseNode2.runAction(SKAction.sequence([move2, remove2]))
            
            
        }
        
        
        
        
    }
    
    func collisionRules (currentBlock: Block, nextBlock: Block) {
        
        // Is the Next Inactive?
        if nextBlock.state != .inactive {
            
            
            // Is the Current Inactive?
            if currentBlock.state != .inactive {
                
                // Are Current & Next the same values?
                if currentBlock.state == nextBlock.state {
                    
                    
                    // Animate the collision
                    animateCollision(currentBlock, block2: nextBlock)
                    
                    // Combine stack values
                    currentBlock.stack += nextBlock.stack
                    
                    // Set the Next block to .inactive
                    nextBlock.state = .inactive
                    
                } else {
                    
                    // Do Nothing
                    
                }
                
                
            } else if currentBlock.state == .inactive {
                
                // Animate the collision
                animateCollision(currentBlock, block2: nextBlock)
                
                // Copy over state
                currentBlock.state = nextBlock.state
                
                // Combine stack values
                currentBlock.stack += nextBlock.stack
                
                // Set the Next block to .inactive
                nextBlock.state = .inactive
                
            }
            
            
        } else {
            
            // Do Nothing
            
        }
        
        
    }
    
    func rowsCheck () {
        
        var monkeyBeer: Int = 0
        
        // Loop through the rows
        for gridY in 0..<rows {
            // Loop through the columns
            for gridX in 1..<columns {
                
                let currentBlock = gridNode.gridArray[gridX][gridY]
                let prevBlock = gridNode.gridArray[gridX-1][gridY]
                
                if (currentBlock.state == prevBlock.state) && (prevBlock.state != .inactive) {
                    
                    monkeyBeer += 1
                    
                } else {
                    
                    monkeyBeer = 0
                    break
                }
                
                if (monkeyBeer == 3)   {
                    
                    //Call clear row and/or clear blocks function
                    clearRow(gridY)
                    monkeyBeer = 0
                    break
                    
                }
            }
        }
        
    }
    
    func columnsCheck () {
        
        var monkeyBeer: Int = 0
        
        // Loop through the rows
        for gridX in 0..<columns {
            // Loop through the columns
            for gridY in 1..<rows {
                
                let currentBlock = gridNode.gridArray[gridX][gridY]
                let prevBlock = gridNode.gridArray[gridX][gridY-1]
                
                if (currentBlock.state == prevBlock.state) && (prevBlock.state != .inactive) {
                    
                    monkeyBeer += 1
                    
                } else {
                    
                    monkeyBeer = 0
                    break
                }
                
                if (monkeyBeer == 3)   {
                    
                    //Call clear column and/or clear blocks function
                    clearColumn(gridX)
                    monkeyBeer = 0
                    break
                    
                }
            }
        }
        
    }
    
    func clearRow (rowNumber: Int) {
        let gridY = rowNumber
        var rowScore: Int = 1
        
        // Loop through the row
        for gridX in 0..<columns {
            
            let currentBlock = gridNode.gridArray[gridX][gridY]
            
            // Multiply the current stack times the rowScore
            rowScore = rowScore * currentBlock.stack
            
            // Set the node equal to inactive
            currentBlock.state = .inactive
            
        }
        
        // Add the rowScore to the player's score
        score += rowScore
        
        /* Play SFX */
        let scoreSFX = SKAction.playSoundFileNamed("clearRow", waitForCompletion: true)
        self.runAction(scoreSFX)
    }
    
    func clearColumn (columnNumber: Int) {
        let gridX = columnNumber
        var columnScore: Int = 1
        
        // Loop through the row
        for gridY in 0..<rows {
            
            let currentBlock = gridNode.gridArray[gridX][gridY]
            
            // Multiply the current stack times the rowScore
            columnScore = columnScore * currentBlock.stack
            
            // Set the node equal to inactive
            currentBlock.state = .inactive
            
        }
        
        // Add the rowScore to the player's score
        score += columnScore
        
        /* Play SFX */
        let scoreSFX = SKAction.playSoundFileNamed("clearRow", waitForCompletion: true)
        self.runAction(scoreSFX)
    }
    
    
}


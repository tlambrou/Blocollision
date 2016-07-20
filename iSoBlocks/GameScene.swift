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
        print("timeElapsed: \(timeElapsed)")
        print("idle: \(idle)")
        print("instShown: \(instShown)")
        print("firstInstShown: \(firstInstShown)")
        print("alpha: \(swipeInstructions.alpha)")
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
                            
                            
                            //INSERT ANIMATION!!!!!
                            
                            animateCollision(gridNode.gridArray[gridX][gridY], block2: gridNode.gridArray[gridX][gridY+yIncrement])
                            
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
                        
                        //Create a reference variable to make cleaner
                        let nextBlock = gridNode.gridArray[gridX+xIncrement][gridY].state
                        
                        // Are the current and adjacent blocks different?...
                        if currentBlock != nextBlock {
                            
                            animateCollision(gridNode.gridArray[gridX][gridY], block2: gridNode.gridArray[gridX+xIncrement][gridY])
                            
                            // Clear the next block state to inactive...
                            gridNode.gridArray[gridX+xIncrement][gridY].state = .inactive
                            
                            // If so perform a battle and set the current block equal to the winner
                            gridNode.gridArray[gridX][gridY].state = battle(currentBlock, block2: nextBlock)
                            
                           
                            
                            
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
    
    
    func collision(block1: Block, block2: Block) -> Outcome {
        let rock: BlockType = .rock
        let paper: BlockType = .paper
        let scissors: BlockType = .scissors
        let inactive: BlockType = .inactive
        let block1State = block1.state
        let block2State = block2.state
        
        //rock vs paper...
        if (block1State == rock) && (block2State == paper) {
            //block2 wins!!
            return Outcome(winnner: block2, loser: block1, tie: 2)
            
            //paper vs rock
        } else if (block1State == paper) && (block2State == rock) {
            //block1 wins!!
            return Outcome(winnner: block1, loser: block2, tie: 1)
            
            //paper vs scissors
        } else if (block1State == paper) && (block2State == scissors){
            //block2 wins!!
            return Outcome(winnner: block2, loser: block1, tie: 2)
            
            //scissors vs paper
        } else if (block1State == scissors) && (block2State == paper) {
            //block1 wins!!
            return Outcome(winnner: block1, loser: block2, tie: 1)
            
            //scissors vs rock
        } else if (block1State == scissors) && (block2State == rock){
            //block2 wins!!
            return Outcome(winnner: block2, loser: block1, tie: 2)
            
            //rock vs scissors
        } else if (block1State == rock) && (block2State == scissors) {
            //block1 wins!!
            return Outcome(winnner: block1, loser: block2, tie: 1)
            
            // nothing vs rock
        } else if (block1State == inactive) && (block2State == rock) {
            //block2 wins!!
            return Outcome(winnner: block2, loser: block1, tie: 2)
            
            // rock vs nothing
        } else if (block1State == rock) && (block2State == inactive) {
            //block1 wins!!
            return Outcome(winnner: block1, loser: block2, tie: 1)
            
            // paper vs nothing
        } else if (block1State == paper) && (block2State == inactive) {
            //block1 wins!!
            return Outcome(winnner: block1, loser: block2, tie: 1)
            
            // nothing vs paper
        } else if (block1State == inactive) && (block2State == paper) {
            //block2 wins!!
            return Outcome(winnner: block2, loser: block1, tie: 2)
            
            // scissors vs nothing
        } else if (block1State == scissors) && (block2State == inactive) {
            //block1 wins!!
            return Outcome(winnner: block1, loser: block2, tie: 1)
            
            // nothing vs scissors
        } else if (block1State == inactive) && (block2State == scissors){
            //block2 wins!!
            return Outcome(winnner: block2, loser: block1, tie: 2)
            
            // nothing vs nothing
        } else if ((block1State == inactive) && (block2State == inactive)) || ((block1State == inactive) && (block2State == inactive)) {
            //tie!!
            return Outcome(winnner: block1, loser: block2, tie: 0)
            
            // rock vs rock
        } else if ((block1State == rock) && (block2State == rock)) || ((block1State == rock) && (block2State == rock)) {
            //tie!!
            return Outcome(winnner: block1, loser: block2, tie: 0)
            
            // paper vs paper
        } else if ((block1State == paper) && (block2State == paper)) || ((block1State == paper) && (block2State == paper)) {
            //tie!!
            return Outcome(winnner: block1, loser: block2, tie: 0)
            
            // scissors vs scissors
        } else if ((block1State == scissors) && (block2State == scissors)) || ((block1State == scissors) && (block2State == scissors)) {
            //tie!!
            return Outcome(winnner: block1, loser: block2, tie: 0)
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
        
        if (tie != 0) && (winBlock == block2) && (loseBlock.state != .inactive) {
            
            switch winBlock.state {
            case .rock:
                winAssetString = "RockBlock"
            case .paper:
                winAssetString = "PaperBlock"
            case .scissors:
                winAssetString = "ScissorsBlock"
            case .inactive:
                break
                
            }
            
            switch loseBlock.state {
            case .rock:
                loseAssetString = "RockBlock"
            case .paper:
                loseAssetString = "PaperBlock"
            case .scissors:
                loseAssetString = "ScissorsBlock"
            case .inactive:
                break
                
            }
            
            
            
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
            loseNode.zPosition = loseBlock.zPosition + 1
            winNode.zPosition = winBlock.zPosition + 2
            print(loseNode.zPosition)
            print(winNode.zPosition)
            gridNode.addChild(loseNode)
            gridNode.addChild(winNode)
            let collisionSeq = SKAction.sequence([scale, move, descale, remove])
            winNode.runAction(collisionSeq)
            loseNode.runAction(SKAction.sequence([wait, remove]))
            
            
        } else if (tie != 0) && (winBlock == block1) && (loseBlock.state != .inactive){
            
            switch winBlock.state {
            case .rock:
                winAssetString2 = "RockBlock"
            case .paper:
                winAssetString2 = "PaperBlock"
            case .scissors:
                winAssetString2 = "ScissorsBlock"
            case .inactive:
                break
                
            }
            
            switch loseBlock.state {
            case .rock:
                loseAssetString2 = "RockBlock"
            case .paper:
                loseAssetString2 = "PaperBlock"
            case .scissors:
                loseAssetString2 = "ScissorsBlock"
            case .inactive:
                break
                
            }
            
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
            loseNode2.zPosition = loseBlock.zPosition + 1
            winNode2.zPosition = winBlock.zPosition + 2
            print(loseNode2.zPosition)
            print(winNode2.zPosition)
            gridNode.addChild(loseNode2)
            gridNode.addChild(winNode2)
            
            let collisionSeq2 = SKAction.sequence([scale2, descale2, remove2])
            winNode2.runAction(collisionSeq2)
            loseNode2.runAction(SKAction.sequence([move2, remove2]))
            

            
        }
        
        
        
        
    }
    
    // Show the instructions if the user is idle
    func instructions() {
        
        
    }
    
}




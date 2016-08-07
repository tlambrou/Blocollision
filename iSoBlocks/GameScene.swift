//
//  GameScene.swift
//  iSoBlocks
//
//  Created by Tassos Lambrou on 7/9/16.
//  Copyright (c) 2016 Ssos Games. All rights reserved.
//
import Foundation
import SpriteKit

var time: Int = 0

enum swipeType {
    case up, down, left, right
}

enum GameState {
    case ready, playing, paused, gameover, won
}

var gameState: GameState = .ready {
didSet {
    switch gameState {
    case .ready:
        print("Ready!")
        break
    case .playing:
        print("Playing!")
        break
    case .paused:
        print("Paused!")
        break
    case .gameover:
        print("Game Over!")
        
        break
    case .won:
        print("YOU WON THE GAME!")
        break
    }
}
}

struct Outcome {
    var winnner:Block
    var loser:Block
    
    // Create Int called "tie" that is 0 if tied, 1 if block 1 wins, and 2 if block 2 wins
    var tie: Int
}





class GameScene: SKScene {
    
    var gameTracker = GameTracker.init() {
        didSet {
            scoreLabel.text = String(gameTracker.score)
            print("Difficulty: \(gameTracker.difficulty)")
            print("Cleared Lines: \(gameTracker.clrdAisles)")
            print("Scored: \(gameTracker.scored)")
            
        }
    }
    
    let gameManager = GameManager.sharedInstance
    var hiScoreLabel: SKLabelNode!
    var scoreLabel: SKLabelNode!

    var gridNode: Grid!
    var topStageNode: StageH!
    var bottomStageNode: StageH!
    var leftStageNode: StageV!
    var rightStageNode: StageV!
    var restartButton: MSButtonNode!
    var gameOver: MSButtonNode!
    
    var swipeInstructions: SKSpriteNode!
    
    func afterSwipe() {
        
        // Create random swipe sound effect if the game is in play
        if gameState == .playing {
            
            // Create a random selector
            let ranDumb: Int = Int.random(2)
            
            switch ranDumb {
                
            case 0:
                
                /* Play SFX */
                let scoreSFX = SKAction.playSoundFileNamed("switch33", waitForCompletion: true)
                self.runAction(scoreSFX)
                
            case 1 :
                
                /* Play SFX */
                let scoreSFX = SKAction.playSoundFileNamed("switch34", waitForCompletion: true)
                self.runAction(scoreSFX)
                
            default:
                print("Didn't play any swipe SFX for some reason.  Check afterSwipe()")
            }
        }
        
        // Check for complete rows
        rowsCheck()
        
        // Check for complete columns
        columnsCheck()
        
        // Calculate the grid score (sumScore)
        gridScore()
        
        gameTracker.difficultyRules()
        
        // Evaluate & Set High Score
        if gameTracker.score > gameManager.highScore {
            gameManager.highScore = gameTracker.score
            hiScoreLabel.text = String(gameManager.highScore)
        }
        
        // Check for Game Over State
        gameOverCheck()

    }
    
    func swipedUp(sender:UISwipeGestureRecognizer) {
        
        if gameState == .playing {
            swipe(.up)
        }
        
        // Call After Swipe Routine
        afterSwipe()
        
    }
    
    func swipedDown(sender:UISwipeGestureRecognizer) {
        if gameState == .playing {
            swipe(.down)
        }
        
        // Call After Swipe Routine
        afterSwipe()
    }
    
    func swipedLeft(sender:UISwipeGestureRecognizer) {
        if gameState == .playing {
            swipe(.left)
        }
        
        // Call After Swipe Routine
        afterSwipe()
        
    }
    
    func swipedRight(sender:UISwipeGestureRecognizer) {
        if gameState == .playing {
            swipe(.right)
        }
        
        // Call After Swipe Routine
        afterSwipe()
        
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        // Setup for High Score & Retrieval
        hiScoreLabel = SKLabelNode(fontNamed:"ChalkboardSE-Bold")
        hiScoreLabel.text = String(gameManager.highScore)
        hiScoreLabel.fontSize = 120
        hiScoreLabel.fontColor = UIColor(netHex: 0xFFFFFF)
        hiScoreLabel.zPosition = 101
        hiScoreLabel.horizontalAlignmentMode = .Left
        hiScoreLabel.position = CGPoint(x:512, y:1630)
    
        self.addChild(hiScoreLabel)
        
        gridNode = childNodeWithName("gridNode") as! Grid
        topStageNode = childNodeWithName("topStage") as! StageH
        bottomStageNode = childNodeWithName("bottomStage") as! StageH
        leftStageNode = childNodeWithName("leftStage") as! StageV
        rightStageNode = childNodeWithName("rightStage") as! StageV
        /* Set UI connections */
        
        gameOver = self.childNodeWithName("gameOver") as! MSButtonNode
        gameOver.hidden = true

        restartButton = self.childNodeWithName("restartButton") as! MSButtonNode
        swipeInstructions = childNodeWithName("swipeInstructions") as! SKSpriteNode
        scoreLabel = childNodeWithName("scoreLabel") as! SKLabelNode
        
        swipeInstructions.alpha = CGFloat(0)
        
        let ranDumb: Int = Int.random(4)
        
        switch ranDumb {
        case 0:
            stageRegen(.up)
        case 1:
            stageRegen(.down)
        case 2:
            stageRegen(.left)
        case 3:
            stageRegen(.right)
        default:
            print("Stage spawn initializer switch didn't work")
        }
        
        restartButton.selectedHandler = {
            
            /* Grab reference to the SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Restart GameScene */
            skView.presentScene(scene)
            
            gameState = .playing
            
            // Reset the score
            self.gameTracker.multiplierScore = 0
            self.gameTracker.sumScore = 0
            self.gameTracker.score = 0
            
        }
        
        gameOver.selectedHandler = {
            
            /* Grab reference to the SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = Title(fileNamed:"Title") as Title!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Restart GameScene */
            skView.presentScene(scene)
            
            gameState = .ready
            
            // Reset the score
            self.gameTracker.multiplierScore = 0
            self.gameTracker.sumScore = 0
            self.gameTracker.score = 0
            
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
        
        gameTracker.timeElapsedSinceIdle  = 0
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        
        
        time += 1
        
        /* Called before each frame is rendered */
        gameTracker.timeElapsedSinceIdle += 1
        
        //MARK: Idle variable actions
        if gameTracker.instShown == false && gameTracker.idle == true {
            gameTracker.instShown = true
            
            let fadeUp = SKAction.fadeAlphaTo(1.0, duration: NSTimeInterval(1.0))
            let fadeDown = SKAction.fadeAlphaTo(0.55, duration: NSTimeInterval(1.0))
            let sequence = SKAction.repeatActionForever(SKAction.sequence([fadeUp, fadeDown]))
            swipeInstructions.runAction(sequence)
            gameTracker.firstInstShown = true
            
        } else if gameTracker.instShown == true && gameTracker.idle == false {
            gameTracker.instShown = false
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
//        var stageRegen: Bool = false
        
        gameTracker.timeElapsedSinceIdle = 0
        
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
//                        if ((nextBlock.state != .inactive) && (currentBlock.state == nextBlock.state)) || ((nextBlock.state != .inactive) && (currentBlock.state == .inactive)) {
//                            stageRegen = true
//                        }
                        
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
//                            if ((nextBlock.state != .inactive) && (currentBlock.state == nextBlock.state)) || ((nextBlock.state != .inactive) && (currentBlock.state == .inactive)) {
//                                stageRegen = true
//                            }
                            
                            // Perform the collision rules
                            collisionRules(currentBlock, nextBlock: nextBlock)
//                            topStageNode.stageRegen()
                            
                            
                        }
                            
                            //MARK: Swipe Down
                            // Is it a swipe down?
                        else if swipeDirection == .down {
                            let nextBlock = topStageNode.stageArray[gridX]
                            
                            // Check to see if the Stage Regen needs to be reset
//                            if ((nextBlock.state != .inactive) && (currentBlock.state == nextBlock.state)) || ((nextBlock.state != .inactive) && (currentBlock.state == .inactive)) {
//                                stageRegen = true
//                            }
                            
                            // Perform the collision rules
                            collisionRules(currentBlock, nextBlock: nextBlock)
//                            topStageNode.stageRegen()
                            
                            
                            
                        }
                        
                        
                    }
                    
                }
                
                // Is the regen bool equal to true?
//                if stageRegen == true {
//                    
//                    // Is it swipe up?
//                    if swipeDirection == .up {
//                        
//                        // Clear the stage
//                        bottomStageNode.stageArray[gridX].state = .inactive
//                        
//                        // Is it swipe down?
//                    } else if swipeDirection == .down {
//                        
//                        // Clear the stage
//                        topStageNode.stageArray[gridX].state = .inactive
//                        
//                    }
//                }
            }
            
            // Is the swipe up & stage regen is true?
//            if swipeDirection == .up && stageRegen == true {
//                
//                // Add a new block to the stage
////                bottomStageNode.stageRegen()
//                bottomStageNode.addBlockToEmptyStage()
//                
//                
//                // Reset the stage regen bool to false
//                stageRegen = false
//                
//                //Is the swipe down & stage regen is true?
//            } else if swipeDirection == .down && stageRegen == true {
//                
//                // Add a new block to the stage
////                topStageNode.stageRegen()
//                topStageNode.addBlockToEmptyStage()
//                
//                // Reset the stage regen bool to false
//                stageRegen = false
//            }
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
//                        if ((nextBlock.state != .inactive) && (currentBlock.state == nextBlock.state)) || ((nextBlock.state != .inactive) && (currentBlock.state == .inactive)) {
//                            stageRegen = true
//                        }
                        
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
//                            if ((nextBlock.state != .inactive) && (currentBlock.state == nextBlock.state)) || ((nextBlock.state != .inactive) && (currentBlock.state == .inactive)) {
//                                stageRegen = true
//                            }
                            
                            //                            print(currentBlock.position)
                            
                            // Perform the collision rules
                            collisionRules(currentBlock, nextBlock: nextBlock)
                            
//                            rightStageNode.stageRegen()
                            
                        }
                            
                            //MARK: Swipe Right
                            // Is it a swipe right?
                        else if swipeDirection == .right {
                            let nextBlock = leftStageNode.stageArray[gridY]
                            
                            // Check to see if the Stage Regen needs to be reset
//                            if ((nextBlock.state != .inactive) && (currentBlock.state == nextBlock.state)) || ((nextBlock.state != .inactive) && (currentBlock.state == .inactive)) {
//                                stageRegen = true
//                            }
                            
                            // Perform the collision rules
                            collisionRules(currentBlock, nextBlock: nextBlock)
                            
//                            leftStageNode.stageRegen()
                            
                        }
                        
                        
                    }
                    
                }
                
                // Is the regen bool equal to true?
//                if stageRegen == true {
//                    
//                    // Is it swipe left?
//                    if swipeDirection == .left {
//                        
//                        // Clear the stage
//                        rightStageNode.stageArray[gridY].state = .inactive
//                        
//                        // Is it swipe right?
//                    } else if swipeDirection == .right {
//                        
//                        // Clear the stage
//                        leftStageNode.stageArray[gridY].state = .inactive
//                        
//                    }
//                }
            }
            
            // Is the swipe left & stage regen is true?
//            if swipeDirection == .left && stageRegen == true {
//                
//                // Add a new block to the stage
//                rightStageNode.addBlockToEmptyStage()
////                rightStageNode.stageRegen()
//                
//                // Reset the stage regen bool to false
//                stageRegen = false
//                
//                //Is the swipe right & stage regen is true?
//            } else if swipeDirection == .right && stageRegen == true {
//                
//                // Add a new block to the stage
////                leftStageNode.stageRegen()
//                leftStageNode.addBlockToEmptyStage()
//                
//                // Reset the stage regen bool to false
//                stageRegen = false
//            }
        }
        
        stageRegen(swipeDirection)
        
    }
    
    func stageRegen(swipeDirection: swipeType) {
        
        // Store the stage active count
        let activeCount = stageActiveCount()
        
        // Evaluate if the activeCount is less than or equal to the spawn rate
        if activeCount < spawnRate {
            
            // For each swipe
            switch swipeDirection {
            case .up:
                for _ in 0..<spawnRate {
                    bottomStageNode.addBlockToEmptyStage()
                }
            case .down:
                for _ in 0..<spawnRate {
                    topStageNode.addBlockToEmptyStage()
                }
            case .left:
                for _ in 0..<spawnRate {
                    rightStageNode.addBlockToEmptyStage()
                }
            case .right:
                for _ in 0..<spawnRate {
                    leftStageNode.addBlockToEmptyStage()
                }
            }
        }
        
    }
    
    func stageActiveCount() -> Int {
    
        var activeCount: Int = 0
        
        // Loop through the stages
        for i in 0..<4 {
            switch i {
            case 0:
                // Loop through the columns
                for j in 0..<columns {
                    
                    if topStageNode.stageArray[j].state != .inactive {
                        
                        // Increase the count
                        activeCount += 1
                    }
                }
                
            case 1:
                // Loop through the columns
                for j in 0..<columns {
                    
                    if bottomStageNode.stageArray[j].state != .inactive {
                        
                        // Increase the count
                        activeCount += 1
                    }
                }
                
            case 2:
                // Loop through the columns
                for j in 0..<columns {
                    
                    if leftStageNode.stageArray[j].state != .inactive {
                        
                        // Increase the count
                        activeCount += 1
                    }
                }
                
            case 3:
                // Loop through the columns
                for j in 0..<columns {
                    
                    if rightStageNode.stageArray[j].state != .inactive {
                        
                        // Increase the count
                        activeCount += 1
                    }
                }
                
            default:
                print("First Switch in checkStages() didn't work")
            
            }
        }
        
        return activeCount
    }
    
    func collision(block1: Block, block2: Block) -> Outcome {
        let red: BlockType = .red
        let blue: BlockType = .blue
        let green: BlockType = .green
        let inactive: BlockType = .inactive
        let block1State = block1.state
        let block2State = block2.state
//        let block1Stack = block1.stack
//        let block2Stack = block2.stack
        
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
            
            // Check to see who has the bigger stack and return the winner
//            if block1Stack >= block2Stack {
//                return Outcome(winnner: block1, loser: block2, tie: 1)
//            } else if b
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
    
    var animateComplete: Bool = false {
        didSet {
            if animateComplete == true {
                // Check for complete rows
                rowsCheck()
                
                // Check for complete columns
                columnsCheck()
                
                // Calculate the grid score (sumScore)
                gridScore()
                animateComplete = false
            }
        }
    }
    
    func animateCollision(block1: Block, block2: Block) {
        
        let result: Outcome = collision(block1, block2: block2)
        
        let winBlock = result.winnner
        let loseBlock = result.loser
//        let tie = result.tie
        
//        var winAssetString = ""
        var loseAssetString = ""
        
//        switch winBlock.state {
//        case .red:
//            winAssetString = "RoundRectCoral"
//        case .blue:
//            winAssetString = "RoundRectTeal"
//        case .green:
//            winAssetString = "RoundRectGreen"
//        case .inactive:
//            winAssetString = "RoundRect"
//            
//        }
        
        switch loseBlock.state {
        case .red:
            loseAssetString = "RoundRectCoral"
        case .blue:
            loseAssetString = "RoundRectTeal"
        case .green:
            loseAssetString = "RoundRectGreen"
        case .yellow:
            loseAssetString = "RoundRectYellow"
        case .inactive:
            loseAssetString = "RoundRect"
            
        }
        
        if block1.state == block2.state {
            
            let winNode = Block()
//            let winNode = SKSpriteNode(imageNamed: winAssetString)
            winNode.state = winBlock.state
            winNode.stack = winBlock.stack
            let scale = SKAction.scaleTo(1.15, duration: 0.07)
            let descale = SKAction.scaleTo(1, duration: 0.07)
            let destination = winBlock.position
            let move = SKAction.moveTo(destination, duration: 0.1)
            let remove = SKAction.removeFromParent()
            //            let wait2 = SKAction.waitForDuration(0.4)
            
           
            winNode.position = winBlock.position
            /* Position winNode at the location of the winning block */
            winNode.anchorPoint = block1.anchorPoint
            winNode.size = block1.size
            let loseNode = SKSpriteNode(imageNamed: loseAssetString)
           
            loseNode.size = loseBlock.size
            loseNode.anchorPoint = loseBlock.anchorPoint
            loseNode.zPosition = 7
            winNode.zPosition = 8
        
            
            loseNode.position = block2.position
            
            if block2.parent == topStageNode {
                
                loseNode.position.y = CGFloat(810)
                
            } else if block2.parent == rightStageNode {
                
                loseNode.position.x = CGFloat(810)
                
            } else if block2.parent == leftStageNode {
                
                loseNode.position.x = CGFloat(-90)
                
            } else if block2.parent == bottomStageNode {
                
                loseNode.position.y = CGFloat(-90)
                
            }
            gridNode.addChild(loseNode)
            gridNode.addChild(winNode)
            
            let collisionSeq = SKAction.sequence([scale, descale, remove])
            winNode.runAction(collisionSeq)
            loseNode.runAction(SKAction.sequence([move, remove]))
            
            
        } else if (block1.state == .inactive) && (block2.state != .inactive) {
            
            let winNode = Block()
            //winNode = SKSpriteNode(imageNamed: winAssetString)
            winNode.state = winBlock.state
            winNode.stack = winBlock.stack
            
            let scale = SKAction.scaleTo(1.15, duration: 0.07)
            let descale = SKAction.scaleTo(1, duration: 0.07)
            let destination = loseBlock.position
            let wait = SKAction.waitForDuration(NSTimeInterval(0.24))
            let move = SKAction.moveTo(destination, duration: 0.1)
            let remove = SKAction.removeFromParent()
            //            let wait2 = SKAction.waitForDuration(0.4)
            
            
            winNode.position = winBlock.position
            /* Position winNode at the location of the winning block */
            winNode.anchorPoint = block2.anchorPoint
            winNode.size = block2.size
            
            
            let loseNode = SKSpriteNode(imageNamed: "RoundRect")
            loseNode.size = loseBlock.size
            loseNode.anchorPoint = loseBlock.anchorPoint
            loseNode.zPosition = 6
            winNode.zPosition = 8
            
            loseNode.position = block1.position
            
            if block2.parent == topStageNode {
                
                winNode.position.y = CGFloat(810)
                
            } else if block2.parent == rightStageNode {
                
                winNode.position.x = CGFloat(810)
                
            } else if block2.parent == leftStageNode {
                
                winNode.position.x = CGFloat(-90)
            
            } else if block2.parent == bottomStageNode {
                
                winNode.position.y = CGFloat(-90)
                
            }
            
            gridNode.addChild(loseNode)
            gridNode.addChild(winNode)
        
            let collisionSeq = SKAction.sequence([scale, move, descale, remove])
            winNode.runAction(collisionSeq, completion: {
                self.animateComplete = true
                
            })
            loseNode.runAction(SKAction.sequence([wait, remove]))
            
            
        } 
        
  
        
    }
    
    func collisionRules (currentBlock: Block, nextBlock: Block) {
        
        // Is the Next Active?
        if nextBlock.state != .inactive {
            
            
            // Is the Current Active?
            if currentBlock.state != .inactive {
                
                // Are Current & Next the same values?
                if currentBlock.state == nextBlock.state {
                    
                    // Animate the collision
                    animateCollision(currentBlock, block2: nextBlock)
                    
                    // Find the higher block stack
                    let comparison = [currentBlock.stack, nextBlock.stack]
                    
                    // Set the new block's stack equal to the highest block's stack minus 1
                    currentBlock.stack = comparison.maxElement()! - (comparison.maxElement()! - comparison.minElement()!)
                    
                    /* Play SFX */
                    let combineSFX = SKAction.playSoundFileNamed("clearDot", waitForCompletion: true)
                    self.runAction(combineSFX)
                                        
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
                
                // Copy over the stack
                currentBlock.stack = nextBlock.stack
                
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
                
                if (monkeyBeer == (rows-1))   {
                    
                    //Call clear row and/or clear blocks function
//                    clearRow(gridY)
                    
                    //Clear the color
                    clearColor(currentBlock.state)
                    
                    // Add one to the cleared aisles global variable
                    gameTracker.clrdAisles += 1
                    
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
                
                if (monkeyBeer == (columns-1))   {
                    
                    //Call clear column and/or clear blocks function
//                    clearColumn(gridX)
                    
                    // Clear the color
                    clearColor(currentBlock.state)
                    
                    // Add one to the cleared aisles global variable
                    gameTracker.clrdAisles += 1
                    
                    monkeyBeer = 0
                    break
                    
                }
            }
        }
        
    }
    

    func animateBlockClear (dieBlock: Block) {
        
        // Create variables & particulars
//        var assetString = ""
//        
//        switch dieBlock.state {
//        case .red:
//            assetString = "RoundRectCoral"
//        case .blue:
//            assetString = "RoundRectTeal"
//        case .green:
//            assetString = "RoundRectGreen"
//        case .inactive:
//            assetString = "RoundRect"
//            
//        }
        
        let dieNode = Block()
        
        // Set the dieNode equal to the original block states
        dieNode.stack = dieBlock.stack
        dieNode.state = dieBlock.state
        
        /* Position dieNode at the location of the gridNode block */
        dieNode.anchorPoint = dieBlock.anchorPoint
        dieNode.size = dieBlock.size
        dieNode.position = dieBlock.position
        dieNode.zPosition = dieBlock.zPosition + 1
        
        // Create a scale action
        let scale = SKAction.scaleTo(1.15, duration: 0.1)
        
        // Create a descale action
        let descale = SKAction.scaleTo(0, duration: 0.2)
        
        // Create a wait action just in case
        let wait = SKAction.waitForDuration(0.25)
        
        // Create a "poof" animation
        
        // Create a remove action
        let remove = SKAction.removeFromParent()
        
        // Create a sound effect action

        let scoreSFX = SKAction.playSoundFileNamed("clearRow", waitForCompletion: false)
        
        // Create the sequence action
        let dieSeq = SKAction.sequence([scale, scoreSFX, wait, descale, remove])
        
        // Add the node as a child of the parent
        gridNode.addChild(dieNode)
        
        // Set the state to .inactive
        dieBlock.state = .inactive
        
        // Run the sequence
        dieNode.runAction(dieSeq)
        
    }
    
    func clearColor (color: BlockType) {
        
        var clearScore: Int = 1
//        var stackSum: Int = 0
        
        
        
        // Loop through the row
        for gridX in 0..<columns {
            for gridY in 0..<rows {
                
                let currentBlock = gridNode.gridArray[gridX][gridY]
                if currentBlock.state == color {
//                    
//                    stackSum += currentBlock.stack
                    clearScore += currentBlock.factScore
                    
                    // Animate the block's death
                    animateBlockClear(currentBlock)
                    
                }
            }
        }
        
        //Add the stackSum to the clearScore
//        clearScore += stackSum
        
        // Add the clearScore to the player's score
        gameTracker.multiplierScore += clearScore
        
       
    }
    
    func gridScore() {
        
        gameTracker.sumScore = 0
        
        //Loop through the columns
        for gridX in 0..<columns {
            //Loop through the rows
            for gridY in 0..<rows {
                
                // Set the current block
                let currentBlock = gridNode.gridArray[gridX][gridY]
                
                if currentBlock.stack < 4 {
                    gameTracker.sumScore += currentBlock.stack
                }
                
                
            }
        }
        
    }
    
    
    struct Copy {
        let gridCopy: Grid
        let topStageCopy: StageH
        let bottomStageCopy: StageH
        let leftStageCopy: StageV
        let rightStageCopy: StageV
        
        init(grid: Grid, topStage: StageH, bottomStage: StageH, leftStage: StageV, rightStage: StageV){
            gridCopy = grid
            topStageCopy = topStage
            bottomStageCopy = bottomStage
            leftStageCopy = leftStage
            rightStageCopy = rightStage
        }
        
    }
    
    
    
    func swipeCheck(swipeDirection: swipeType, grid: Grid, topStage: StageH, bottomStage: StageH, leftStage: StageV, rightStage: StageV) -> Int {
        
        let copy = Copy(grid: grid, topStage: topStage, bottomStage: bottomStage, leftStage: leftStage, rightStage: rightStage)

        let gridCopy = copy.gridCopy
        let topStageCopy = copy.topStageCopy
        let bottomStageCopy = copy.bottomStageCopy
        let leftStageCopy = copy.leftStageCopy
        let rightStageCopy = copy.rightStageCopy
        
        // Make all of the copies hidden
//        gridCopy.hidden = true
//        topStageCopy.hidden = true
//        bottomStageCopy.hidden = true
//        leftStageCopy.hidden = true
//        rightStageCopy.hidden = true
        
        var moveCount: Int = 0
        
        var xStart: Int
        var xEnd: Int
        var yStart: Int
        var yEnd: Int
        var xIncrement: Int = 1
        var yIncrement: Int = 1
        
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
                        let currentBlock = gridCopy.gridArray[gridX][gridY]
                        let nextBlock = gridCopy.gridArray[gridX][gridY+yIncrement]
                        
                        // Perform the collision rules
                        moveCount += collisionRulesCheck(currentBlock, nextBlock: nextBlock)
                        
                        
//                        // Check to see if the Stage Regen needs to be reset
//                        if ((nextBlock.state != .inactive) && (currentBlock.state == nextBlock.state)) || ((nextBlock.state != .inactive) && (currentBlock.state == .inactive)) {
//                            stageRegen = true
//                        }
                        
                        //MARK: Last Row Vertical
                        // Is it the last row?
                    } else if gridY == yEnd {
                        
                        let currentBlock = gridCopy.gridArray[gridX][gridY]
                        
                        //MARK: Swipe Up
                        // Is it a swipe up?
                        if swipeDirection == .up {
                            
                            
                            // Change the Next Block to the Stage
                            let nextBlock = bottomStageCopy.stageArray[gridX]
                            
//                            // Check to see if the Stage Regen needs to be reset
//                            if ((nextBlock.state != .inactive) && (currentBlock.state == nextBlock.state)) || ((nextBlock.state != .inactive) && (currentBlock.state == .inactive)) {
//                                stageRegen = true
//                            }
                            // Perform the collision rules
                            moveCount += collisionRulesCheck(currentBlock, nextBlock: nextBlock)
                            
                            //                            topStageNode.stageRegen()
                            
                            
                        }
                            
                            //MARK: Swipe Down
                            // Is it a swipe down?
                        else if swipeDirection == .down {
                            let nextBlock = topStageCopy.stageArray[gridX]
                            
//                            // Check to see if the Stage Regen needs to be reset
//                            if ((nextBlock.state != .inactive) && (currentBlock.state == nextBlock.state)) || ((nextBlock.state != .inactive) && (currentBlock.state == .inactive)) {
//                                stageRegen = true
//                            }
                            
                            // Perform the collision rules
                            moveCount += collisionRulesCheck(currentBlock, nextBlock: nextBlock)
                            
//                            topStageNode.stageRegen()
                            
                            
                            
                        }
                        
                        
                    }
                    
                }
                
//                // Is the regen bool equal to true?
//                if stageRegen == true {
//                    
//                    // Is it swipe up?
//                    if swipeDirection == .up {
//                        
//                        // Clear the stage
//                        bottomStageCopy.stageArray[gridX].state = .inactive
//                        
//                        // Is it swipe down?
//                    } else if swipeDirection == .down {
//                        
//                        // Clear the stage
//                        topStageCopy.stageArray[gridX].state = .inactive
//                        
//                    }
//                }
            }
            
            // Is the swipe up & stage regen is true?
//            if swipeDirection == .up && stageRegen == true {
//                
//                // Add a new block to the stage
//                //                bottomStageNode.stageRegen()
//                bottomStageNode.addBlockToEmptyStage()
//                
//                bottomStageNode.addBlockToEmptyStage()
//
//                // Reset the stage regen bool to false
//                stageRegen = false
//                
//                //Is the swipe down & stage regen is true?
//            } else if swipeDirection == .down && stageRegen == true {
//                
//                // Add a new block to the stage
//                //                topStageNode.stageRegen()
//                topStageNode.addBlockToEmptyStage()
//                topStageNode.addBlockToEmptyStage()
//                
//                // Reset the stage regen bool to false
//                stageRegen = false
//            }
        }
        
        
        // If direction of swipe is horizontal...
        if (swipeDirection == .left) || (swipeDirection == .right) {
            
            // loop through the rows
            for gridY in yStart.stride(through: yEnd, by: yIncrement){
                
                // loop through the columns
                for gridX in xStart.stride(through: xEnd, by: xIncrement) {
                    
                    if gridX != xEnd {
                        // Set the current & next blocks
                        let currentBlock = gridCopy.gridArray[gridX][gridY]
                        let nextBlock = gridCopy.gridArray[gridX+xIncrement][gridY]
                        
                        // Perform the collision rules
                        moveCount += collisionRulesCheck(currentBlock, nextBlock: nextBlock)
                        

//                        // Check to see if the Stage Regen needs to be reset
//                        if ((nextBlock.state != .inactive) && (currentBlock.state == nextBlock.state)) || ((nextBlock.state != .inactive) && (currentBlock.state == .inactive)) {
//                            stageRegen = true
//                        }
                        
                        //MARK: Last Column Horizontal
                        // Is it the last column?
                    } else if gridX == xEnd {
                        
                        let currentBlock = gridCopy.gridArray[gridX][gridY]
                        
                        //MARK: Swipe Left
                        // Is it a swipe left?
                        if swipeDirection == .left {
                            
                            
                            // Change the Next Block to the Stage
                            let nextBlock = rightStageCopy.stageArray[gridY]
                            
//                            // Check to see if the Stage Regen needs to be reset
//                            if ((nextBlock.state != .inactive) && (currentBlock.state == nextBlock.state)) || ((nextBlock.state != .inactive) && (currentBlock.state == .inactive)) {
//                                stageRegen = true
//                            }
                            
                            //                            print(currentBlock.position)
                            
                            // Perform the collision rules
                            moveCount += collisionRulesCheck(currentBlock, nextBlock: nextBlock)
                            
//                            rightStageNode.stageRegen()
                            
                        }
                            
                            //MARK: Swipe Right
                            // Is it a swipe right?
                        else if swipeDirection == .right {
                            let nextBlock = leftStageCopy.stageArray[gridY]
                            
//                            // Check to see if the Stage Regen needs to be reset
//                            if ((nextBlock.state != .inactive) && (currentBlock.state == nextBlock.state)) || ((nextBlock.state != .inactive) && (currentBlock.state == .inactive)) {
//                                stageRegen = true
//                            }
                            
                            // Perform the collision rules
                            moveCount += collisionRulesCheck(currentBlock, nextBlock: nextBlock)
                            
//                            leftStageNode.stageRegen()
                            
                        }
                        
                        
                    }
                    
                }
                
//                // Is the regen bool equal to true?
//                if stageRegen == true {
//                    
//                    // Is it swipe left?
//                    if swipeDirection == .left {
//                        
//                        // Clear the stage
//                        rightStageCopy.stageArray[gridY].state = .inactive
//                        
//                        // Is it swipe right?
//                    } else if swipeDirection == .right {
//                        
//                        // Clear the stage
//                        leftStageCopy.stageArray[gridY].state = .inactive
//                        
//                    }
//                }
            }
            
//            // Is the swipe left & stage regen is true?
//            if swipeDirection == .left && stageRegen == true {
//                
//                // Add a new block to the stage
//                rightStageCopy.addBlockToEmptyStage()
//                rightStageCopy.addBlockToEmptyStage()
//                //                rightStageNode.stageRegen()
//                
//                // Reset the stage regen bool to false
//                stageRegen = false
//                
//                //Is the swipe right & stage regen is true?
//            } else if swipeDirection == .right && stageRegen == true {
//                
//                // Add a new block to the stage
//                //                leftStageNode.stageRegen()
//                leftStageCopy.addBlockToEmptyStage()
//                leftStageCopy.addBlockToEmptyStage()
//                
//                // Reset the stage regen bool to false
//                stageRegen = false
//            }
        }
        
        
        return moveCount
        
        
    }
    
    func collisionRulesCheck (currentBlock: Block, nextBlock: Block) -> Int {
        
        var moveCount: Int = 0
        
        // Is the Next Active?
        if nextBlock.state != .inactive {
            
            
            // Is the Current Active?
            if currentBlock.state != .inactive {
                
                // Are Current & Next the same values?
                if currentBlock.state == nextBlock.state {
                    
                    moveCount += 1
                    
                    
                    
                } else {
                    
                    // Do Nothing
                    
                }
                
                
            } else if currentBlock.state == .inactive {
                
                moveCount += 1
                
                
            }
            
            
        } else {
            
            // Do Nothing
            
        }
        
        return moveCount
        
    }
    
    func gameOverCheck() {
        
        var possibleMoves: Int
        
        possibleMoves = swipeCheck(.up, grid: gridNode, topStage: topStageNode, bottomStage: bottomStageNode, leftStage: leftStageNode, rightStage: rightStageNode)
        
        possibleMoves += swipeCheck(.down, grid: gridNode, topStage: topStageNode, bottomStage: bottomStageNode, leftStage: leftStageNode, rightStage: rightStageNode)
        
        possibleMoves += swipeCheck(.left, grid: gridNode, topStage: topStageNode, bottomStage: bottomStageNode, leftStage: leftStageNode, rightStage: rightStageNode)
        
        possibleMoves += swipeCheck(.right, grid: gridNode, topStage: topStageNode, bottomStage: bottomStageNode, leftStage: leftStageNode, rightStage: rightStageNode)
        
        if possibleMoves <= 0 {
            
            //Game is gameover!
            gameState = .gameover
            
            gameOverAction()
        }
        
    }
    
    func gameOverAction () {
        
        gameOver.hidden = false
        
        
    }
    
    
}

func factorial(number: Int) -> (Int) {
    if (number <= 1) {
        return 1
    }
    
    return number * factorial(number - 1)
}

func factorialWeights() -> Int{
    let ranDumb: Int = Int.random(100)+1
    
    if ranDumb <= 12 {
        return 1
    } else if (ranDumb > 12) && (ranDumb <= 36) {
        return 2
    } else if (ranDumb > 36) && (ranDumb <= 76) {
        return 3
    } else if (ranDumb > 76) && (ranDumb <= 94) {
        return 4
    } else if (ranDumb > 94) && (ranDumb <= 99) {
        return 5
    } else if ranDumb == 100 {
        return 6
    } else {
        print("Something went wrong with the factorailWeights()")
        return 0
    }
    
    
}


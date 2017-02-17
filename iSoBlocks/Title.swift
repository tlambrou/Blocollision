//
//  Title.swift
//  iSoBlocks
//
//  Created by Tassos Lambrou on 8/2/16.
//  Copyright © 2016 SsosSoft. All rights reserved.
//

import Foundation
import SpriteKit
import CoreMotion

class Title: SKScene {
    
    var playButton: MSButtonNode!
    var timedButton: MSButtonNode!
    var movesButton: MSButtonNode!
    var howtoButton: MSButtonNode!
    
    
    var motionManager = CMMotionManager()
    
    override func didMove(to view: SKView) {
        
        
        
//        SKTAudio.sharedInstance().playBackgroundMusic("Tame Your Crickets.caf") // Start the music
        
        playButton = self.childNode(withName: "playButton") as! MSButtonNode
        timedButton = self.childNode(withName: "timedButton") as! MSButtonNode
        movesButton = self.childNode(withName: "movesButton") as! MSButtonNode
        howtoButton = self.childNode(withName: "howtoButton") as! MSButtonNode
        
        playButton.selectedHandler = {
            
            /* Play SFX */
            let click = SKAction.playSoundFileNamed("click3", waitForCompletion: true)
            self.run(click)
            
            /* Grab reference to the SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            
            // Set Play Mode to "Mortality"
            gameMode = .mortality
            
            // Set GameState to playing
            gameState = .playing
            
            
            /* Ensure correct aspect mode */
            scene?.scaleMode = .aspectFit
            
            /* Restart GameScene */
            skView?.presentScene(scene)

            
            
        }
        
        timedButton.selectedHandler = {
            
            /* Play SFX */
            let click = SKAction.playSoundFileNamed("click3", waitForCompletion: true)
            self.run(click)
            
            /* Grab reference to the SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            
            // Set Play Mode to "Mortality"
            gameMode = .timed
            
            // Set GameState to playing
            gameState = .playing
            
            
            /* Ensure correct aspect mode */
            scene?.scaleMode = .aspectFit
            
            /* Restart GameScene */
            skView?.presentScene(scene)
            
            
            
        }
        
        movesButton.selectedHandler = {
            
            /* Play SFX */
            let click = SKAction.playSoundFileNamed("click3", waitForCompletion: true)
            self.run(click)
            
            /* Grab reference to the SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            
            // Set Play Mode to "Mortality"
            gameMode = .moves
            
            // Set GameState to playing
            gameState = .playing
            
            
            /* Ensure correct aspect mode */
            scene?.scaleMode = .aspectFit
            
            /* Restart GameScene */
            skView?.presentScene(scene)
            
            
            
        }
        
        howtoButton.selectedHandler = {
            
            /* Play SFX */
            let click = SKAction.playSoundFileNamed("click3", waitForCompletion: true)
            self.run(click)
            
        }

        
        let creation = SKAction.run({self.createBlock()})
        let wait = SKAction.wait(forDuration: TimeInterval(0.4))
        let seq = SKAction.repeat(SKAction.sequence([creation, wait]), count: 130)
        run(seq)
    }
    
    override func update(_ currentTime: TimeInterval) {
        motionManager.startAccelerometerUpdates()
        
        if let accelerometerData = motionManager.accelerometerData {
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.x * 30 , dy: accelerometerData.acceleration.y * 30)
            
            
        }
        
        
    }
    
    func createBlock () {
        
        var state: BlockType = .inactive
        
        let rand:Int = Int.random(4)+1
        switch rand {
        case 1:
            state = .red
        case 2:
            state = .blue
        case 3:
            state = .green
        case 4:
            state = .yellow
        default:
            state = .inactive
            print("random texture assignment didn't work")
        }
        
        let block = Block.init()
        block.state = state
        let randum: Int = Int.random(8)
        
        block.stack = randum
        block.size.height = CGFloat(90)
        block.size.width = CGFloat(90)
//        block.label.fontSize = 50
//        block.factLabel.fontSize = 50
//        block.label.position.offset(dx: -20, dy: 20)
//        block.factLabel.position.offset(dx: -20, dy: 20)
        
        block.zPosition = 1
        
        block.label.isHidden = true
//        block.label.hidden = false
//        block.label.texture = SKTexture(imageNamed: String("3"))
        let xRandom: Int = Int.random(870)+1
        block.position = CGPoint(x: xRandom, y: 2005)
//        block.label.zPosition = 200
        
        let label = SKSpriteNode(imageNamed: String(block.stack))
        label.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        label.position = convert(block.position, to: block)
        let scale: CGFloat = CGFloat((block.size.height / label.size.height) * (3/5))
        label.setScale(scale)
        label.zPosition = block.zPosition + 1
        block.addChild(label)

        
        block.physicsBody = SKPhysicsBody.init(rectangleOf: CGSize(width: 90, height: 90))
        block.physicsBody?.affectedByGravity = true
        block.physicsBody?.allowsRotation = true
        block.zRotation = CGFloat(4.0)
        block.physicsBody?.restitution = CGFloat(0.85)
        block.physicsBody?.angularVelocity = CGFloat(0.6)
        block.physicsBody?.mass = CGFloat(6.3)
        

        addChild(block)
        
    }
    
}

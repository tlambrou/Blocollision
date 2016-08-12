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
    
    var motionManager = CMMotionManager()
    
    override func didMoveToView(view: SKView) {
        
//        SKTAudio.sharedInstance().playBackgroundMusic("Tame Your Crickets.caf") // Start the music
        
        playButton = self.childNodeWithName("playButton") as! MSButtonNode
        
        playButton.selectedHandler = {
            
            /* Play SFX */
            let click = SKAction.playSoundFileNamed("click3", waitForCompletion: true)
            self.runAction(click)
            
            /* Grab reference to the SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            
            // Set GameState to playing
            gameState = .playing
            
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFit
            
            /* Restart GameScene */
            skView.presentScene(scene)

            
            
        }

        
        
        let creation = SKAction.runBlock({self.createBlock()})
        let wait = SKAction.waitForDuration(NSTimeInterval(0.4))
        let seq = SKAction.repeatAction(SKAction.sequence([creation, wait]), count: 130)
        runAction(seq)
    }
    
    override func update(currentTime: NSTimeInterval) {
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
        
        block.label.hidden = true
//        block.label.hidden = false
//        block.label.texture = SKTexture(imageNamed: String("3"))
        let xRandom: Int = Int.random(870)+1
        block.position = CGPoint(x: xRandom, y: 2005)
//        block.label.zPosition = 200
        
        let label = SKSpriteNode(imageNamed: String(block.stack))
        label.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        label.position = convertPoint(block.position, toNode: block)
        let scale: CGFloat = CGFloat((block.size.height / label.size.height) * (3/5))
        label.setScale(scale)
        label.zPosition = block.zPosition + 1
        block.addChild(label)

        
        block.physicsBody = SKPhysicsBody.init(rectangleOfSize: CGSize(width: 90, height: 90))
        block.physicsBody?.affectedByGravity = true
        block.physicsBody?.allowsRotation = true
        block.zRotation = CGFloat(4.0)
        block.physicsBody?.restitution = CGFloat(0.85)
        block.physicsBody?.angularVelocity = CGFloat(0.6)
        block.physicsBody?.mass = CGFloat(6.3)
        

        addChild(block)
        
    }
    
}
//
//  Title.swift
//  iSoBlocks
//
//  Created by Tassos Lambrou on 8/2/16.
//  Copyright © 2016 Ssos Games. All rights reserved.
//

import Foundation
import SpriteKit
import CoreMotion

class Title: SKScene {
    
    var playButton: MSButtonNode!
    
    var motionManager = CMMotionManager()
    
    override func didMoveToView(view: SKView) {
        playButton = self.childNodeWithName("playButton") as! MSButtonNode
        
        playButton.selectedHandler = {
            
            /* Grab reference to the SpriteKit view */
            let skView = self.view as SKView!
            
            /* Load Game scene */
            let scene = GameScene(fileNamed:"GameScene") as GameScene!
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .AspectFill
            
            /* Restart GameScene */
            skView.presentScene(scene)
            
            // Reset the score
            multiplierScore = 0
            sumScore = 0
            
        }

        
        
        let creation = SKAction.runBlock({self.createBlock()})
        let wait = SKAction.waitForDuration(NSTimeInterval(0.4))
        let seq = SKAction.repeatAction(SKAction.sequence([creation, wait]), count: 100)
        runAction(seq)
    }
    
    override func update(currentTime: NSTimeInterval) {
        motionManager.startAccelerometerUpdates()
        
        if let accelerometerData = motionManager.accelerometerData {
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.x * 30 , dy: accelerometerData.acceleration.y * 30)
            
            
        }
        
        
    }
    
    func createBlock () {
        
        var imageAsset: String = ""
        
        let rand:Int = Int.random(3)+1
        switch rand {
        case 1:
            imageAsset = "RoundRectGreen"
        case 2:
            imageAsset = "RoundRectCoral"
        case 3:
            imageAsset = "RoundRectTeal"
        default:
            imageAsset = "RoundRect"
            print("random texture assignment didn't work")
        }
        
        let block = SKSpriteNode(imageNamed: imageAsset)
        
        block.zPosition = 1
        
        let xRandom: Int = Int.random(870)+1
        block.position = CGPoint(x: xRandom, y: 2005)
        
        block.physicsBody = SKPhysicsBody.init(rectangleOfSize: CGSize(width: 104, height: 104))
        block.physicsBody?.affectedByGravity = true
        block.physicsBody?.allowsRotation = true
        block.zRotation = CGFloat(4.0)
        block.physicsBody?.restitution = CGFloat(0.85)
        block.physicsBody?.angularVelocity = CGFloat(0.6)
        block.physicsBody?.mass = CGFloat(6.3)
        
        addChild(block)
        
    }
    
}
//
//  GameScene.swift
//  iSoBlocks
//
//  Created by Tassos Lambrou on 7/9/16.
//  Copyright (c) 2016 Ssos Games. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var gridNode: Grid!
    var topStageNode: StageH!
    var bottomStageNode: StageH!
    var leftStageNode: StageV!
    var rightStageNode: StageV!
    var restartButton: MSButtonNode!
    
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
}

//
//  GameScene.swift
//  iSoBlocks
//
//  Created by Tassos Lambrou on 7/9/16.
//  Copyright (c) 2016 Ssos Games. All rights reserved.
//

import SpriteKit


var gridNode: Grid!
var topStage: Stage!
var bottomStage: Stage!
var leftStage: Stage!
var rightStage: Stage!


class GameScene: SKScene {
    
    
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        gridNode = childNodeWithName("gridNode") as! Grid
        topStage = childNodeWithName("topStage") as! Stage
        bottomStage = childNodeWithName("bottomStage") as! Stage
        leftStage = childNodeWithName("leftStage") as! Stage
        rightStage = childNodeWithName("rightStage") as! Stage
        
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

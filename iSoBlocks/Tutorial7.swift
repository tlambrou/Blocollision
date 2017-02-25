//
//  Tutorial.swift
//  Bloctorials
//
//  Created by Tassos Lambrou on 2/23/17.
//  Copyright © 2017 Ssos Games. All rights reserved.
//

import Foundation
import SpriteKit

class Tutorial7: SKScene {
  
  var nextButton: MSButtonNode!
  var prevButton: MSButtonNode!
  var homeButton: MSButtonNode!
  
  
  override func didMove(to view: SKView) {
    
    nextButton = self.childNode(withName: "nextButton") as! MSButtonNode
    
    prevButton = self.childNode(withName: "prevButton") as! MSButtonNode
    
    homeButton = self.childNode(withName: "homeButton") as! MSButtonNode
    
    // Back to Home Button
    homeButton.selectedHandler = {
      
      /* Play SFX */
      let click = SKAction.playSoundFileNamed("click3", waitForCompletion: true)
      self.run(click)
      
      /* Grab reference to the SpriteKit view */
      let skView = self.view as SKView!
      
      /* Load Game scene */
      let scene = Title(fileNamed:"Title") as Title!
      
      /* Ensure correct aspect mode */
      scene?.scaleMode = .aspectFit
      
      /* Restart GameScene */
      skView?.presentScene(scene)
      
    }
    
    // Back to Previous in Tutorial
    prevButton.selectedHandler = {
      
      /* Play SFX */
      let click = SKAction.playSoundFileNamed("click3", waitForCompletion: true)
      self.run(click)
      
      /* Grab reference to the SpriteKit view */
      let skView = self.view as SKView!
      
      /* Load Game scene */
      let scene = Tutorial6(fileNamed:"Tutorial6") as Tutorial6!
      
      /* Ensure correct aspect mode */
      scene?.scaleMode = .aspectFit
      
      /* Restart GameScene */
      skView?.presentScene(scene)
      
    }
    
    // Next Button for Next in Tutorial
    nextButton.selectedHandler = {
      
      /* Play SFX */
      let click = SKAction.playSoundFileNamed("click3", waitForCompletion: true)
      self.run(click)
      
      /* Grab reference to the SpriteKit view */
      let skView = self.view as SKView!
      
      /* Load Game scene */
      let scene = Title(fileNamed:"Title") as Title!
      
      /* Ensure correct aspect mode */
      scene?.scaleMode = .aspectFit
      
      /* Restart GameScene */
      skView?.presentScene(scene)
      
    }
    
    
    
    
    
  }
  
  
  
}

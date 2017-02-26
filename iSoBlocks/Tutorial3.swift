//
//  Tutorial.swift
//  Bloctorials
//
//  Created by Tassos Lambrou on 2/23/17.
//  Copyright © 2017 Ssos Games. All rights reserved.
//

import Foundation
import SpriteKit

class Tutorial3: SKScene {
  
  var nextButton: MSButtonNode!
  var prevButton: MSButtonNode!
  var homeButton: MSButtonNode!
  
  
  override func didMove(to view: SKView) {
    
    nextButton = self.childNode(withName: "nextButton") as! MSButtonNode
    
    prevButton = self.childNode(withName: "prevButton") as! MSButtonNode
    
    homeButton = self.childNode(withName: "homeButton") as! MSButtonNode
    
    // Back to Home Button
    homeButton.selectedHandler = {
      
      // Play Sound Effect
      Sound.play(file: "click2.wav")
      
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
      
      // Play Sound Effect
      Sound.play(file: "click2.wav")
      
      /* Grab reference to the SpriteKit view */
      let skView = self.view as SKView!
      
      /* Load Game scene */
      let scene = Tutorial2(fileNamed:"Tutorial2") as Tutorial2!
      
      /* Ensure correct aspect mode */
      scene?.scaleMode = .aspectFit
      
      /* Restart GameScene */
      skView?.presentScene(scene)
      
    }
    
    // Next Button for Next in Tutorial
    nextButton.selectedHandler = {
      
      // Play Sound Effect
      Sound.play(file: "click2.wav")
      
      /* Grab reference to the SpriteKit view */
      let skView = self.view as SKView!
      
      /* Load Game scene */
      let scene = Tutorial4(fileNamed:"Tutorial4") as Tutorial4!
      
      /* Ensure correct aspect mode */
      scene?.scaleMode = .aspectFit
      
      /* Restart GameScene */
      skView?.presentScene(scene)
      
    }
    
    
    
    
    
  }
  
  
  
}

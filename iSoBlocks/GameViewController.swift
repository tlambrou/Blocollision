//
//  GameViewController.swift
//  iSoBlocks
//
//  Created by Tassos Lambrou on 7/9/16.
//  Copyright (c) 2016 SsosSoft. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation



class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch let error as NSError {
            print(error)
        }
        
        if let scene = Title(fileNamed:"Title") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFit
            
            skView.presentScene(scene)
        }
    }

    override var shouldAutorotate : Bool {
        return true
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    
    
    
    
}

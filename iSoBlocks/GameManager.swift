//
//  GameManager2.swift
//  iSoBlocks
//
//  Created by Tassos Lambrou on 8/1/16.
//  Copyright © 2016 SsosSoft. All rights reserved.
//

import Foundation

class GameManager {
    static let sharedInstance = GameManager()
    var name: String = NSUserDefaults.standardUserDefaults().stringForKey("myName") ?? "User" {
        didSet {
            NSUserDefaults.standardUserDefaults().setObject(name, forKey:"myName")
            // Saves to disk immediately, otherwise it will save when it has time
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    var highScore: Int = NSUserDefaults.standardUserDefaults().integerForKey("myHighScore") ?? 0 {
        didSet {
            NSUserDefaults.standardUserDefaults().setInteger(highScore, forKey:"myHighScore")
            // Saves to disk immediately, otherwise it will save when it has time
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    var timedHighScore: Int = NSUserDefaults.standardUserDefaults().integerForKey("timedHighScore") ?? 0 {
        didSet {
            NSUserDefaults.standardUserDefaults().setInteger(timedHighScore, forKey:"timedHighScore")
            // Saves to disk immediately, otherwise it will save when it has time
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    var movesHighScore: Int = NSUserDefaults.standardUserDefaults().integerForKey("movesHighScore") ?? 0 {
        didSet {
            NSUserDefaults.standardUserDefaults().setInteger(movesHighScore, forKey:"movesHighScore")
            // Saves to disk immediately, otherwise it will save when it has time
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    
}
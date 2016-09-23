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
    var name: String = UserDefaults.standard.string(forKey: "myName") ?? "User" {
        didSet {
            UserDefaults.standard.set(name, forKey:"myName")
            // Saves to disk immediately, otherwise it will save when it has time
            UserDefaults.standard.synchronize()
        }
    }
    
    var highScore: Int = UserDefaults.standard.integer(forKey: "myHighScore") ?? 0 {
        didSet {
            UserDefaults.standard.set(highScore, forKey:"myHighScore")
            // Saves to disk immediately, otherwise it will save when it has time
            UserDefaults.standard.synchronize()
        }
    }
    
    var timedHighScore: Int = UserDefaults.standard.integer(forKey: "timedHighScore") ?? 0 {
        didSet {
            UserDefaults.standard.set(timedHighScore, forKey:"timedHighScore")
            // Saves to disk immediately, otherwise it will save when it has time
            UserDefaults.standard.synchronize()
        }
    }
    
    var movesHighScore: Int = UserDefaults.standard.integer(forKey: "movesHighScore") ?? 0 {
        didSet {
            UserDefaults.standard.set(movesHighScore, forKey:"movesHighScore")
            // Saves to disk immediately, otherwise it will save when it has time
            UserDefaults.standard.synchronize()
        }
    }
    
    
}

//
//  GameTracker.swift
//  Bloctorials
//
//  Created by Tassos Lambrou on 8/6/16.
//  Copyright © 2016 Ssos Games. All rights reserved.
//

import Foundation
import SpriteKit

struct GameTracker {
    
    var idle: Bool = false
    var instShown: Bool = false
    var firstInstShown: Bool = false
    
    
    var timeElapsedSinceIdle: Int = 0 {
        didSet {
            if timeElapsedSinceIdle > 180 && firstInstShown == false {
                idle = true
            } else if timeElapsedSinceIdle > 600 && firstInstShown == true {
                idle = true
            } else if timeElapsedSinceIdle < 180 {
                idle = false
            }
        }
    }
    
    var sumScore: Int = 0 {
        didSet {
            score = multiplierScore + sumScore
        }
    }
    var multiplierScore: Int = 0 {
        didSet {
            score = multiplierScore + sumScore
        }
    }
    
    var score: Int = 0 {
        didSet {
            // Update the score's label
//            scoreLabel.text = String(score)
            
            // Set the difficulty equal to 1
            if (score > 100) && (score < 200){
                //        difficulty = 1
            }
        } }
    
    var numBlocks: Int = 1 {
        didSet {
            if numBlocks > 4 {
                numBlocks = 4
            } else if numBlocks < 1 {
                numBlocks = 1
            }
        }
    }
    
    var clrdAisles: Int = 0 {
        didSet {
            if clrdAisles == 1 {
                difficulty = 2
            }
        }
    }
    
    var spawnRate: Int = 1 {
        didSet {
            if spawnRate > 16 {
                spawnRate = 16
            } else if spawnRate < 1 {
                spawnRate = 1
            }
        }
    }
    
    
    var difficulty: Int = 1 {
        didSet {
            
            // Level Design
            switch difficulty {
            case 1:
                spawnRate = 1
                numBlocks = 1
                break
            case 2:
                spawnRate = 1
                numBlocks = 2
                break
            case 3:
                spawnRate = 2
                numBlocks = 2
                break
            case 4:
                spawnRate = 3
                numBlocks = 2
                break
            case 5:
                spawnRate = 4
                numBlocks = 2
                break
            case 6:
                spawnRate = 4
                numBlocks = 3
                break
            case 7:
                spawnRate = 5
                numBlocks = 3
                break
            case 8:
                spawnRate = 6
                numBlocks = 3
                break
            case 9:
                spawnRate = 7
                numBlocks = 3
                break
            case 10:
                spawnRate = 8
                numBlocks = 3
                break
            case 11:
                spawnRate = 9
                numBlocks = 3
                break
            case 12:
                spawnRate = 10
                numBlocks = 3
                break
            case 13:
                spawnRate = 11
                numBlocks = 3
                break
            case 14:
                spawnRate = 6
                numBlocks = 4
                break
            case 15:
                spawnRate = 7
                numBlocks = 4
                break
            case 16:
                spawnRate = 8
                numBlocks = 4
                break
            case 17:
                spawnRate = 9
                numBlocks = 4
                break
            case 18:
                spawnRate = 10
                numBlocks = 4
                break
            case 19:
                spawnRate = 11
                numBlocks = 4
                break
            case 20:
                spawnRate = 12
                numBlocks = 4
                break
            case 21:
                spawnRate = 13
                numBlocks = 4
                break
            case 22:
                spawnRate = 14
                numBlocks = 4
                break
            case 23:
                spawnRate = 15
                numBlocks = 4
                break
            case 24:
                spawnRate = 16
                numBlocks = 4
                break
            
                
            default:
                gameState = .won
                
            }
            
        }
    }
    
}

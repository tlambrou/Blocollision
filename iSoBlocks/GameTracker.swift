//
//  GameTracker.swift
//  Bloctorials
//
//  Created by Tassos Lambrou on 8/6/16.
//  Copyright © 2016 SsosSoft. All rights reserved.
//

import Foundation
import SpriteKit



var gameTrackerState: GameState = .playing


var numBlocks: Int = 1 {
didSet {
    if numBlocks > 4 {
        numBlocks = 4
    } else if numBlocks < 1 {
        numBlocks = 1
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

struct GameTracker {
    
    init() {
       
        numBlocks = 1
        spawnRate = 1
    }
    
    
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
           scored = score - prevDiffScore
        } }
    
    var scored: Int = 0
    var prevDiffScore: Int = 0
    
    var clrdAisles: Int = 0 {
        didSet {
            
        }
    }
    
    var difficulty: Int = 1 {
        didSet {
            
            // Level Design
            switch difficulty {
            case 1:
                spawnRate = 1
                numBlocks = 1
                prevDiffScore = score
                break
            case 2:
                spawnRate = 2
                numBlocks = 2
                prevDiffScore = score
                break
            case 3:
                spawnRate = 3
                numBlocks = 2
                prevDiffScore = score
                break
            case 4:
                spawnRate = 4
                numBlocks = 3
                prevDiffScore = score
                break
            case 5:
                spawnRate = 5
                numBlocks = 3
                prevDiffScore = score
                break
            case 6:
                spawnRate = 6
                numBlocks = 3
                prevDiffScore = score
                break
            case 7:
                spawnRate = 7
                numBlocks = 3
                prevDiffScore = score
                break
            case 8:
                spawnRate = 8
                numBlocks = 3
                prevDiffScore = score
                break
            case 9:
                spawnRate = 9
                numBlocks = 3
                prevDiffScore = score
                break
            case 10:
                spawnRate = 4
                numBlocks = 4
                prevDiffScore = score
                break
            case 11:
                spawnRate = 5
                numBlocks = 4
                prevDiffScore = score
                break
            case 12:
                spawnRate = 6
                numBlocks = 4
                prevDiffScore = score
                break
            case 13:
                spawnRate = 7
                numBlocks = 4
                prevDiffScore = score
                break
            case 14:
                spawnRate = 8
                numBlocks = 4
                prevDiffScore = score
                break
            case 15:
                spawnRate = 9
                numBlocks = 4
                prevDiffScore = score
                break
            case 16:
                spawnRate = 10
                numBlocks = 4
                prevDiffScore = score
                break
            case 17:
                spawnRate = 11
                numBlocks = 4
                prevDiffScore = score
                break
            case 18:
                spawnRate = 12
                numBlocks = 4
                prevDiffScore = score
                break
            case 19:
                spawnRate = 13
                numBlocks = 4
                prevDiffScore = score
                break
            case 20:
                spawnRate = 14
                numBlocks = 4
                prevDiffScore = score
                break
            case 21:
                spawnRate = 15
                numBlocks = 4
                prevDiffScore = score
                break
            case 22:
                spawnRate = 16
                numBlocks = 4
                prevDiffScore = score
                break
            case 23:
                spawnRate = 16
                numBlocks = 4
                prevDiffScore = score
                break
            case 24:
                spawnRate = 16
                numBlocks = 4
                prevDiffScore = score
                break
            default:
                gameTrackerState = .won

                
            }
            
        }
    }
    
    mutating func difficultyRules() {
        
        
        switch difficulty {
        case 1:
            if scored >= 1 && clrdAisles >= 1 {
                difficulty = 2
            }
            break
        case 2:
            if scored >= 50 && clrdAisles >= 2 {
                difficulty = 3
            }
            break
        case 3:
            if scored >= 100 && clrdAisles >= 5 {
                difficulty = 4
            }
            break
        case 4:
            if scored >= 100 && clrdAisles >= 10 {
                difficulty = 5
            }
            break
        case 5:
            if scored >= 200 && clrdAisles >= 15 {
                difficulty = 6
            }
            break
        case 6:
            if scored >= 200 && clrdAisles >= 18 {
                difficulty = 7
            }
            break
        case 7:
            if scored >= 100 && clrdAisles >= 20 {
                difficulty = 8
            }
            break
        case 8:
            if scored >= 200 && clrdAisles >= 25 {
                difficulty = 9
            }
            break
        case 9:
            if scored >= 250 && clrdAisles >= 30 {
                difficulty = 10
            }
            break
        case 10:
            if scored >= 300 && clrdAisles >= 35 {
                difficulty = 11
            }
            break
        case 11:
            if scored >= 400 && clrdAisles >= 40 {
                difficulty = 12
            }
            break
        case 12:
            if scored >= 450 && clrdAisles >= 45 {
                difficulty = 13
            }
            break
        case 13:
            if scored >= 500 && clrdAisles >= 50 {
                difficulty = 14
            }
            break
        case 14:
            if scored >= 600 && clrdAisles >= 52 {
                difficulty = 15
            }
            break
        case 15:
            if scored >= 700 && clrdAisles >= 55 {
                difficulty = 16
            }
            break
        case 16:
            if scored >= 800 && clrdAisles >= 58 {
                difficulty = 17
            }
            break
        case 17:
            if scored >= 900 && clrdAisles >= 60 {
                difficulty = 18
            }
            break
        case 18:
            if scored >= 1000 && clrdAisles >= 65 {
                difficulty = 19
            }
            break
        case 19:
            if scored >= 2000 && clrdAisles >= 70 {
                difficulty = 20
            }
            break
        case 20:
            if scored >= 3000 && clrdAisles >= 80 {
                difficulty = 21
            }
            break
        case 21:
            if scored >= 4000 && clrdAisles >= 90 {
                difficulty = 22
            }
            break
        case 22:
            if scored >= 5000 && clrdAisles >= 100 {
                difficulty = 23
            }
            break
        case 23:
            if scored >= 7000 && clrdAisles >= 125 {
                difficulty = 24
            }
            break
        case 24:
            if scored >= 10000 && clrdAisles >= 150 {
                gameTrackerState = .won
            }
            break
            
            
        default:
            gameTrackerState = .won
        }
        
    }
    
}

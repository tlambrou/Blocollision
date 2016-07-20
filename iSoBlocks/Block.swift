//
//  Block.swift
//  iSoBlocks
//
//  Created by Tassos Lambrou on 7/9/16.
//  Copyright © 2016 Ssos Games. All rights reserved.
//

import Foundation
import SpriteKit

enum BlockType { case inactive, rock, paper, scissors }

class Block: SKSpriteNode {
    
        
    
        /* Character side */
        var state:BlockType = .inactive
            {
            
            didSet {
                
                switch state {
                case .inactive:
                    let action = SKAction.setTexture(SKTexture(imageNamed: "RoundRect"))
                        runAction(action)
                    hidden = false
                    
                case .rock:
                    let action = SKAction.setTexture(SKTexture(imageNamed: "RockBlock"))
                    runAction(action)
                    hidden = false
                    break;
                    
                case .paper:
                    let action = SKAction.setTexture(SKTexture(imageNamed: "PaperBlock"))
                    runAction(action)
                    hidden = false
                    break;
                    
                case .scissors:
                    let action = SKAction.setTexture(SKTexture(imageNamed: "ScissorsBlock"))
                    runAction(action)
                    hidden = false
                    break;
                    
                }
            }
            
        }
    
        //    var isAlive: Bool = false {
        //        didSet {
        //            /* Visibility */
        //            hidden = !isAlive
        //        }
        //    }
        
    var stack: Int = 0
    
        init() {
            /* Initialize with 'block' asset */
            let texture = SKTexture(imageNamed: "RoundRect")
            super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
            hidden = false
            
            /* Set Z-Position, ensure it's on top of grid */
            zPosition = 1
            
            
            /* Set anchor point to bottom-left */
            anchorPoint = CGPoint(x: 0.5, y: 0.5)
            
            
            
        }
        
        
        
        /* You are required to implement this for your subclass to work */
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        
        
        
        
}
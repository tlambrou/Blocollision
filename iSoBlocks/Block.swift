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
                hidden = true
                
            case .rock:
                let action = SKAction.setTexture(SKTexture(imageNamed: "voxelTile_45"))
                runAction(action)
                hidden = false
                break;
                
            case .paper:
                let action = SKAction.setTexture(SKTexture(imageNamed: "voxelTile_54"))
                runAction(action)
                hidden = false
                break;
                
            case .scissors:
                let action = SKAction.setTexture(SKTexture(imageNamed: "platformerTile_26"))
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
    
    
    
    init() {
        /* Initialize with 'block' asset */
        let texture = SKTexture(imageNamed: "abstractTile_09")
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
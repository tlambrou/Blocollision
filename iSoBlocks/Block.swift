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
    
    
    var stack: Int = 0 {
        didSet {
            if stack > 1 {
                label.text = String(stack)
                label.hidden = false
                labelBG.text = String(stack)
                labelBG.hidden = false
                
            }
        }
    }
    var label: SKLabelNode!
    var labelBG: SKLabelNode!
    
    var state:BlockType = .inactive
        {
        
        didSet {
            
            switch state {
            case .inactive:
                let action = SKAction.setTexture(SKTexture(imageNamed: "RoundRect"))
                runAction(action)
                stack = 0
                label.hidden = true
                labelBG.hidden = true
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
    
    
    init() {
        /* Initialize with 'block' asset */
        let texture = SKTexture(imageNamed: "RoundRect")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        hidden = false
        
        
        label = SKLabelNode(text: String(stack))
        label.hidden = true
        label.fontName = "AvenirNext-Bold"
        label.fontSize = 60
//        label.fontColor = UIColor(netHex:0x00C5B8)
        
        let xLabel: CGFloat = CGFloat(1080/columns/5)
        let yLabel: CGFloat = -xLabel
        label.position.offset(dx: xLabel, dy: yLabel)
        
        label.verticalAlignmentMode = .Baseline
        label.horizontalAlignmentMode = .Right
        label.zPosition = 10
        
        labelBG = SKLabelNode(text: String(stack))
        labelBG.fontSize = 60
        labelBG.fontName = "AvenirNext-Heavy"
        labelBG.hidden = true
        labelBG.position.offset(dx: xLabel, dy: yLabel)
        labelBG.verticalAlignmentMode = .Baseline
        labelBG.horizontalAlignmentMode = .Right
        labelBG.zPosition = 9
        labelBG.alpha = 0.9
        labelBG.fontColor = UIColor(netHex:0xBE1D30)
        
        addChild(label)
        addChild(labelBG)
       
        
        
        /* Set Z-Position, ensure it's on top of grid */
        zPosition = 1
        
        /* Set anchor point to center */
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        
        
    }
    
    
    
    /* You are required to implement this for your subclass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    
    
}
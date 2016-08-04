//
//  Block.swift
//  iSoBlocks
//
//  Created by Tassos Lambrou on 7/9/16.
//  Copyright © 2016 Ssos Games. All rights reserved.
//

import Foundation
import SpriteKit

enum BlockType { case inactive, red, blue, green }

class Block: SKSpriteNode {
    
    var score: Int = 0
    
    var stack: Int = -1 {
        didSet {
            score = factorial(stack)
            
            if stack > 0 {
                label.text = String(stack)
                label.hidden = false
                factLabel.hidden = false
                label.zPosition = 4
                
            } else if stack == 0 {
                label.text = String(stack)
                label.hidden = false
                factLabel.hidden = true
                label.zPosition = 4
                
            }
            
            
        }
    }
    var label: SKLabelNode!
    var factLabel: SKLabelNode!
    
    var state:BlockType = .inactive
        {
        
        didSet {
            
            switch state {
            case .inactive:
                let action = SKAction.setTexture(SKTexture(imageNamed: "RoundRect"))
                runAction(action)
                stack = -1
                label.hidden = true
                factLabel.hidden = true
                hidden = false
                
            case .red:
                let action = SKAction.setTexture(SKTexture(imageNamed: "RoundRectCoral"))
                runAction(action)
                hidden = false
                break;
                
            case .blue:
                let action = SKAction.setTexture(SKTexture(imageNamed: "RoundRectTeal"))
                runAction(action)
                hidden = false
                break;
                
            case .green:
                let action = SKAction.setTexture(SKTexture(imageNamed: "RoundRectGreen"))
                runAction(action)
                hidden = false
                break;
                
            }
        }
        
    }
    
    var gsPosition: CGPoint?
    
    init() {
        /* Initialize with 'block' asset */
        let texture = SKTexture(imageNamed: "RoundRect")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        /* Set Z-Position, ensure it's on top of grid */
        zPosition = 1
        
        /* Set anchor point to center */
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        // Set block visible
        hidden = false
        
        // Create the Stack label
        label = SKLabelNode(text: String(stack))
        label.hidden = true
        label.fontName = "AvenirNext-Bold"
        label.fontSize = 60
        let xLabel: CGFloat = CGFloat(1080/columns/6)
        let yLabel: CGFloat = -xLabel
        label.position.offset(dx: xLabel - 10, dy: yLabel)
        
        label.verticalAlignmentMode = .Baseline
        label.horizontalAlignmentMode = .Right
        label.zPosition = 4
        addChild(label)
       
        // Create the Factorial Label
        factLabel = SKLabelNode(text: String("!"))
        factLabel.hidden = true
        factLabel.fontName = "Verdana-Bold"
        factLabel.fontSize = 60
        factLabel.position.offset(dx: xLabel, dy: yLabel)
        factLabel.verticalAlignmentMode = .Baseline
        factLabel.horizontalAlignmentMode = .Left
        factLabel.zPosition = 4
        addChild(factLabel)
        
        
    }
    
    
    
    /* You are required to implement this for your subclass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    
    
}
//
//  Block.swift
//  iSoBlocks
//
//  Created by Tassos Lambrou on 7/9/16.
//  Copyright © 2016 Ssos Games. All rights reserved.
//

import Foundation
import SpriteKit

enum BlockType { case inactive, red, blue, green, yellow }

class Block: SKSpriteNode {
    
    var factScore: Int = 0
    
    var stack: Int = 0 {
        didSet {
            
            let asset = getImageName(state, stack: stack)
            let action = SKAction.setTexture(SKTexture(imageNamed: asset))
            runAction(action)
            
            if stack < 0 {
                stack = 0
            }
            
            factScore = factorial(stack)
            
            if stack >= 0 {
                label.text = String(stack)
                label.hidden = false
                factLabel.hidden = false
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
                let asset = getImageName(state, stack: stack)
                let action = SKAction.setTexture(SKTexture(imageNamed: asset))
                runAction(action)
                stack = 0
                label.hidden = true
                factLabel.hidden = true
                hidden = false
                
            case .red:
                let asset = getImageName(state, stack: stack)
                let action = SKAction.setTexture(SKTexture(imageNamed: asset))
                runAction(action)
                hidden = false
                break;
                
            case .blue:
                let asset = getImageName(state, stack: stack)
                let action = SKAction.setTexture(SKTexture(imageNamed: asset))
                runAction(action)
                hidden = false
                break;
                
            case .green:
                let asset = getImageName(state, stack: stack)
                let action = SKAction.setTexture(SKTexture(imageNamed: asset))
                runAction(action)
                hidden = false
                break;
            case .yellow:
                let asset = getImageName(state, stack: stack)
                let action = SKAction.setTexture(SKTexture(imageNamed: asset))
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
    
    func getImageName(state: BlockType, stack: Int) -> String {
        
        var assetString: String = ""
        
        switch stack {
        case 0:
            switch state {
            case .inactive:
                assetString = "RoundRect"
                // Return string value
                return assetString
            case .red:
                assetString = "RedBlock1"
                // Return string value
                return assetString
            case .blue:
                assetString = "TealBlock1"
                // Return string value
                return assetString
            case .green:
                assetString = "GreenBlock1"
                // Return string value
                return assetString
            case .yellow:
                assetString = "YellowBlock1"
                // Return string value
                return assetString
            }
        case 1:
            switch state {
            case .inactive:
                assetString = "RoundRect"
                // Return string value
                return assetString
            case .red:
                assetString = "RedBlock1"
                // Return string value
                return assetString
            case .blue:
                assetString = "TealBlock1"
                // Return string value
                return assetString
            case .green:
                assetString = "GreenBlock1"
                // Return string value
                return assetString
            case .yellow:
                assetString = "YellowBlock1"
                // Return string value
                return assetString
            }
        case 2:
            switch state {
            case .inactive:
                assetString = "RoundRect"
                // Return string value
                return assetString
            case .red:
                assetString = "RedBlock1"
                // Return string value
                return assetString
            case .blue:
                assetString = "TealBlock1"
                // Return string value
                return assetString
            case .green:
                assetString = "GreenBlock1"
                // Return string value
                return assetString
            case .yellow:
                assetString = "YellowBlock1"
                // Return string value
                return assetString
            }
        case 3:
            switch state {
            case .inactive:
                assetString = "RoundRec1"
                // Return string value
                return assetString
            case .red:
                assetString = "RedBlock1"
                // Return string value
                return assetString
            case .blue:
                assetString = "TealBlock1"
                // Return string value
                return assetString
            case .green:
                assetString = "GreenBlock1"
                // Return string value
                return assetString
            case .yellow:
                assetString = "YellowBlock1"
                // Return string value
                return assetString
            }
        case 4:
            switch state {
            case .inactive:
                assetString = "RoundRect"
                // Return string value
                return assetString
            case .red:
                assetString = "RedBlock2"
                // Return string value
                return assetString
            case .blue:
                assetString = "TealBlock2"
                // Return string value
                return assetString
            case .green:
                assetString = "GreenBlock2"
                // Return string value
                return assetString
            case .yellow:
                assetString = "YellowBlock2"
                // Return string value
                return assetString
            }
        case 5:
            switch state {
            case .inactive:
                assetString = "RoundRect"
                // Return string value
                return assetString
            case .red:
                assetString = "RedBlock3"
                // Return string value
                return assetString
            case .blue:
                assetString = "TealBlock3"
                // Return string value
                return assetString
            case .green:
                assetString = "GreenBlock3"
                // Return string value
                return assetString
            case .yellow:
                assetString = "YellowBlock3"
                // Return string value
                return assetString
            }
        case 6:
            switch state {
            case .inactive:
                assetString = "RoundRect"
                // Return string value
                return assetString
            case .red:
                assetString = "RedBlock4"
                // Return string value
                return assetString
            case .blue:
                assetString = "TealBlock4"
                // Return string value
                return assetString
            case .green:
                assetString = "GreenBlock4"
                // Return string value
                return assetString
            case .yellow:
                assetString = "YellowBlock4"
                // Return string value
                return assetString
            }
        case 7:
            switch state {
            case .inactive:
                assetString = "RoundRect"
                // Return string value
                return assetString
            case .red:
                assetString = "RedBlock5"
                // Return string value
                return assetString
            case .blue:
                assetString = "TealBlock5"
                // Return string value
                return assetString
            case .green:
                assetString = "GreenBlock5"
                // Return string value
                return assetString
            case .yellow:
                assetString = "YellowBlock5"
                // Return string value
                return assetString
            }
        case 8:
            switch state {
            case .inactive:
                assetString = "RoundRect"
                // Return string value
                return assetString
            case .red:
                assetString = "RedBlock5"
                // Return string value
                return assetString
            case .blue:
                assetString = "TealBlock5"
                // Return string value
                return assetString
            case .green:
                assetString = "GreenBlock5"
                // Return string value
                return assetString
            case .yellow:
                assetString = "YellowBlock5"
                // Return string value
                return assetString
            }
        case 9:
            switch state {
            case .inactive:
                assetString = "RoundRect"
                // Return string value
                return assetString
            case .red:
                assetString = "RedBlock5"
                // Return string value
                return assetString
            case .blue:
                assetString = "TealBlock5"
                // Return string value
                return assetString
            case .green:
                assetString = "GreenBlock5"
                // Return string value
                return assetString
            case .yellow:
                assetString = "YellowBlock5"
                // Return string value
                return assetString
            }
        default:
            print("Failed to Assign assetString properly in Block.getImageName()")
            assetString = "RoundRect"
        }
        
        // Return string value
        return assetString
    }
    
}
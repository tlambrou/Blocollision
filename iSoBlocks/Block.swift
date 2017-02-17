//
//  Block.swift
//  iSoBlocks
//
//  Created by Tassos Lambrou on 7/9/16.
//  Copyright © 2016 SsosSoft. All rights reserved.
//

import Foundation
import SpriteKit

enum BlockType { case inactive, red, blue, green, yellow }

class Block: SKSpriteNode {
    
    var factScore: Int = 0
    
    var factStack: Bool = false {
        didSet{
            
            if state != .inactive {
                
                if factStack == true {
                    
                    label.isHidden = true
                    factLabel.isHidden = false
                    
                } else if factStack == false {
                    
                    label.isHidden = false
                    factLabel.isHidden = true
                    
                }
                
            }
        }
    }
  
  
    var stack: Int = 0 {
        didSet {
            
            let asset = getBlockImageName(state, stack: stack)
            let action = SKAction.setTexture(SKTexture(imageNamed: asset))
            run(action)
            
            
            if stack < 0 {
                stack = 0
            }
            
            factScore = factorial(stack)
            
            if stack >= 0 {
                //                label.text = String(stack)
                let assetString = String(stack)
                let action = SKAction.setTexture(SKTexture(imageNamed: assetString))
                label.run(action)
                
                if factStack == false {
                    
                    label.isHidden = false
                    factLabel.isHidden = true
                }
                //                factLabel.hidden = false
                label.zPosition = 4
                
                let faction = SKAction.setTexture(SKTexture(imageNamed: assetString + "Fact"))
                factLabel.run(faction)
                
                let dummyLabel = SKTexture(imageNamed: assetString + "Fact")
                
                let factHeight = dummyLabel.size().height
                let factWidth = dummyLabel.size().width
                
                let heightRatio = CGFloat(factHeight/CGFloat(cellHeight))
                let widthRatio = CGFloat(factWidth/CGFloat(cellWidth))
                
                if factWidth > factHeight {
                    
                    factLabel.setScale(widthRatio * 1)
//                    factLabel.size = CGSize(width: CGFloat(cellWidth/2), height: ((CGFloat(cellWidth/2) * factWidth) / factHeight))
                    
                } else if factHeight > factWidth {
                    
                    factLabel.setScale(heightRatio * 1)
                    
//                    factLabel.size = CGSize(width: ((CGFloat(cellHeight/2) * factHeight) / factWidth), height: CGFloat(cellHeight/2))
                    
                }
                
                if factStack == true {
                    label.isHidden = true
                    factLabel.isHidden = false
                }
                
                label.zPosition = 4
                
                
            }
        }
    }
    var label: SKSpriteNode!
    var factLabel: SKSpriteNode!
    
    
    
    var state:BlockType = .inactive
        {
        
        didSet {
            
            switch state {
            case .inactive:
                let asset = getBlockImageName(state, stack: stack)
                let action = SKAction.setTexture(SKTexture(imageNamed: asset))
                run(action)
                stack = 0
                label.isHidden = true
                factLabel.isHidden = true
                //                factLabel.hidden = true
                isHidden = false
                
            case .red:
                let asset = getBlockImageName(state, stack: stack)
                let action = SKAction.setTexture(SKTexture(imageNamed: asset))
                run(action)
                isHidden = false
                break;
                
            case .blue:
                let asset = getBlockImageName(state, stack: stack)
                let action = SKAction.setTexture(SKTexture(imageNamed: asset))
                run(action)
                isHidden = false
                break;
                
            case .green:
                let asset = getBlockImageName(state, stack: stack)
                let action = SKAction.setTexture(SKTexture(imageNamed: asset))
                run(action)
                isHidden = false
                break;
                
            case .yellow:
                let asset = getBlockImageName(state, stack: stack)
                let action = SKAction.setTexture(SKTexture(imageNamed: asset))
                run(action)
                isHidden = false
                break;
                
            }
        }
        
    }
    
    var gsPosition: CGPoint?
    
    init() {
        /* Initialize with 'block' asset */
        let texture = SKTexture(imageNamed: "Inactive")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        /* Set Z-Position, ensure it's on top of grid */
        zPosition = 1
        
        /* Set anchor point to center */
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        // Set block visible
        isHidden = false
        
        // Create the Stack label
        //        label = SKLabelNode(text: String(stack))
        //        label.hidden = true
        //        label.fontName = "MarkerFelt-Wide"
        //        label.fontSize = 100
        
        let assetString = String(stack)
        label = SKSpriteNode(imageNamed: assetString)
        label.isHidden = true
        label.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        label.size = CGSize(width: cellWidth/2, height: cellHeight/2)
        
        label.position.offset(dx: 0, dy: (label.size.height/4))
        label.zPosition = 4
        addChild(label)
        
        
        factLabel = SKSpriteNode(imageNamed: (String(assetString) + "Fact"))
        factLabel.isHidden = true
        factLabel.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        
        factLabel.position.offset(dx: 0, dy: (factLabel.size.height/4))
        factLabel.zPosition = 4
        addChild(factLabel)
        
        //        label.verticalAlignmentMode = .Bottom
        //        label.horizontalAlignmentMode = .Right
        
        
        // Create the Factorial Label
        //        factLabel = SKSpriteNode(imageNamed: "Factorial")
        //        factLabel.anchorPoint = CGPoint(x: 0, y: 0.5)
        ////        factLabel = SKLabelNode(text: String(" !"))
        //        factLabel.size.height = label.size.height
        //        factLabel.size.width = 42*label.size.height/165
        //        factLabel.hidden = true
        //
        ////        let xOffset = CGFloat(10)
        //        label.position.offset(dx: ((factLabel.size.width + label.size.width)/4) , dy: (label.size.height/4))
        ////        label.position.offset(dx: xOffset, dy: 0)
        ////        factLabel.position.offset(dx: xOffset + 10, dy: CGFloat(0))
        //
        ////        factLabel.fontName = "MarkerFelt-Wide"
        ////        factLabel.fontSize = 100
        //        factLabel.position.offset(dx: (((factLabel.size.width + label.size.width)/4) + factLabel.size.width), dy: (label.size.height/4))
        ////        factLabel.verticalAlignmentMode = .Bottom
        ////        factLabel.horizontalAlignmentMode = .Left
        //        factLabel.zPosition = 4
        //        addChild(factLabel)
        
        
        
    }
    
    
    
    /* You are required to implement this for your subclass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //    func getStackImageName(stack: Int) -> String {
    //
    //        var assetString: String = ""
    //
    //        switch stack {
    //        case 0:
    //            assetString = "0"
    //            return assetString
    //        default:
    //            <#code#>
    //        }
    //
    //    }
    
    func getBlockImageName(_ state: BlockType, stack: Int) -> String {
        
        var assetString: String = ""
        
        switch stack {
        case 0:
            switch state {
            case .inactive:
                assetString = "Inactive"
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
                assetString = "Inactive"
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
                assetString = "Inactive"
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
                assetString = "Inactive"
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
                assetString = "Inactive"
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
                assetString = "Inactive"
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
                assetString = "Inactive"
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
                assetString = "Inactive"
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
                assetString = "Inactive"
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
            assetString = "Inactive"
        }
        
        // Return string value
        return assetString
    }
    
}

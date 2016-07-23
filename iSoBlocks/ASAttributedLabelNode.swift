//
//  ASAttributedLabelNode.swift
//
//  Created by Alex Studnicka on 15/08/14.
//  Copyright © 2016 Alex Studnicka. MIT License.
//

import UIKit
import SpriteKit

class ASAttributedLabelNode: SKSpriteNode {
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	init(size: CGSize) {
		super.init(texture: nil, color: .clearColor(), size: size)
	}
	
	var attributedString: NSAttributedString! {
		didSet {
			draw()
		}
	}
	
	func draw() {
		guard let attrStr = attributedString else {
			texture = nil
			return
		}
		
		let scaleFactor = UIScreen.mainScreen().scale
		let colorSpace = CGColorSpaceCreateDeviceRGB()
		let bitmapInfo = CGImageAlphaInfo.PremultipliedLast.rawValue
		guard let context = CGBitmapContextCreate(nil, Int(size.width * scaleFactor), Int(size.height * scaleFactor), 8, Int(size.width * scaleFactor) * 4, colorSpace, bitmapInfo) else {
			return
		}

		CGContextScaleCTM(context, scaleFactor, scaleFactor)
		CGContextConcatCTM(context, CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: size.height))
		UIGraphicsPushContext(context)
		
		let strHeight = attrStr.boundingRectWithSize(size, options: .UsesLineFragmentOrigin, context: nil).height
		let yOffset = (size.height - strHeight) / 2.0
		attrStr.drawWithRect(CGRect(x: 0, y: yOffset, width: size.width, height: strHeight), options: .UsesLineFragmentOrigin, context: nil)
		
		if let imageRef = CGBitmapContextCreateImage(context) {
			texture = SKTexture(CGImage: imageRef)
		} else {
			texture = nil
		}
		
		UIGraphicsPopContext()
	}
    
    
//    private func createBorderPathForText() -> CGPathRef? {
//        let chars = getTextAsCharArray()
//        let borderFont = CTFontCreateWithName(self.fontName, self.fontSize, nil)
//        
//        var glyphs = Array(count: chars.count, repeatedValue: 0)
//        let gotGlyphs = CTFontGetGlyphsForCharacters(borderFont, chars, &glyphs, chars.count)
//        
//        if gotGlyphs {
//            var advances = Array(count: chars.count, repeatedValue: CGSize())
//            CTFontGetAdvancesForGlyphs(borderFont, CTFontOrientation.OrientationHorizontal, glyphs, &advances, chars.count);
//            
//            let letters = CGPathCreateMutable()
//            var xPosition = 0 as CGFloat
//            for index in 0...(chars.count - 1) {
//                let letter = CTFontCreatePathForGlyph(borderFont, glyphs[index], nil)
//                var t = CGAffineTransformMakeTranslation(xPosition , 0)
//                CGPathAddPath(letters, &t, letter)
//                xPosition = xPosition + advances[index].width
//            }
//            
//            return letters
//        } else {
//            return nil
//        }
//    }
	
}

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
		super.init(texture: nil, color: .clear, size: size)
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
		
		let scaleFactor = UIScreen.main.scale
		let colorSpace = CGColorSpaceCreateDeviceRGB()
		let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue
		guard let context = CGContext(data: nil, width: Int(size.width * scaleFactor), height: Int(size.height * scaleFactor), bitsPerComponent: 8, bytesPerRow: Int(size.width * scaleFactor) * 4, space: colorSpace, bitmapInfo: bitmapInfo) else {
			return
		}

		context.scaleBy(x: scaleFactor, y: scaleFactor)
		context.concatenate(CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: size.height))
		UIGraphicsPushContext(context)
		
		let strHeight = attrStr.boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil).height
		let yOffset = (size.height - strHeight) / 2.0
		attrStr.draw(with: CGRect(x: 0, y: yOffset, width: size.width, height: strHeight), options: .usesLineFragmentOrigin, context: nil)
		
		if let imageRef = context.makeImage() {
			texture = SKTexture(cgImage: imageRef)
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

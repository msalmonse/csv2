//
//  PNGtext.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-18.
//

import Foundation
import AppKit
import CoreText

extension PNG {

    private func propsFont(_ props: Properties) -> NSFont? {
        let family = props.cascade(.fontFamily) ?? "serif"
        let size = props.cascade(.fontSize)
        let font = NSFont(name: family, size: CGFloat(size))

        return font
    }

    func plotText(x: Double, y: Double, text: String, props: Properties) {
        image.withCGContext { ctx in
            let colour = ColourTranslate.lookup(props.cascade(.fontColour) ?? "black")
            let attr = [
                NSAttributedString.Key.foregroundColor: colour?.cgColor as Any,
                NSAttributedString.Key.font: propsFont(props) as Any
            ] as [NSAttributedString.Key: Any]
            let attrText = NSAttributedString(string: text, attributes: attr)
            let textSize = attrText.size()
            let textHeight = ceil(Double(textSize.height))
            let textWidth = ceil(Double(textSize.width))
            let textBox = CGRect(x: x, y: y, width: textWidth, height: textHeight)
            let textPath = CGPath(rect: textBox, transform: nil)
            let frameSetter = CTFramesetterCreateWithAttributedString(attrText)
            let frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, attrText.length), textPath, nil)
            CTFrameDraw(frame, ctx)
        }
    }
}

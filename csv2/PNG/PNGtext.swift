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

    private func propsAlignment(_ props: Properties) -> NSTextAlignment {
        switch props.cascade(.textAlign) ?? "" {
        case "end": return .right
        case "middle": return .center
        case "start": return .left
        default: return .natural
        }
    }

    private func propsFont(_ props: Properties) -> CTFont? {
        let family = props.cascade(.fontFamily) ?? "serif"
        let size = props.cascade(.fontSize)
        let font = CTFontCreateWithName(family as CFString, CGFloat(size), nil)

        return font
    }

    func plotText(x: Double, y: Double, text: String, props: Properties) {
        image.withCGContext { ctx in
            let colour = ColourTranslate.lookup(props.cascade(.fontColour) ?? "black")
            let style = NSMutableParagraphStyle()
            style.alignment = propsAlignment(props)
            let attr = [
                NSAttributedString.Key.foregroundColor: colour?.cgColor as Any,
                NSAttributedString.Key.font: propsFont(props) as Any,
                NSAttributedString.Key.paragraphStyle: style
            ] as [NSAttributedString.Key: Any]
            let attrText = NSAttributedString(string: text, attributes: attr)
            let line = CTLineCreateWithAttributedString(attrText)
            ctx.saveGState()
            ctx.textMatrix = .identity
            ctx.translateBy(x: 0.0, y: CGFloat(height))
            ctx.scaleBy(x: 1.0, y: -1.0)
            ctx.textPosition = CGPoint(x: x, y: height - y)
            CTLineDraw(line, ctx)
            ctx.restoreGState()
        }
    }
}

//
//  PNGtext.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-18.
//

import Foundation
import AppKit

extension PNG {

    func plotText(x: Double, y: Double, text: String, props: Properties) {
        image.withCGContext { _ in
            let style = NSMutableParagraphStyle()
            style.alignment = .center
            let colour = ColourTranslate.lookup(props.cascade(.colour) ?? "black")?.cgColor
            let font = NSFont(name: "Helvetica Bold", size: 14.0)
            let textFontAttributes = [
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: NSColor(cgColor: colour ?? .black)
                // NSParagraphStyleAttributeName: textStyle
            ]
            text.draw(at: CGPoint(x: x, y: y),
                      withAttributes: textFontAttributes as [NSAttributedString.Key: Any]
            )
        }
    }
}

//
//  PNGtext.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-18.
//

import Foundation
import AppKit
import CoreText

extension Transform {

    /// Convert Transform into CGAffineTransform

    var cgTransform: CGAffineTransform {
        CGAffineTransform(
            a: CGFloat(a), b: CGFloat(b), c: CGFloat(c), d: CGFloat(d), tx: CGFloat(e), ty: CGFloat(f)
        )
    }
}

extension PNG {

    /// Calculate x position for string
    /// - Parameters:
    ///   - x: specified x position
    ///   - props: properties including textAlign
    ///   - textWidth: width of text
    /// - Returns: modified x

    private func xPos(_ x: Double, _ props: Properties, _ textWidth: Double) -> Double {
        switch props.cascade(.textAlign) ?? "" {
        case "end": return x - textWidth
        case "middle": return x - textWidth/2.0
        case "start": return x
        default: return x
        }
    }

    /// Lookup font based on properties
    /// - Parameter props: properties
    /// - Returns: font or nil

    private func propsFont(_ props: Properties) -> CTFont? {
        let family = props.cascade(.fontFamily) ?? "serif"
        let size = CGFloat(props.cascade(.fontSize))
        var traits = CTFontSymbolicTraits()
        var fontDesc = CTFontDescriptorCreateWithNameAndSize(family as CFString, size)

        switch (props.bold, props.italic) {
        case (false, false): break
        case (true, false): traits = CTFontSymbolicTraits.traitBold
        case (false, true): traits = CTFontSymbolicTraits.traitItalic
        case (true, true): traits = CTFontSymbolicTraits.traitBold.union(CTFontSymbolicTraits.traitItalic)
        }
        if let symDesc = CTFontDescriptorCreateCopyWithSymbolicTraits(fontDesc, traits, traits) {
            fontDesc = symDesc
        }
        return CTFontCreateWithFontDescriptor(fontDesc, size, nil)
    }

    /// Draw the text at the place specified with the properties specified
    /// - Parameters:
    ///   - x: x position
    ///   - y: y position
    ///   - text: text to draw
    ///   - props: properties

    func plotText(x: Double, y: Double, text: String, props: Properties) {
        image.withCGContext { ctx in
            let colour = RGBAu8(props.cascade(.fontColour), or: .black)
            let attr = [
                NSAttributedString.Key.foregroundColor: colour.cgColor as Any,
                NSAttributedString.Key.font: propsFont(props) as Any
            ] as [NSAttributedString.Key: Any]
            let attrText = NSAttributedString(string: text, attributes: attr)
            let textWidth = Double(attrText.size().width)
            let line = CTLineCreateWithAttributedString(attrText)
            ctx.saveGState()
            if let transform = props.transform {
                ctx.concatenate(transform.cgTransform)
            }
            ctx.textMatrix = .identity
            ctx.translateBy(x: 0.0, y: CGFloat(height))
            ctx.scaleBy(x: 1.0, y: -1.0)
            ctx.textPosition = CGPoint(x: xPos(x, props, textWidth), y: height - y)
            CTLineDraw(line, ctx)
            ctx.restoreGState()
        }
    }
}

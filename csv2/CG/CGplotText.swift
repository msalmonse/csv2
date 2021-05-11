//
//  CGplotText.swift
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

/// Calculate x position for string
/// - Parameters:
///   - x: specified x position
///   - styles: properties including textAlign
///   - textWidth: width of text
/// - Returns: modified x

fileprivate func xPos(_ x: Double, _ styles: Styles, _ textWidth: Double) -> Double {
    switch styles.textAlign! {
    case "end": return x - textWidth
    case "middle": return x - textWidth/2.0
    case "start": return x
    default: return x
    }
}

/// Calculate y position for string
/// - Parameters:
///   - y: string bottom
///   - styles: text styles
///   - font: font to use
/// - Returns: the adjusted y position

fileprivate func yPos(_ y: Double, _ styles: Styles, _ font: CTFont?) -> Double {
    guard let font = font else { return y }
    switch styles.textBaseline {
    case "alphabetic": return y + Double(CTFontGetDescent(font))
    case "middle": return y + Double(CTFontGetAscent(font)) * 0.4
    default: return y
    }
}

/// Lookup font based on properties
/// - Parameter styles: properties
/// - Returns: font or nil

fileprivate func stylesFont(_ styles: Styles) -> CTFont? {
    let family = styles.fontFamily!
    let size = CGFloat(styles.fontSize)
    var traits = CTFontSymbolicTraits()
    var fontDesc = CTFontDescriptorCreateWithNameAndSize(family as CFString, size)

    switch (styles.options[.bold], styles.options[.italic]) {
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
///   - xy: the x and y position for the text
///   - text: text to draw
///   - styles: properties
///   - ctx: context to write to
///   - height: chart height

func cgPlotText(xy: Point, text: String, styles: Styles, to ctx: CGContext, height: Double) {
    let colour = RGBAu8(styles.fontColour, or: .black)
    let font = stylesFont(styles)
    let attr = [
        NSAttributedString.Key.foregroundColor: colour.cgColor as Any,
        NSAttributedString.Key.font: font as Any
    ] as [NSAttributedString.Key: Any]
    let attrText = NSAttributedString(string: text, attributes: attr)
    let textWidth = Double(attrText.size().width)
    let line = CTLineCreateWithAttributedString(attrText)
    ctx.saveGState()
    if let transform = styles.transform {
        ctx.concatenate(transform.cgTransform)
    }
    ctx.textMatrix = .identity
    ctx.translateBy(x: 0.0, y: CGFloat(height))
    ctx.scaleBy(x: 1.0, y: -1.0)
    ctx.textPosition = CGPoint(x: xPos(xy.x, styles, textWidth), y: height - yPos(xy.y, styles, font))
    CTLineDraw(line, ctx)
    ctx.restoreGState()
}

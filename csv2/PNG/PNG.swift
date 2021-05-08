//
//  PNG.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-18.
//

import Foundation
import AppKit

class PNG: Plotter {
    // image data
    var image: NSImage
    var ctx: CGContext

    // clipping rectangle
    var clipRect: CGRect? = nil

    // Plot settings
    let settings: Settings

    // Break out height and width for convenience
    let height: Double
    let width: Double

    init(_ settings: Settings) {
        self.settings = settings
        height = Double(settings.dim.height)
        width = Double(settings.dim.width)

        image = NSImage(size: NSSize(width: width, height: height))
        let bg = RGBAu8(settings.css.backgroundColour, or: .white)
        image.backgroundColor = NSColor(cgColor: bg.cgColor)!
        image.recache()
        image.lockFocus()
        ctx = NSGraphicsContext.current!.cgContext
        image.unlockFocus()
        ctx.scaleBy(x: 1.0, y: -1.0)
        ctx.translateBy(x: 0.0, y: -CGFloat(height))
    }
}

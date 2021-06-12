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
        height = settings.height
        width = settings.width

        image = NSImage(size: NSSize(width: width, height: height))
        let bg = settings.colourValue(.backgroundColour) ?? .white

        image.lockFocus()
        ctx = NSGraphicsContext.current!.cgContext
        image.unlockFocus()

        // flip coordinates
        ctx.scaleBy(x: 1.0, y: -1.0)
        ctx.translateBy(x: 0.0, y: -CGFloat(height))

        // set background
        ctx.setFillColor(bg.cgColor)
        ctx.fill(CGRect(x: 0.0, y: 0.0, width: width, height: height))
    }
}

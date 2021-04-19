//
//  PNG.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-18.
//

import Foundation
import SwiftImage

class PNG: Plotter {
    // image data
    var image: Image<PremultipliedRGBA<UInt8>>

    // Plot settings
    let settings: Settings

    // Break out height and width for convenience
    let height: Double
    let width: Double

    init(_ settings: Settings) {
        self.settings = settings
        height = Double(settings.dim.height)
        width = Double(settings.dim.width)

        let bg = ColourTranslate.lookup(settings.css.backgroundColour) ?? RGBAcolour.white
        let bgPixel = PremultipliedRGBA(bg.u32)
        image = Image<PremultipliedRGBA<UInt8>>(
            width: settings.dim.width, height: settings.dim.height,
            pixel: bgPixel
        )
    }
}

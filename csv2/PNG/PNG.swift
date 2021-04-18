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
    let image: Image<RGBA<UInt8>>

    // Plot settings
    let settings: Settings

    init(_ settings: Settings) {
        self.settings = settings

        image = Image<RGBA<UInt8>>(width: settings.dim.width, height: settings.dim.height, pixel: .clear)
    }
}

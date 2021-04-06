//
//  SVG/Colours.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-28.
//

import Foundation

class Colours {
    static private var next = -1
    static private let colourList = [
        "#ff0000",      // red
        "#008000",      // green
        "#ff00ff",      // magenta
        "#0000ff",      // blue
        "#dc143c",      // crimson
        "#f4a460",      // sandywood
        "#8b008b",      // darkmagenta
        "#ff8c00",      // darkorange
        "#b1000d",
        "#c0ffee",
        "#00ffff",      // aqua
        "#ffd700"       // gold
    ]

    static var all: [String] { colourList }

    static var count: Int { colourList.count }

    /// Get the colour in the sequence
    /// - Returns: next colour

    static func nextColour() -> String {
        next += 1
        if next >= colourList.count { next = 0 }
        return colourList[ next ]
    }

    /// Reset the colour sequence

    static func reset() {
        next = -1
    }
}

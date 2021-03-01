//
//  SvgColours.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-28.
//

import Foundation

extension SVG {
    class Colours {
        static private var next = -1
        static private let names = [
            "#ff0000",      // red
            "#ff00ff",      // magenta
            "#008000",      // green
            "#00ffff",      // aqua
            "#0000ff",      // blue
            "#dc143c",      // crimson
            "#ffd700",      // gold
            "#f4a460",      // sandywood
        ]
        
        static func nextColour() -> String {
            next += 1
            if next >= names.count { next = 0 }
            return names[ next ]
        }
    }
}

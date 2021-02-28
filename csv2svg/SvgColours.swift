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
            "rgb(255,0,0)",
            "rgb(255,127,0)",
            "rgb(0,255,0)",
            "rgb(0,0,255)",
            "rgb(127,255,0)",
            "rgb(0,255,127)"
        ]
        
        static func nextColour() -> String {
            next += 1
            if next >= names.count { next = 0 }
            return names[ next ]
        }
    }
}

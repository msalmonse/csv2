//
//  ColoursList.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-22.
//

import Foundation

extension SVG {
    func coloursListGen(_ step: Double) -> [String] {
        let xText = width/2.0
        let wRect = width/4.0
        let xRect = width/8.0
        let hRect = step * 0.8

        var y = step + step
        var style = Style(["font-size": (step * 0.8).f(2)])

        var result: [String] = [ xmlTag, svgTag ]

        for colour in Defaults.colours + Colours.all {
            style[["fill","stroke"]] = colour
            result.append(textTag(xText, y, colour, style))
            y += step
        }

        result.append(svgTagEnd)
        return result
    }
}

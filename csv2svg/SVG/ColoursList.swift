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
        let wRect = width/3.0
        let xRect = width/8.0
        let hRect = step * 0.8
        let rx = step/4.0

        var y = step + step
        var yRect: Double { y - hRect * 0.8 }
        var style = Style([
                "font-size": (step * 0.8).f(2),
                "alignment-baseline": "middle"
            ]
        )

        var result: [String] = [ xmlTag, svgTag ]
        if settings.backgroundColour != "" { result.append(background(settings.backgroundColour)) }

        for colour in Defaults.colours + Colours.all {
            style[["fill","stroke"]] = colour
            result.append(textTag(x: xText, y: y, text: colour, style: style))
            result.append(
                rectTag(x: xRect, y: yRect, width: wRect, height: hRect, style: style, rx: rx))
            y += step
        }

        result.append(svgTagEnd)
        return result
    }
}

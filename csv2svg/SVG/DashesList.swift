//
//  DashesList.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-23.
//

import Foundation

extension SVG {
    func dashesListGen(_ step: Double) -> [String] {
        var style = Style([:])

        var result: [String] = [ xmlTag, svgTag ]
        if settings.backgroundColour != "" { result.append(background(settings.backgroundColour)) }

        result.append(svgTagEnd)
        return result
    }
}

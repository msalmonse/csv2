//
//  DashesList.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-23.
//

import Foundation

extension SVG {
    func dashesListGen(_ step: Double) -> [String] {
        var props = PathProperties()
        props.colour = Defaults.colours.count > 0 ? Defaults.colours[0] : "black"
        props.dashed = true
        props.cssClass = "dashes"
        let style = Style(["stroke": props.colour])
        let dashCSS = "path.dashes { stroke: \(props.colour!); stroke-width: \((step/5.0).f(1))"

        let xLeft = width * 0.1
        let xRight = width * 0.6
        let xText = width * 0.65

        var y = step
        var yPath: Double { y - step/10.0 }

        var result: [String] = [ xmlTag, svgTag, cssStyle(extra: dashCSS)]

        for dash in Defaults.dashes + SVG.Dashes.all(width * 3.0) {
            y += step
            props.dash = dash
            let points = [ PathCommand.moveTo(x: xLeft, y: yPath), .horizTo(x: xRight) ]
            result.append(SVG.path(points, props, width: step/5.0, linecap: "butt"))
            result.append(textTag(x: xText, y: y, text: dash, style: style))
        }

        result.append(svgTagEnd)
        return result
    }
}

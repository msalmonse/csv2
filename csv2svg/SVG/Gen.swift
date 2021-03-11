//
//  SVG/Gen.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-10.
//

import Foundation

extension SVG {

    /// Generate the defs element
    /// - Returns: the defs elements as a list

    func svgDefs() -> [String] {
        // Make plottable a bit bigger so that shapes aren't clipped
        let h = (plotEdges.bottom - plotEdges.top + shapeWidth * 4.0).f(1)
        let w = (plotEdges.right - plotEdges.left + shapeWidth * 4.0).f(1)
        let x = (plotEdges.left - shapeWidth * 2.0).f(1)
        let y = (plotEdges.top - shapeWidth * 2.0).f(1)
        var result = ["<defs>"]
        result.append("<clipPath id=\"plotable\">")
        result.append("<rect x=\"\(x)\" y=\"\(y)\" width=\"\(w)\" height=\"\(h)\" />")
        result.append("</clipPath>")
        result.append("</defs>")

        return result
    }

    /// Generate an SVG group with the plot lines
    /// - Parameter ts: TransScale object
    /// - Returns: Array of SVG elements

    func svgLineGroup(_ ts: TransScale) -> [String] {
        var result: [String] = []
        result.append("<g clip-path=\"url(#plotable)\" >")
        result.append(contentsOf: settings.inColumns ? columnPlot(ts) : rowPlot(ts))
        result.append("</g>")

        return result
    }

    /// Generate an svg document
    /// - Returns: array of svg elements

    func gen() -> [String] {
        let ts = TransScale(from: dataEdges, to: plotEdges)

        var result: [String] = [ xmlTag, svgTag, comment ]
        result.append(contentsOf: svgDefs())
        result.append(svgAxes(ts))
        if settings.xTick >= 0 { result.append(svgXtick(ts)) }
        if settings.yTick >= 0 { result.append(svgYtick(ts)) }
        result.append(contentsOf: svgLineGroup(ts))
        if settings.xTitle != "" {
            result.append(xTitle(settings.xTitle, x: plotEdges.hMid, y: positions.xTitleY))
        }
        if settings.yTitle != "" {
            result.append(yTitle(settings.yTitle, x: positions.yTitleX, y: plotEdges.vMid))
        }
        result.append(svgLegends(Double(settings.width)/2.0, positions.legendY))
        if settings.title != "" { result.append(svgTitle()) }
        result.append(svgTagEnd)

        return result
    }
}

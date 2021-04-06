//
//  SVGplotter.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-04-06.
//

import Foundation

extension SVG {

    func plotHead() -> String {
        var result = [ xmlTag, svgTag ]
        if settings.svg.comment { result.append(comment)}

        return result.joined(separator: "\n")
    }

    /// Create a plot command from a number of PathCommand's
    /// - Parameters:
    ///   - points: array of points to plot
    ///   - props: path properties
    /// - Returns: plot command string

    func plotPath(_ points: [PathCommand], props: Properties) -> String {
        var result = [ "<path" ]
        if let cssClass = props.cssClass { result.append("class=\"\(cssClass)\"") }
        result.append("d=\"")
        result.append(contentsOf: points.map { $0.command() })
        result.append("\" />")

        return result.joined(separator: " ")
    }

    /// Add text to the SVG
    /// - Parameters:
    ///   - x: x position
    ///   - y: y position
    ///   - text: text to add
    ///   - props: text properties
    /// - Returns: text string
    
    func plotText(x: Double, y: Double, text: String, props: Properties) -> String {
        return textTag(x: x, y: y, text: text, cssClass: props.cascade(.cssClass)!)
    }
}

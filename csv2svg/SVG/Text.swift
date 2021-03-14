//
//  SVG/Text.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-28.
//

import Foundation

extension SVG {

    /// Add title to the svg
    /// - Returns: String to display title

    func svgTitle() -> String {
        let x = width/2.0
        let y = positions.titleY
        let t = settings.title
        return """
            <text x="\(x.f(1))" y="\(y.f(1))" style="text-anchor: middle; font-size: \(titlePX)">\(t)</text>
            """
    }

    /// Add title to the x axis
    /// - Returns: String to display title

    func xTitle(_ label: String, x: Double, y: Double) -> String {
        return """
            <text x="\(x)" y="\(y)" style="text-anchor: middle; font-size: \(axesPX)">\(label)</text>
            """
    }

    /// Add title to the y axis
    /// - Returns: String to display title

    func yTitle(_ label: String, x: Double, y: Double) -> String {
        return """
            <text x="\(x)" y="\(y)" style="writing-mode: tb; text-anchor: middle; font-size: \(axesPX)">\(label)</text>
            """
    }

    /// Add legends to an SVG
    /// - Parameters:
    ///   - x: mid point of legends
    ///   - y: baseline height
    /// - Returns: Text string with all legends

    func svgLegends(_ x: Double, _ y: Double) -> String {
        let iMax = settings.inColumns ? csv.colCt : csv.rowCt
        var legends = [
            "<text x=\"\(x.f(2))\" y=\"\(y.f(2))\" ",
            "style=\"text-anchor: middle; font-size: \(legendPX)\">"
        ]

        for i in 0..<iMax where i != index {
            let text = names[i]
            let colour = colours[i]
            legends.append("<tspan dx=\"\(legendPX)\" fill=\"\(colour)\">\(text)</tspan>")
        }
        legends.append("</text>")

        return legends.joined()
    }

    /// Format a value suitable to be used as a label
    /// - Parameters:
    ///   - value: value to format
    ///   - eForce: force e format
    /// - Returns: formatted string

    func label(_ value: Double, _ eForce: Bool = false) -> String {
        if eForce { return value.e(2) }
        let v = abs(value)
        if v >= 10000000 { return value.e(2) }
        if v < 0.01 { return value.e(2) }
        if v < 10 { return value.f(2) }
        if v < 100 { return value.f(1) }
        return value.f(0)
    }

    /// Generate a text string for an x label
    /// - Parameters:
    ///   - label: text to show
    ///   - x: x position
    ///   - y: y position
    /// - Returns: text string

    func xLabel(_ label: String, x: Double, y: Double) -> String {
        return """
            <text x="\(x.f(2))" y="\(y.f(2))" style="text-anchor: middle; font-size: \(labelPX)">\(label)</text>
            """
    }

    /// Generate a text string for a y label
    /// - Parameters:
    ///   - label: text to show
    ///   - x: x position
    ///   - y: y position
    /// - Returns: text string

    // swiftlint:disable line_length

    func yLabel(_ label: String, x: Double, y: Double) -> String {
        return """
            <text x="\(x.f(2))" y="\(y.f(2))" dominant-baseline="middle" style="text-anchor: end; font-size: \(labelPX)">\(label)</text>
            """
    }
}

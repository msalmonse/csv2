//
//  SvgText.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-28.
//

import Foundation

extension SVG {

    /// Add title to the svg
    /// - Returns: String to display title
    
    func svgTitle() -> String {
        let x = settings.width/2
        let y = settings.height - 5
        let t = settings.title 
        return """
            <text x="\(x)" y="\(y)" style="text-anchor: middle; font-size: 25px">\(t)</text>
            """
    }
    
    /// Add legends to an SVG
    /// - Parameters:
    ///   - x: mid point of legends
    ///   - y: baseline height
    ///   - size: font size
    /// - Returns: Text string with all legends

    func svgLegends(_ x: Double, _ y: Double, size: Int = 13) -> String {
        let iMax = settings.inColumns ? csv.colCt : csv.rowCt
        var legends = [
            "<text x=\"\(x)\" y=\"\(y)\" style=\"text-anchor: middle; font-size: \(size)px\">"
        ]
        
        for i in 0..<iMax {
            if i != index {
                let text = names[i]
                let colour = colours[i]
                legends.append("<tspan dx=\"\(size)px\" fill=\"\(colour)\">\(text)</tspan>")
            }
        }
        legends.append("</text>")
        
        return legends.joined()
    }
    
    /// Format a value suitable to be used as a label
    /// - Parameter value: value to format
    /// - Returns: formatted string

    func label(_ value: Double) -> String {
        return String(format: "%.0f", value)
    }

    /// Generate a text string for an x label
    /// - Parameters:
    ///   - label: text to show
    ///   - x: x position
    ///   - y: y position
    ///   - size: font size
    /// - Returns: text string
    func xLabel(_ label: String, x: Double, y: Double, size: Int = 10) -> String {
        return """
            <text x="\(x)" y="\(y)" style="text-anchor: middle; font-size: \(size)px">\(label)</text>
            """
    }

    /// Generate a text string for a y label
    /// - Parameters:
    ///   - label: text to show
    ///   - x: x position
    ///   - y: y position
    ///   - size: font size
    /// - Returns: text string
    func yLabel(_ label: String, x: Double, y: Double, size: Int = 10) -> String {
        return """
            <text x="\(x)" y="\(y)" dominant-baseline="middle" style="text-anchor: end; font-size: \(size)px">\(label)</text>
            """
    }
}

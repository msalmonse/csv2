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
        return textTag(x, y, settings.title, styles["title"]!)
    }

    /// Add sub title to the svg
    /// - Returns: String to display sub title

    func svgSubTitle() -> String {
        let x = width/2.0
        let y = positions.subTitleY
        return textTag(x, y, settings.subTitle, styles["subTitle"]!)
    }

    /// Add title to the x axis
    /// - Returns: String to display title

    func xTitle(_ label: String, x: Double, y: Double) -> String {
        return textTag(x, y, label, styles["xTitle"]!)
    }

    /// Add title to the y axis
    /// - Returns: String to display title

    func yTitle(_ label: String, x: Double, y: Double) -> String {
        // Rotate () rotates around 0,0 hence we need to start at -x,-y
        return textTag(-x, -y, label, styles["yTitle"]!, extra: "transform=\"rotate(180)\"")
    }

    /// Format a value suitable to be used as a label
    /// - Parameters:
    ///   - value: value to format
    ///   - eForce: force e format
    /// - Returns: formatted string

    func label(_ value: Double, _ f0Force: Bool = false) -> String {
        let v = abs(value)
        if v >= 10000000 { return value.e(2) }
        if v < 0.01 { return value.e(2) }
        if f0Force { return value.f(0) }
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
        return textTag(x, y, label, styles["xLabel"]!)
    }

    /// Generate a text string for a y label
    /// - Parameters:
    ///   - label: text to show
    ///   - x: x position
    ///   - y: y position
    /// - Returns: text string

    func yLabel(_ label: String, x: Double, y: Double) -> String {
        return textTag(x, y, label, styles["yLabel"]!)
    }

    /// Generate x and y string
    /// - Parameters:
    ///   - x: x value
    ///   - y: y value
    ///   - precission: precission in string
    /// - Returns: x and y string

    func xy(_ x: Double, _ y: Double, _ precission: Int = 2) -> String {
        return """
            x="\(x.f(precission))" y="\(y.f(precission))"
            """
    }

    /// Generate a <text> string
    /// - Parameters:
    ///   - x: x position
    ///   - y: y position
    ///   - text: text to display
    ///   - style: tag style
    ///   - extra: any extra options for <text>
    /// - Returns: <text> string

    func textTag(_ x: Double, _ y: Double, _ text: String, _ style: Style, extra: String = "") -> String {
        return "<text \(xy(x,y)) \(style) \(extra)>\(text)</text>"
    }
}

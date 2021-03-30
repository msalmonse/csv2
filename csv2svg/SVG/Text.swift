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

    func titleText() -> String {
        let x = width/2.0
        let y = positions.titleY
        return textTag(x: x, y: y, text: settings.svg.title, cssClass: "title")
    }

    /// Add sub title to the svg
    /// - Returns: String to display sub title

    func subTitleText() -> String {
        let x = width/2.0
        let y = positions.subTitleY
        return textTag(x: x, y: y, text: subTitle, cssClass: "subtitle")
    }

    /// Add title to the x axis
    /// - Returns: String to display title

    func xTitleText(_ label: String, x: Double, y: Double) -> String {
        return textTag(x: x, y: y, text: label, cssClass: "xtitle")
    }

    /// Add title to the y axis
    /// - Returns: String to display title

    func yTitleText(_ label: String, x: Double, y: Double) -> String {
        // Rotate () rotates around 0,0 hence we need to start at -x,-y
        return textTag(
            x: -x, y: -y, text: label,
            cssClass: "ytitle",
            extra: "transform=\"rotate(180)\""
        )
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

    func xLabelText(_ label: String, x: Double, y: Double) -> String {
        return textTag(x: x, y: y, text: label, cssClass: "xlabel")
    }

    /// Generate a text string for a y label
    /// - Parameters:
    ///   - label: text to show
    ///   - x: x position
    ///   - y: y position
    /// - Returns: text string

    func yLabelText(_ label: String, x: Double, y: Double) -> String {
        return textTag(x: x, y: y, text: label, cssClass: "ylabel")
    }

    /// Generate width and height string
    /// - Parameters:
    ///   - w: width value
    ///   - h: height value
    ///   - precission: precission in string
    /// - Returns: width and height string

    func wh(_ w: Double, _ h: Double, _ precision: Int = 2) -> String {
        return """
            width="\(w.f(precision))" height="\(h.f(precision))"
            """
    }

    /// Generate x and y string
    /// - Parameters:
    ///   - x: x value
    ///   - y: y value
    ///   - precission: precission in string
    /// - Returns: x and y string

    func xy(_ x: Double, _ y: Double, _ precision: Int = 2) -> String {
        return """
            x="\(x.f(precision))" y="\(y.f(precision))"
            """
    }

    /// Generate a <text> string
    /// - Parameters:
    ///   - x: x position
    ///   - y: y position
    ///   - text: text to display
    ///   - cssClass: text tag class
    ///   - extra: any extra options for <text>
    /// - Returns: <text> string

    func textTag(
        x: Double, y: Double,
        text: String,
        cssClass: String,
        extra: String = ""
    ) -> String {
        return "<text \(xy(x,y)) class=\"\(cssClass)\" \(extra)>\(text)</text>"
    }
}

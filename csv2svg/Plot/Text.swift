//
//  SVG/Text.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-28.
//

import Foundation

extension Plot {

    /// Add title to the svg
    /// - Returns: String to display title

    func titleText() -> String {
        let x = width/2.0
        let y = positions.titleY
        return plotter.plotText(x: x, y: y, text: settings.svg.title, props: propsList.title)
    }

    /// Add sub title to the svg
    /// - Returns: String to display sub title

    func subTitleText() -> String {
        let x = width/2.0
        let y = positions.subTitleY
        return plotter.plotText(x: x, y: y, text: subTitle, props: propsList.subTitle)
    }

    /// Add title to the x axis
    /// - Returns: String to display title

    func xTitleText(_ label: String, x: Double, y: Double) -> String {
        return plotter.plotText(x: x, y: y, text: label, props: propsList.xTitle)
    }

    /// Add title to the y axis
    /// - Returns: String to display title

    func yTitleText(_ label: String, x: Double, y: Double) -> String {
        // Rotate () rotates around 0,0 hence we need to start at -x,-y
        return plotter.plotText(x: -x, y: -y, text: label, props: propsList.yTitle)
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
        return plotter.plotText(x: x, y: y, text: label, props: propsList.xLabel)
    }

    /// Generate a text string for a y label
    /// - Parameters:
    ///   - label: text to show
    ///   - x: x position
    ///   - y: y position
    /// - Returns: text string

    func yLabelText(_ label: String, x: Double, y: Double) -> String {
        return plotter.plotText(x: x, y: y, text: label, props: propsList.yLabel)
    }
}

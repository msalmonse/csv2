//
//  SVG/Text.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-28.
//

import Foundation

extension Plot {

    /// Check for subtitle
    /// - Returns: subtitle if found

    func subTitleLookup() -> String? {
        let subTitle = settings.stringValue(.subTitle)
        if subTitle.hasContent {
            return subTitle
        }
        let subTitleHeader = settings.intValue(.subTitleHeader)
        if subTitleHeader >= 0 {
            return csv.subTitleText(header: subTitleHeader)
        }
        return nil
    }

    /// Add title to the svg

    func titleText() {
        let x = plotPlane.hMid
        let y = positions.titleY
        plotter.plotText(x: x, y: y, text: settings.stringValue(.title), styles: stylesList.title)
    }

    /// Add sub title to the svg

    func subTitleText(_ subTitle: String) {
        let x = plotPlane.hMid
        let y = positions.subTitleY
        plotter.plotText(x: x, y: y, text: subTitle, styles: stylesList.subTitle)
    }

    /// Add title to the x axis

    func xTitleText(_ label: String, x: Double, y: Double) {
        plotter.plotText(x: x, y: y, text: label, styles: stylesList.xTitle)
    }

    /// Add title to the y axis

    func yTitleText(_ label: String, x: Double, y: Double) {
        let styles = stylesList.yTitle
            .with(\.transform, of: Transform.rotateAround(x: x, y: y, sin: 1.0, cos: 0.0))
        plotter.plotText(x: x, y: y, text: label, styles: styles)
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

    func xLabelText(_ label: String, x: Double, y: Double) {
        plotter.plotText(x: x, y: y, text: label, styles: stylesList.xLabel)
    }

    /// Generate a text string for a y label
    /// - Parameters:
    ///   - label: text to show
    ///   - x: x position
    ///   - y: y position

    func yLabelText(_ label: String, x: Double, y: Double) {
        plotter.plotText(x: x, y: y, text: label, styles: stylesList.yLabel)
    }
}

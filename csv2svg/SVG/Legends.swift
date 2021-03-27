//
//  Legends.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-17.
//

import Foundation

extension SVG {

    /// Draw the rectangle under the legends
    /// - Parameters:
    ///   - top: rectangle top
    ///   - bottom: rectangle bottom
    ///   - left: rectangle left
    ///   - right: rectangle right
    /// - Returns: rectangle string

    private func legendBG(_ top: Double, _ bottom: Double, _ left: Double, right: Double) -> String {
        let h = bottom - top
        let w = right - left
        let x = left
        let y = top
        return rectTag(x: x, y: y, width: w, height: h, extra: "class=\"legends\"", rx: strokeWidth * 3.0)
    }

    /// Draw the shape used for a scatter plot
    /// - Parameters:
    ///   - x: x position
    ///   - y: y position
    ///   - props: path properties
    /// - Returns: path string

    private func scatteredLine(
        _ x: Double, _ y: Double,
        _ props: PathProperties
    ) -> String {
        guard props.shape != nil else { return "" }
        return SVG.path([
            PathCommand.moveTo(x: x, y: y),
            props.shape!.pathCommand(w: shapeWidth)
        ],
        cssClass: props.cssClass!, width: strokeWidth)
    }

    /// Draw a line for plots with data points
    /// - Parameters:
    ///   - left: left end of line
    ///   - mid: shape position
    ///   - right: right end of line
    ///   - y: y position
    ///   - props: path properties
    /// - Returns: path string

    private func pointedLine(
        _ left: Double, _ mid: Double, _ right: Double, _ y: Double,
        _ props: PathProperties
    ) -> String {
        guard props.shape != nil else { return "" }
        return SVG.path([
            PathCommand.moveTo(x: left, y: y),
            .horizTo(x: mid),
            props.shape!.pathCommand(w: shapeWidth),
            .horizTo(x: right)
        ],
        cssClass: props.cssClass!, width: strokeWidth)
    }

    /// Draw a plain line
    /// - Parameters:
    ///   - left: left end of line
    ///   - right: right end of line
    ///   - y: y position
    ///   - props: path properties
    /// - Returns: path string

    private func plainLine(
        _ left: Double, _ right: Double, _ y: Double,
        _ props: PathProperties
    ) -> String {
        return SVG.path([
            PathCommand.moveTo(x: left, y: y),
            .horizTo(x: right)
        ],
        cssClass: props.cssClass!, width: strokeWidth)
    }

    /// Shorten a string if required
    /// - Parameters:
    ///   - text: text to be shortened
    ///   - len: maximum length without shortening
    /// - Returns: shortened? string

    private func shortened(_ text: String, len: Int = 10) -> String {
        if text.count <= len { return text }
        return text.prefix(len - 1) + "…"
    }

    /// Add legends to an SVG
    /// - Returns: Text string with all legends

    func legend() -> String {
        if positions.legendX >= width { return "<!-- Legends suppressed -->" }
        let x = positions.legendX
        let xLeft = x + settings.legendSize/2.0
        let xRight = width - settings.legendSize/2.0
        let xMid = (xLeft + xRight)/2.0
        var y = positions.legendY
        let yStep = settings.legendSize * 1.5
        var legends: [String] = ["", textTag(x: x, y: y, text: "Legends:", cssClass: "legends")]
        y += yStep/2.0

        for i in 0..<propsList.count where i != index && propsList[i].included {
            y += yStep
            if y > height - yStep - yStep {
                legends.append(textTag(x: xLeft, y: y, text: "…", cssClass: "legends"))
                break
            }
            let propsi = propsList[i]
            let text = shortened(propsi.name!)
            legends.append(textTag(x: xLeft, y: y, text: text, cssClass: "legends \(propsi.cssClass!)"))
            let lineY = y + yStep/2.0
            if propsi.dashed || propsi.pointed || propsi.scattered { y += yStep }
            switch (propsi.dashed, propsi.pointed, propsi.scattered) {
            case (_,_,true):
                legends.append(scatteredLine(xMid - shapeWidth, lineY, propsi))
            case (_,true,false):
                legends.append(pointedLine(xLeft, xMid, xRight, lineY, propsi))
            case (true,_,false):
                legends.append(plainLine(xLeft, xRight, lineY, propsi))
            default: break
            }
        }

        legends[0] = legendBG(positions.legendY - yStep, y + yStep, x - settings.legendSize, right: width)

        return legends.joined(separator: "\n")
    }
}

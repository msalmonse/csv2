//
//  Legends.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-17.
//

import Foundation

extension Plot {

    /// Draw the rectangle under the legends
    /// - Parameters:
    ///   - top: rectangle top
    ///   - bottom: rectangle bottom
    ///   - left: rectangle left
    ///   - right: rectangle right
    /// - Returns: rectangle string

    private func legendBG(_ top: Double, _ bottom: Double, _ left: Double, right: Double) -> String {
        let plane = Plane(top: top, bottom: bottom, left: left, right: right)
        return plotter.plotRect(plane, rx: strokeWidth * 3.0, props: propsList.legend)
    }

    /// Draw the shape used for a scatter plot
    /// - Parameters:
    ///   - x: x position
    ///   - y: y position
    ///   - props: path properties
    /// - Returns: path string

    private func scatteredLine(
        _ x: Double, _ y: Double,
        _ props: Properties
    ) -> String {
        guard props.shape != nil else { return "" }
        return plotter.plotPath([
                PathCommand.moveTo(x: x, y: y),
                props.shape!.pathCommand(w: shapeWidth)
            ],
            props: props
        )
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
        _ props: Properties
    ) -> String {
        guard props.shape != nil else { return "" }
        return plotter.plotPath([
                PathCommand.moveTo(x: left, y: y),
                .horizTo(x: mid),
                props.shape!.pathCommand(w: shapeWidth),
                .horizTo(x: right)
            ],
            props: props
        )
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
        _ props: Properties
    ) -> String {
        return plotter.plotPath([
                PathCommand.moveTo(x: left, y: y),
                .horizTo(x: right)
            ],
            props: props
        )
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
        if positions.legendLeftX >= width { return "<!-- Legends suppressed -->" }
        let x = positions.legendLeftX
        let xLeft = x + legendSize/2.0
        let xRight = positions.legendRightX - legendSize/2.0
        let xMid = (xLeft + xRight)/2.0
        let yStep = legendSize * 1.5
        var y = positions.legendY + yStep
        var legends: [String] = [
            "",         // reserved for rect below
            plotter.plotText(x: x, y: y, text: "Legends:", props: propsList.legendHeadline)
        ]
        y += yStep/2.0
        let plotProps = propsList.plots

        for i in 0..<plotProps.count where i != index && plotProps[i].included {
            y += yStep
            if y > height - yStep - yStep {
                legends.append(plotter.plotText(x: xLeft, y: y, text: "…", props: propsList.legend))
                break
            }
            var propsi = plotProps[i]
            let text = shortened(propsi.name!)
            propsi.cssClass = propsi.cssClass! + " legend"
            legends.append(plotter.plotText(x: xLeft, y: y, text: text, props: propsi))
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

        legends[0] =
            legendBG(positions.legendY, y + yStep, x - legendSize, right: positions.legendRightX)

        return legends.joined(separator: "\n")
    }
}
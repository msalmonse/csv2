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

    private func legendBG(_ top: Double, _ bottom: Double, _ left: Double, right: Double) {
        let plane = Plane(top: top, bottom: bottom, left: left, right: right)
        plotter.plotRect(plane, rx: strokeWidth * 3.0, props: propsList.legendBG)
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
    ) {
        guard props.shape != nil else { return }
        plotter.plotPath([
                PathComponent.moveTo(x: x, y: y),
                props.shape!.pathCommand(w: shapeWidth)
            ],
            props: props, fill: false
        )
    }

    /// Draw a line for plots with data points
    /// - Parameters:
    ///   - left: left end of line
    ///   - mid: shape position
    ///   - right: right end of line
    ///   - y: y position
    ///   - props: path properties

    private func pointedLine(
        _ left: Double, _ mid: Double, _ right: Double, _ y: Double,
        _ props: Properties
    ) {
        guard props.shape != nil else { return }
        plotter.plotPath([
                PathComponent.moveTo(x: left, y: y),
                .horizTo(x: mid),
                props.shape!.pathCommand(w: shapeWidth),
                .horizTo(x: right)
            ],
            props: props, fill: false
        )
    }

    /// Draw a plain line
    /// - Parameters:
    ///   - left: left end of line
    ///   - right: right end of line
    ///   - y: y position
    ///   - props: path properties

    private func plainLine(
        _ left: Double, _ right: Double, _ y: Double,
        _ props: Properties
    ) {
        return plotter.plotPath([
                PathComponent.moveTo(x: left, y: y),
                .horizTo(x: right)
            ],
            props: props, fill: false
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

    func legend() {
        if positions.legendLeftX >= width { return }
        let x = positions.legendLeftX
        let xLeft = x + legendSize/2.0
        let xRight = positions.legendRightX - legendSize/2.0
        let xMid = (xLeft + xRight)/2.0
        let yStep = legendSize * 1.5
        var y = positions.legendY + yStep
        y += yStep/2.0
        let plotProps = propsList.plots

        plotter.plotText(x: x, y: y, text: "Legends:", props: propsList.legendHeadline)

        for i in plotProps.indices where i != index && plotProps[i].included {
            y += yStep
            if y > height - yStep - yStep {
                plotter.plotText(x: xLeft, y: y, text: "…", props: propsList.legend)
                break
            }
            var propsi = plotProps[i]
            let text = shortened(propsi.name!)
            propsi.cssClass = propsi.cssClass! + " legend"
            propsi.fontSize = propsList.legend.fontSize
            propsi.textAlign = propsList.legend.textAlign
            plotter.plotText(x: xLeft, y: y, text: text, props: propsi)
            let lineY = y + yStep/2.0
            if propsi.dashed || propsi.pointed || propsi.scattered { y += yStep }
            switch (propsi.dashed, propsi.pointed, propsi.scattered) {
            case (_,_,true): scatteredLine(xMid - shapeWidth, lineY, propsi)
            case (_,true,false): pointedLine(xLeft, xMid, xRight, lineY, propsi)
            case (true,_,false): plainLine(xLeft, xRight, lineY, propsi)
            default: break
            }
        }

        legendBG(positions.legendY, y + yStep, x - legendSize, right: positions.legendRightX)
    }
}

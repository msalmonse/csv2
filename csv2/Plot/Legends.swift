//
//  Legends.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-17.
//

import Foundation

extension Plot {

    /// Draw the shape used for a scatter plot
    /// - Parameters:
    ///   - x: x position
    ///   - y: y position
    ///   - styles: path properties

    private func scatteredLine(
        _ x: Double, _ y: Double,
        _ styles: Styles
    ) {
        guard styles.shape != nil else { return }
        plotter.plotPath(Path([
                PathComponent.moveTo(xy: Point(x: x, y: y)),
                styles.shape!.pathComponent(w: shapeWidth)
            ]),
            styles: styles, fill: false
        )
    }

    /// Draw a line for plots with data points
    /// - Parameters:
    ///   - left: left end of line
    ///   - mid: shape position
    ///   - right: right end of line
    ///   - y: y position
    ///   - styles: path properties

    private func pointedLine(
        _ left: Double, _ mid: Double, _ right: Double, _ y: Double,
        _ styles: Styles
    ) {
        guard styles.shape != nil else { return }
        plotter.plotPath(Path([
                PathComponent.moveTo(xy: Point(x: left, y: y)),
                .horizTo(x: mid),
                styles.shape!.pathComponent(w: shapeWidth),
                .horizTo(x: right)
            ]),
            styles: styles, fill: false
        )
    }

    /// Draw a plain line
    /// - Parameters:
    ///   - left: left end of line
    ///   - right: right end of line
    ///   - y: y position
    ///   - styles: path properties

    private func plainLine(
        _ left: Double, _ right: Double, _ y: Double,
        _ styles: Styles
    ) {
        return plotter.plotPath(Path([
                PathComponent.moveTo(xy: Point(x: left, y: y)),
                .horizTo(x: right)
            ]),
            styles: styles, fill: false
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
        let plotStyles = stylesList.plots

        plotter.plotText(x: x, y: y, text: "Legends:", styles: stylesList.legendHeadline)

        for i in plotStyles.indices where i != index && plotStyles[i].options[.included] {
            y += yStep
            if y > height - yStep - yStep {
                plotter.plotText(x: xLeft, y: y, text: "…", styles: stylesList.legend)
                break
            }
            var style = plotStyles[i]
            let text = shortened(style.name!)
            style.fontSize = stylesList.legend.fontSize
            style.textAlign = stylesList.legend.textAlign
            plotter.plotText(x: xLeft, y: y, text: text, styles: style)
            let lineY = y + yStep/2.0
            let options = style.options
            if options.isAny(of: [.dashed, .pointed, .scattered]) {
                y += yStep
                if  options[.scattered] {
                    scatteredLine(xMid - shapeWidth, lineY, style)
                } else if options[.pointed] {
                    pointedLine(xLeft, xMid, xRight, lineY, style)
                } else {
                    plainLine(xLeft, xRight, lineY, style)
                }
            }
        }

        let rectPlane = Plane(
                top: positions.legendY, bottom: y + yStep,
                left: x - legendSize, right: positions.legendRightX
            )
        plotter.plotPath(rectPath(rectPlane, rx: strokeWidth * 3.0), styles: stylesList.legendBox, fill: false)
    }
}

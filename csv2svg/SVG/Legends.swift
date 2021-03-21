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

    private func bgRect(_ top: Double, _ bottom: Double, _ left: Double, right: Double) -> String {
        let h = bottom - top
        let w = right - left
        let x = left
        let y = top
        return """
            <rect
                \(xy(x,y)) height="\(h.f(1))" width="\(w.f(1))" rx="\(strokeWidth * 3.0)"
                fill="silver" opacity=".1" stroke="black" stroke-width="1.5"
            />
            """
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
        return SVG.svgPath([
            PathCommand.moveTo(x: x, y: y),
            props.shape!.pathCommand(w: shapeWidth)
        ],
        props, width: strokeWidth)
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
        return SVG.svgPath([
            PathCommand.moveTo(x: left, y: y),
            .horizTo(x: mid),
            props.shape!.pathCommand(w: shapeWidth),
            .horizTo(x: right)
        ],
        props, width: strokeWidth)
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
        return SVG.svgPath([
            PathCommand.moveTo(x: left, y: y),
            .horizTo(x: right)
        ],
        props, width: strokeWidth)
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

    func svgLegends() -> String {
        if positions.legendX >= width { return "<!-- Legends suppressed -->" }
        let x = positions.legendX
        let xLeft = x + settings.legendSize/2.0
        let xRight = width - settings.legendSize/2.0
        let xMid = (xLeft + xRight)/2.0
        var y = positions.legendY
        let yStep = settings.legendSize * 1.5
        var style = styles["legends"]!
        var legends: [String] = ["", textTag(x, y, "Legends:", style)]
        style["font-weight"] = nil
        y += yStep/2.0

        for i in 0..<props.count where i != index && props[i].included {
            y += yStep
            if y > height - yStep - yStep {
                style[["fill","stroke"]] = "black"
                legends.append(textTag(xLeft, y, "…", style))
                break
            }
            let propi = props[i]
            let text = shortened(propi.name!)
            let colour = propi.colour!
            style[["fill","stroke"]] = colour
            legends.append(textTag(xLeft, y, text, style))
            let lineY = y + yStep/2.0
            if propi.dashed || propi.pointed || propi.scattered { y += yStep }
            switch (propi.dashed, propi.pointed, propi.scattered) {
            case (_,_,true):
                legends.append(scatteredLine(xMid - shapeWidth, lineY, propi))
            case (_,true,false):
                legends.append(pointedLine(xLeft, xMid, xRight, lineY, propi))
            case (true,_,false):
                legends.append(plainLine(xLeft, xRight, lineY, propi))
            default: break
            }
        }

        legends[0] = bgRect(positions.legendY - yStep, y + yStep, x - settings.legendSize, right: width)

        return legends.joined(separator: "\n")
    }
}

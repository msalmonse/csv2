//
//  JSplotter.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-09.
//

import Foundation

extension Canvas {

    /// Plot a group of lines with clipping
    /// - Parameters:
    ///   - plotPlane: the plottable area
    ///   - lines: the plot lines
    /// - Returns: the clipped lines

    func plotGroup(plotPlane: Plane, lines: String) -> String {
        let shapeWidth = settings.css.shapeWidth
        // Make plottable a bit bigger so that shapes aren't clipped
        let left = (plotPlane.left - shapeWidth * 2.0)
        let top = (plotPlane.top - shapeWidth * 2.0)
        let bottom = (plotPlane.bottom + shapeWidth * 4.0)
        let right = (plotPlane.right + shapeWidth * 4.0)
        let opacity = settings.css.opacity
        var result = [""]
        result.append("ctx.save()")
        result.append("")
        result.append("ctx.beginPath()")
        result.append("ctx.moveTo(\(left.f(1)), \(top.f(1)))")
        result.append("ctx.lineTo(\(right.f(0)), \(top.f(1)))")
        result.append("ctx.lineTo(\(right.f(0)), \(bottom.f(1)))")
        result.append("ctx.lineTo(\(left.f(0)), \(bottom.f(1)))")
        result.append("ctx.clip()")
        result.append("ctx.globalAlpha = \(opacity.f(3))")
        result.append(lines)
        result.append("")
        result.append("ctx.restore()")
        result.append("ctx.globalAlpha = 1.0")
        result.append("ctx.beginPath()")

        return result.joined(separator: "\n    ")
    }

    /// Prepare for plotting
    /// - Parameters:
    ///   - positions: the positioning of varoius points
    ///   - plotPlane: the plottable plane
    ///   - propsList: a list of properties
    /// - Returns: the JS to start

    func plotHead(positions: Positions, plotPlane: Plane, propsList: PropertiesList) -> String {
        let id = settings.plotter.canvasID
        let name = "canvas_\(id)"
        let url = settings.plotter.logoURL
        let logo = url.isEmpty ? "" : drawLogo(
            url: url, left: positions.logoX, top: positions.logoY,
            width: settings.plotter.logoWidth, height: settings.plotter.logoHeight
        )
        return """
            const \(name) = document.getElementById('\(id)');
            if (\(name).getContext) {
                const ctx = \(name).getContext('2d');

            \(logo)
            """
    }

    /// The finish of the plotting
    /// - Returns: JS to finish

    func plotTail() -> String {
        return "}"
    }

    /// Write text to canvas
    /// - Parameters:
    ///   - x: x position
    ///   - y: y position
    ///   - text: text to write
    ///   - props: text properties
    /// - Returns: JS to wite text

    func plotText(x: Double, y: Double, text: String, props: Properties) -> String {
        var result = [""]
        ctx.sync(props, &result, isText: true)
        result.append("ctx.fillText('\(text)', \(x.f(1)), \(y.f(1)))")
        ctx.resetTransform(&result)
        return result.joined(separator: "\n    ")
    }

    /// Draw a logo on the canvas
    /// - Parameters:
    ///   - url: location of the logo
    ///   - left: left edge
    ///   - top: top edge
    ///   - width: width
    ///   - height: height
    /// - Returns: JS to add logo

    func drawLogo(url: String, left: Double, top: Double, width: Double, height: Double) -> String {
        var result: [String] = [""]

        result.append("var img = new Image()")
        result.append("img.onload = function() {")
        result.append("    ctx.drawImage(img, \(left.f(1)), \(top.f(1)), \(width.f(1)), \(height.f(1)))")
        result.append("}")
        result.append("img.src = '\(url)'")

        return result.joined(separator: "\n    ")
    }
}

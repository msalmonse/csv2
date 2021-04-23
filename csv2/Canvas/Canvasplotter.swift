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

    func plotClipStart(plotPlane: Plane) {
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

        data.append(result.joined(separator: "\n    "))
    }

    func plotClipEnd() {
        var result = [""]
        result.append("")
        result.append("ctx.restore()")
        result.append("ctx.globalAlpha = 1.0")
        result.append("ctx.beginPath()")

        data.append(result.joined(separator: "\n    "))
    }

    /// Prepare for plotting
    /// - Parameters:
    ///   - positions: the positioning of varoius points
    ///   - plotPlane: the plottable plane
    ///   - propsList: a list of properties
    /// - Returns: the JS to start

    func plotHead(positions: Positions, plotPlane: Plane, propsList: PropertiesList) {
        let id = settings.plotter.canvasID
        let name = "canvas_\(id)"
        let url = settings.plotter.logoURL
        let logo = url.isEmpty ? "" : drawLogo(
            url: url, left: positions.logoX, top: positions.logoY,
            width: settings.plotter.logoWidth, height: settings.plotter.logoHeight
        )
        let bg = settings.css.backgroundColour.isEmpty ? "" : bgRect()
        data.append("""
            const \(name) = document.getElementById('\(id)');
            if (\(name).getContext) {
                const ctx = \(name).getContext('2d');

            \(bg)
            \(logo)
            """
        )
    }

    /// The finish of the plotting

    func plotTail() {
        data.append("\n}\n")
    }

    /// Write text to canvas
    /// - Parameters:
    ///   - x: x position
    ///   - y: y position
    ///   - text: text to write
    ///   - props: text properties

    func plotText(x: Double, y: Double, text: String, props: Properties) {
        var result = [""]
        ctx.sync(props, &result, isText: true)
        result.append("ctx.fillText('\(text)', \(x.f(1)), \(y.f(1)))")
        ctx.resetTransform(&result)
        data.append(result.joined(separator: "\n    "))
    }

    /// Draw a logo on the canvas
    /// - Parameters:
    ///   - url: location of the logo
    ///   - left: left edge
    ///   - top: top edge
    ///   - width: width
    ///   - height: height

    func drawLogo(url: String, left: Double, top: Double, width: Double, height: Double) -> String {
        var result: [String] = [""]

        result.append("var img = new Image()")
        result.append("img.onload = function() {")
        result.append("    ctx.drawImage(img, \(left.f(1)), \(top.f(1)), \(width.f(1)), \(height.f(1)))")
        result.append("}")
        result.append("img.src = '\(url)'")

        return result.joined(separator: "\n    ")
    }

    func bgRect() -> String {
        let colour = ColourTranslate.lookup(settings.css.backgroundColour, or: .white).cssRGBA
        let width = settings.dim.width
        let height = settings.dim.height
        return """
            ctx.fillStyle = '\(colour)'
            ctx.fillRect(0,0,\(width),\(height))
            """
    }
}

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

    func plotClipStart(clipPlane: Plane) {
        let left = clipPlane.left
        let top = clipPlane.top
        let bottom = clipPlane.bottom
        let right = clipPlane.right
        let opacity = settings.doubleValue(.opacity)
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
    ///   - stylesList: a list of properties
    /// - Returns: the JS to start

    func plotHead(positions: Positions, clipPlane: Plane, stylesList: StylesList) {
        let id = settings.stringValue(.canvasID, in: .canvas)
        let name = "canvas_\(id)"
        let url = settings.stringValue(.logoURL)
        let logo = url.isEmpty ? "" : drawLogo(
            url: url, left: positions.logoX, top: positions.logoY,
            width: settings.doubleValue(.logoWidth), height: settings.doubleValue(.logoHeight)
        )
        let bg = settings.colourValue(.backgroundColour) != nil ? "" : bgRect()
        let comment = settings.boolValue(.comment) ? self.comment + "\n" : ""
        data.append("""
            const \(name) = document.getElementById('\(id)');
            if (\(name).getContext) {
                const ctx = \(name).getContext('2d');

            \(comment)\(bg)\(logo)
            """
        )
    }

    /// The finish of the plotting

    func plotTail() {
        data.append("\n}\n")
        let tagFile = settings.stringValue(.tagFile)
        if tagFile.hasContent {
            let id = settings.stringValue(.canvasID, in: .canvas)
            let w = settings.intValue(.width)
            let h = settings.intValue(.height)
            let url = URL(fileURLWithPath: tagFile)

            if let tag = "<canvas id=\"\(id)\" width=\"\(w)\" height=\"\(h)\"></canvas>".data(using: .utf8) {
                do {
                    try tag.write(to: url)
                } catch {
                    print(error.localizedDescription, to: &standardError)
                }
            } else {
                print("Error creating tag data", to: &standardError)
            }
        }
    }

    /// Write text to canvas
    /// - Parameters:
    ///   - x: x position
    ///   - y: y position
    ///   - text: text to write
    ///   - styles: text properties

    func plotText(x: Double, y: Double, text: String, styles: Styles) {
        var result = [""]
        ctx.sync(styles, &result, isText: true)
        if styles.options[.stroked] {
            result.append("ctx.strokeText('\(text)', \(x.f(1)), \(y.f(1)))")
        } else {
            result.append("ctx.fillText('\(text)', \(x.f(1)), \(y.f(1)))")
        }
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
        result.append("")

        return result.joined(separator: "\n    ")
    }

    func bgRect() -> String {
        let colour = (settings.colourValue(.backgroundColour) ?? .white).cssRGBA
        let width = settings.intValue(.width)
        let height = settings.intValue(.height)
        return """
            ctx.fillStyle = '\(colour)'
            ctx.fillRect(0,0,\(width),\(height))

            """
    }
}

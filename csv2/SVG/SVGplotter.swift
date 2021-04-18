//
//  SVGplotter.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-04-06.
//

import Foundation

extension SVG {

    func plotClipStart(plotPlane: Plane) {
        data.append("""
            <g clip-path="url(#plotable)" class="plotarea">

            """
        )
    }

    func plotClipEnd() {
        data.append("</g>\n")
    }

    func plotHead(positions: Positions, plotPlane: Plane, propsList: PropertiesList) {
        data.append((xmlTag + svgTag))
        if settings.plotter.comment { data.append(comment) }
        defs(plotPlane: plotPlane)
        cssStyle(plotProps: propsList.plots)
        if settings.plotter.logoURL.hasContent { logoImage(positions: positions) }
    }

    /// Create a plot command from a number of PathCommand's
    /// - Parameters:
    ///   - points: array of points to plot
    ///   - props: path properties
    /// - Returns: plot command string

    func plotPath(_ points: [PathCommand], props: Properties, fill: Bool = false) {
        var result = [ "<path" ]
        if let cssClass = props.cssClass { result.append("class=\"\(cssClass)\(fill ? " fill" : "")\"") }
        result.append("d=\"")
        result.append(contentsOf: points.map { $0.path })
        result.append("\" />\n")

        data.append(result.joined(separator: " "))
    }

    /// Draw a rectangle
    /// - Parameters:
    ///   - x: x position
    ///   - y: y position
    ///   - w: width
    ///   - h: height
    ///   - rx: corner radius
    ///   - props: path properties
    /// - Returns: SVG code for a rectangle

    func plotRect(_ plane: Plane, rx: Double, props: Properties) {
        var extra = ""
        if let cssClass = props.cssClass { extra = "class=\"\(cssClass)\"" }
        rectTag(x: plane.left, y: plane.top, width: plane.width, height: plane.height, extra: extra, rx: rx)
    }

    /// Finish SVG
    /// - Returns: end tag

    func plotTail() {
        let include = settings.plotter.include.isEmpty ? "" : """

            <!-- \(settings.plotter.include) -->
            \(svgInclude(settings.plotter.include))

            """
        data.append((include + svgTagEnd))
    }

    /// Add text to the SVG
    /// - Parameters:
    ///   - x: x position
    ///   - y: y position
    ///   - text: text to add
    ///   - props: text properties
    /// - Returns: text string

    func plotText(x: Double, y: Double, text: String, props: Properties) {
        var extra = ""
        if let transform = props.transform {
            extra = """
                transform="matrix(\(transform.csv))"
                """
        }
        textTag(x: x, y: y, text: text, cssClass: props.cascade(.cssClass)!, extra: extra)
    }
}

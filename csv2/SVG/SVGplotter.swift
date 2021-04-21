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
    ///   - components: array of components to plot
    ///   - props: path properties
    /// - Returns: plot command string

    func plotPath(_ path: Path, props: Properties, fill: Bool = false) {
        var result = [ "<path" ]
        if let cssClass = props.cssClass { result.append("class=\"\(cssClass)\(fill ? " fill" : "")\"") }
        result.append("d=\"")
        result.append(path.path)
        result.append("\" />\n")

        data.append(result.joined(separator: " "))
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

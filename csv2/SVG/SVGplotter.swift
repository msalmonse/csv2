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

    func plotHead(positions: Positions, plotPlane: Plane, stylesList: StylesList) {
        data.append((xmlTag + svgTag))
        if settings.boolValue(.comment) { data.append(comment) }
        defs(plotPlane: plotPlane)
        cssStyle(stylesList)
        if settings.hasContent(.logoURL) { logoImage(positions: positions) }
    }

    /// Create a plot command from a number of PathCommand's
    /// - Parameters:
    ///   - components: array of components to plot
    ///   - styles: path properties
    /// - Returns: plot command string

    func plotPath(_ path: Path, styles: Styles, fill: Bool = false) {
        var result = [ "<path" ]
        if let cssClass = styles.cssClass { result.append("class=\"\(cssClass)\(fill ? " fill" : "")\"") }
        result.append("d=\"")
        result.append(path.path)
        result.append("\" />\n")

        data.append(result.joined(separator: " "))
    }

    /// Finish SVG
    /// - Returns: end tag

    func plotTail() {
        let includeFile = settings.stringValue(.svgInclude)
        let include = includeFile.isEmpty ? "" : """

            <!-- \(includeFile) -->
            \(svgInclude(includeFile))

            """
        data.append((include + svgTagEnd))
    }

    /// Add text to the SVG
    /// - Parameters:
    ///   - x: x position
    ///   - y: y position
    ///   - text: text to add
    ///   - styles: text properties
    /// - Returns: text string

    func plotText(x: Double, y: Double, text: String, styles: Styles) {
        var extra = ""
        if let transform = styles.transform {
            extra = """
                transform="matrix(\(transform.csv))"
                """
        }
        textTag(x: x, y: y, text: text, cssClass: styles.cssClass!, extra: extra)
    }
}

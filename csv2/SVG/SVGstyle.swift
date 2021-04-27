//
//  SVGstyle.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-26.
//

import Foundation

extension SVG {
    private func cssFonts(_ result: inout [String], id: String) {
        // font sizes and anchors
        let sizes = FontSizes(size: settings.dim.baseFontSize)
        result.append("""
            \(id) text.legend { font-size: \(sizes.legend.size.f(1))px }
            \(id) text.legend.headline { font-size: \((sizes.legend.size * 1.25).f(1))px; font-weight: bold }
            \(id) text.legend.pie { font-size: \(sizes.pieLegend.size.f(1))px; text-anchor: middle }
            \(id) text.subtitle { font-size: \(sizes.subTitle.size.f(1))px; text-anchor: middle }
            \(id) text.title { font-size: \(sizes.title.size.f(1))px; text-anchor: middle }
            \(id) text.xlabel { font-size: \(sizes.label.size.f(1))px; text-anchor: middle }
            \(id) text.xtags { font-size: \(sizes.label.size.f(1))px; text-anchor: middle }
            \(id) text.xtitle, \(id) text.ytitle { font-size: \(sizes.axes.size.f(1))px; text-anchor: middle }
            \(id) text.ylabel { font-size: \(sizes.label.size.f(1))px; text-anchor: end; dominant-baseline: middle }
            """
        )
    }

    private func plotCSS(_ result: inout [String], id: String, plotStyles: [Styles]) {
        for style in plotStyles {
            if let cssClass = style.cssClass, let colour = style.colour {
                let dashes =
                    style.dashed ? "; stroke-dasharray: \(style.dash ?? "-1"); stroke-linecap: butt" : ""
                result.append("""
                    \(id) path.\(cssClass) { stroke: \(colour)\(dashes) }
                    \(id) text.\(cssClass), \(id) rect.\(cssClass) { fill: \(colour); stroke: \(colour) }
                    \(id) path.\(cssClass).fill { stroke: none\(dashes); fill: \(colour); fill-opacity: 0.75 }
                    """
                )
            }
        }
    }

    private func cssIncludes(_ result: inout [String]) {
        if settings.css.extras.hasEntries {
            result.append("<style>\n" + settings.css.extras.joined(separator: "\n") + "</style>\n")
        }

        if let url = SearchPath.search(settings.css.include), let include = try? String(contentsOf: url) {
            result.append("<style>\n" + include + "</style>")
        }
    }

    private func cssBG(_ result: inout [String], id: String) {
        let bg = settings.css.backgroundColour.isEmpty ? "transparent" : settings.css.backgroundColour
        result.append("svg\(id) { background-color: \(bg) }")

        // some backgrounds for colour lists
        result.append("\(id) path.lightBG { fill: \(RGBAu8.lightBG.cssRGBA) }")
        result.append("\(id) path.midBG { fill: \(RGBAu8.midBG.cssRGBA) }")
        result.append("\(id) path.darkBG { fill: \(RGBAu8.darkBG.cssRGBA) }")
    }

    /// Generate <style> tags
    /// - Parameter extra: extra tags
    /// - Returns: css information in a string

    func cssStyle(plotProps: [Styles], extra: String = "") {
        let id = hashID
        var result: [String] = ["<style>"]
        cssBG(&result, id: id)
        result.append("\(id) g.plotarea { opacity: \(settings.css.opacity.f(1)) }")
        if settings.css.hover {
            result.append("\(id) g.plotarea path:hover { stroke-width: \((strokeWidth * 2.5).f(1)) }")
        }
        result.append(
            "\(id) path { stroke-width: \(strokeWidth.f(1)); fill: none; stroke-linecap: round }"
        )
        result.append("\(id) path.axes { stroke: black }")
        result.append(
            "\(id) path.xlabel, \(id) path.ylabel { stroke: silver; stroke-width: 1 }"
        )

        var textCSS: [String] = []
        if settings.css.fontFamily.hasContent { textCSS.append("font-family: \(settings.css.fontFamily)") }
        if settings.css.bold { textCSS.append("font-weight: bold") }
        if settings.css.italic { textCSS.append("font-style: italic") }
        if textCSS.hasEntries { result.append("\(id) text { " + textCSS.joined(separator: ";") + " }") }

        // Font settings
        cssFonts(&result, id: id)

        // Individual plot settings
        plotCSS(&result, id: id, plotStyles: plotProps)

        result.append(
            "\(id) path.legend { fill: silver; stroke: silver; fill-opacity: 0.1; stroke-width: 1.5 }"
        )

        if extra.hasContent { result.append(extra) }

        result.append("</style>")

        cssIncludes(&result)

        result.append("")   // Add newline
        data.append(result.joined(separator: "\n"))
    }
}

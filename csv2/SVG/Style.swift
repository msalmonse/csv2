//
//  Style.swift
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
            \(id) text.legend { font-size: \(sizes.legendSize.f(1))px }
            \(id) text.legend.headline { font-size: \((sizes.legendSize * 1.25).f(1))px; font-weight: bold }
            \(id) text.subtitle { font-size: \(sizes.subTitleSize.f(1))px; text-anchor: middle }
            \(id) text.title { font-size: \(sizes.titleSize.f(1))px; text-anchor: middle }
            \(id) text.xlabel { font-size: \(sizes.labelSize.f(1))px; text-anchor: middle }
            \(id) text.xtitle, \(id) text.ytitle { font-size: \(sizes.axesSize.f(1))px; text-anchor: middle }
            \(id) text.ylabel { font-size: \(sizes.labelSize.f(1))px; text-anchor: end; dominant-baseline: middle }
            """
        )
    }

    private func cssProps(_ result: inout [String], id: String, propsList: [Properties]) {
        for props in propsList {
            if let cssClass = props.cssClass, let colour = props.colour {
                let dashes =
                    props.dashed ? "; stroke-dasharray: \(props.dash ?? "-1"); stroke-linecap: butt" : ""
                result.append("""
                    \(id) path.\(cssClass) { stroke: \(colour)\(dashes) }
                    \(id) text.\(cssClass), \(id) rect.\(cssClass) { fill: \(colour); stroke: \(colour) }
                    """
                )
                if props.bar >= 0 {
                    result.append("""
                        \(id) path.\(cssClass).fill { stroke: \(colour)\(dashes); fill: \(colour); fill-opacity: 0.75 }
                        """
                    )
                }
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
    }

    /// Generate <style> tags
    /// - Parameter extra: extra tags
    /// - Returns: css information in a string

    func cssStyle(plotProps: [Properties], extra: String = "") {
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
        cssProps(&result, id: id, propsList: plotProps)

        result.append(
            "\(id) rect.legend { fill: silver; stroke: silver; fill-opacity: 0.1; stroke-width: 1.5 }"
        )

        if extra.hasContent { result.append(extra) }

        result.append("</style>")

        cssIncludes(&result)

        data.append(result.joined(separator: "\n"))
    }
}

//
//  CSS.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-26.
//

import Foundation

extension SVG {
    private func cssFonts(_ result: inout [String]) {
        // font sizes and anchors
        result.append("""
            text.legends { font-size: \(legendSize.f(1))px }
            text.subtitle { font-size: \(subTitleSize.f(1))px; text-anchor: middle }
            text.title { font-size: \(titleSize.f(1))px; text-anchor: middle }
            text.xlabel { font-size: \(labelSize.f(1))px; text-anchor: middle }
            text.xtitle { font-size: \(axesSize.f(1))px; text-anchor: middle }
            text.ylabel { font-size: \(labelSize.f(1))px; text-anchor: end; dominant-baseline: middle }
            text.ytitle { font-size: \(axesSize.f(1))px; text-anchor: middle; writing-mode: tb }
            """
        )
    }

    private func cssProps(_ result: inout [String]) {
        for props in propsList {
            if let cssClass = props.cssClass, let colour = props.colour {
                let dashes =
                    props.dashed ? "; stroke-dasharray: \(props.dash ?? "-1"); stroke-linecap: butt" : ""
                result.append("""
                    path.\(cssClass) { fill: none; stroke: \(colour)\(dashes) }
                    text.\(cssClass) { fill: \(colour); stroke: \(colour) }
                    """
                )
            }
        }
    }

    private func cssIncludes(_ result: inout [String]) {
        if settings.cssExtras.count > 0 {
            result.append("<style>\n" + settings.cssExtras.joined(separator: "\n") + "</style>\n")
        }

        if settings.cssInclude != "" {
            if let include = try? String(contentsOfFile: settings.cssInclude) {
                result.append("<style>\n" + include + "</style>")
            }
        }
    }

    /// Generate <style> tags
    /// - Parameter extra: extra tags
    /// - Returns: css information in a string

    func cssStyle(extra: String = "") -> String {
        var result: [String] = ["<style>"]
        if settings.backgroundColour != "" {
            result.append("svg { background-color: \(settings.backgroundColour) }")
        }
        result.append("path { stroke-width: \(settings.strokeWidth.f(1)); fill: none; stroke-linecap: round }")
        result.append("path.axes { stroke: black }")
        result.append("path.xtick, path.ytick { stroke: silver; stroke-width: 1 }")

        var textCSS: [String] = []
        if settings.fontFamily != "" { textCSS.append("font-family: \(settings.fontFamily)") }
        if settings.bold { textCSS.append("font-weight: bold") }
        if settings.italic { textCSS.append("font-style: italic") }
        if textCSS.count > 0 { result.append("text { " + textCSS.joined(separator: ";") + " }") }

        // Font settings
        cssFonts(&result)

        // Individual plot settings
        cssProps(&result)

        result.append("rect.legends { fill: silver; stroke: silver; fill-opacity: 0.1; stroke-width: 1.5px }")

        if extra != "" { result.append(extra) }

        result.append("</style>")

        cssIncludes(&result)

        return result.joined(separator: "\n")
    }
}

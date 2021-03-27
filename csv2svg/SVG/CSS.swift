//
//  CSS.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-26.
//

import Foundation

extension SVG {
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
        // font sizes and anchors
        result.append("""
            text.legends { font-size: \(settings.legendSize.f(1))px }
            text.subtitle { font-size: \(settings.subTitleSize.f(1))px; text-anchor: middle }
            text.title { font-size: \(settings.titleSize.f(1))px; text-anchor: middle }
            text.xlabel { font-size: \(settings.labelSize.f(1))px; text-anchor: middle }
            text.xtitle { font-size: \(settings.axesSize.f(1))px; text-anchor: middle }
            text.ylabel { font-size: \(settings.labelSize.f(1))px; text-anchor: end; dominant-baseline: middle }
            text.ytitle { font-size: \(settings.axesSize.f(1))px; text-anchor: middle; writing-mode: tb }
            """
        )

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

        result.append("rect.legends { fill: silver; stroke: silver; fill-opacity: 0.1; stroke-width: 1.5px }")

        if extra != "" { result.append(extra) }

        result.append("</style>")

        return result.joined(separator: "\n")
    }
}

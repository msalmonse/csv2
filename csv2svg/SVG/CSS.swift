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
        result.append("path { stroke-width: \(settings.strokeWidth.f(1)); fill: none }")
        result.append("path.axes { stroke: black }")
        result.append("path.xtick, path.ytick { stroke: silver; stroke-width: 1 }")

        var textCSS: [String] = []
        if settings.fontFamily != "" { textCSS.append("font-family: \(settings.fontFamily)") }
        if settings.bold { textCSS.append("font-weight: bold") }
        if settings.italic { textCSS.append("font-style: italic") }
        if textCSS.count > 0 { result.append(textCSS.joined(separator: ";")) }

        for props in propsList {
            if let cssClass = props.cssClass, let colour = props.colour {
                result.append("path.\(cssClass) { fill: none; stroke: \(colour) }")
            }
        }

        if extra != "" { result.append(extra) }

        result.append("</style>")

        return result.joined(separator: "\n")
    }
}

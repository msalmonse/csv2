//
//  SVGstyle.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-26.
//

import Foundation

extension SVG {
    /// Add styles for texts
    /// - Parameters:
    ///   - result: Where to append style
    ///   - stylesList: list of styles
    ///   - id: css id for svg

    private func cssText(_ result: inout [String], _ stylesList: StylesList, id: String) {

        /// Add the style for a text class
        /// - Parameters:
        ///   - styles: style to add
        ///   - suffix: class suffix
        ///   - extra: extra styling

        func oneText(_ styles: Styles, suffix: String = "", extra: String = "") {
            guard let cl = styles.cssClass else { return }
            let anc = "text-anchor: " + (styles.textAlign!)
            let clr = styles.fontColour!
            let fill = styles.fill ?? clr
            let size = "font-size: " + styles.fontSize.f(1) + "px"
            result.append("""
                \(id) text.\(cl)\(suffix) { fill: \(fill); stroke: \(clr); \(size); \(anc); \(extra) }
                """
            )
        }

        oneText(stylesList.draft)
        oneText(stylesList.legend)
        oneText(stylesList.legendHeadline)
        oneText(stylesList.pieLabel)
        var pieLabel = stylesList.pieLabel
        pieLabel.textAlign = "start"; oneText(pieLabel, suffix: ".start")
        pieLabel.textAlign = "middle"; oneText(pieLabel, suffix: ".middle")
        pieLabel.textAlign = "end"; oneText(pieLabel, suffix: ".end")
        oneText(stylesList.pieLegend)
        oneText(stylesList.pieSubLegend)
        oneText(stylesList.subTitle)
        oneText(stylesList.title)
        oneText(stylesList.xLabel)
        oneText(stylesList.xTags)
        oneText(stylesList.xTitle)
        oneText(stylesList.yLabel, extra: "dominant-baseline: middle")
        oneText(stylesList.yTitle)
    }

    /// Add styles for plots

    /// - Parameters:
    ///   - result: where to add styles
    ///   - id: id for svg
    ///   - plotStyles: styles for the plots

    private func plotCSS(_ result: inout [String], id: String, plotStyles: [Styles], size: Double) {
        for style in plotStyles {
            if let cssClass = style.cssClass, let colour = style.colour {
                let dashes = style.options[.dashed]
                    ? "; stroke-dasharray: \(style.dash!); stroke-linecap: butt" : ""
                let px = "font-size: " + size.f(1) + "px;"
                result.append("""
                    \(id) path.\(cssClass) { stroke: \(colour)\(dashes) }
                    \(id) text.\(cssClass), \(id) rect.\(cssClass) { \(px) fill: \(colour); stroke: \(colour) }
                    \(id) path.\(cssClass).fill { stroke: none\(dashes); fill: \(colour); fill-opacity: 0.75 }
                    """
                )
            }
        }
    }

    /// Add extra css
    /// - Parameter result: where to add styles

    private func cssIncludes(_ result: inout [String]) {
        if settings.css.extras.hasEntries {
            result.append("<style>\n" + settings.css.extras.joined(separator: "\n") + "</style>\n")
        }

        if let url = SearchPath.search(settings.css.include), let include = try? String(contentsOf: url) {
            result.append("<style>\n" + include + "</style>")
        }
    }

    /// Add css for the background
    /// - Parameters:
    ///   - result: where to add styles
    ///   - id: id for svg

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

    func cssStyle(_ stylesList: StylesList, extra: String = "") {
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
        result.append("\(id) path.black { stroke: black }")
        result.append("\(id) path.black.fill { fill: black; stroke: black }")
        var colour = stylesList.axes.colour!
        result.append("\(id) path.axes { stroke: \(colour) }")
        colour = stylesList.xLabel.colour!
        result.append("\(id) path.xlabel, \(id) path.ylabel { stroke: \(colour); stroke-width: 1 }")
        colour = stylesList.yLabel.colour!
        result.append("\(id) path.ylabel { stroke: \(colour); stroke-width: 1 }")

        var textCSS: [String] = []
        if settings.css.fontFamily.hasContent { textCSS.append("font-family: \(settings.css.fontFamily)") }
        if settings.css.bold { textCSS.append("font-weight: bold") }
        if settings.css.italic { textCSS.append("font-style: italic") }
        if textCSS.hasEntries { result.append("\(id) text { " + textCSS.joined(separator: ";") + " }") }

        // Font settings
        cssText(&result, stylesList, id: id)

        // Individual plot settings
        plotCSS(&result, id: id, plotStyles: stylesList.plots, size: stylesList.legend.fontSize)

        colour = stylesList.legendBox.colour ?? "silver"
        result.append(
            "\(id) path.legend { stroke: \(colour); stroke-width: 1.5 }"
        )

        if extra.hasContent { result.append(extra) }

        result.append("</style>")

        cssIncludes(&result)

        result.append("")   // Add newline
        data.append(result.joined(separator: "\n"))
    }
}

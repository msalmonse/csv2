//
//  SVG/SVG.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-18.
//

import Foundation

class SVG: Plotter, ReflectedStringConvertible {
    // plot widths
    var strokeWidth: Double { settings.css.strokeWidth }
    var shapeWidth: Double { strokeWidth * 1.75 }

    let settings: Settings

    // Plot area height and width
    let height: Double
    let width: Double

    // id for this svg
    let svgID: String
    var hashID: String { svgID == "none" ? "" : "#\(svgID)" }

    // Tags
    let xmlTag = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>"
    var svgTag: String {
        String(
                format: "<svg %@ width=\"%.0f\" height=\"%.0f\" xmlns=\"http://www.w3.org/2000/svg\">",
            svgID != "none" ? "id=\"\(svgID)\"" : "" , settings.width, settings.height
        )
    }
    let svgTagEnd = "</svg>"
    let comment = """
    <!--
        Created by \(AppInfo.name): \(AppInfo.version) (\(AppInfo.branch):\(AppInfo.build)) \(AppInfo.origin)
      -->
    """

    init(_ settings: Settings) {
        self.settings = settings
        svgID = settings.css.id.hasContent ? settings.css.id
            : "ID-\(Int.random(in: 1...(1 << 24)).x0(6))"
        height = settings.height
        width = settings.width
    }

    /// Generate the defs element
    /// - Returns: the defs elements as a list

    func defs() -> [String] {
        // Make plottable a bit bigger so that shapes aren't clipped
        let h = (plotPlane.bottom - plotPlane.top + shapeWidth * 4.0)
        let w = (plotPlane.right - plotPlane.left + shapeWidth * 4.0)
        let x = (plotPlane.left - shapeWidth * 2.0)
        let y = (plotPlane.top - shapeWidth * 2.0)
        var result = ["<defs>"]
        result.append("<clipPath id=\"plotable\">")
        result.append(rectTag(x: x, y: y, width: w, height: h))
        result.append("</clipPath>")
        result.append("</defs>")

        return result
    }

    func logoImage() -> String {
        let x = positions.logoX
        let y = positions.logoY
        let h = settings.svg.logoHeight
        let w = settings.svg.logoWidth
        let url = settings.svg.logoURL
        return """
            <image \(xy(x,y)) \(wh(w,h)) href="\(url)" class="logo" preserveAspectRatio="xMaxYMin" />
            """
    }

    /// Generate an SVG group with the plot lines
    /// - Parameter ts: TransScale object
    /// - Returns: Array of SVG elements

    func lineGroup(_ ts: TransScale) -> [String] {
        var result: [String] = []
        result.append("<g clip-path=\"url(#plotable)\" class=\"plotarea\">")
        result.append(contentsOf: settings.inColumns ? columnPlot(ts) : rowPlot(ts))
        result.append("</g>")

        return result
    }

    /// Include SVG elements in SVG
    /// - Parameter name: file name to include
    /// - Returns: Text to include

    func svgInclude(_ name: String) -> String {
        if let url = SearchPath.search(name), let include = try? String(contentsOf: url) {
            return include
        }
        return ""
    }


}

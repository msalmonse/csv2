//
//  SVG.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-18.
//

import Foundation

class SVG: ReflectedStringConvertible {
    // font sizes in px
    var axesPX: String { String(format: "%.1fpx", settings.axesSize) }
    var labelPX: String { String(format: "%.1fpx", settings.labelSize) }
    var legendPX: String { String(format: "%.1fpx", settings.legendSize) }
    var titlePX: String { String(format: "%.1fpx", settings.titleSize) }

    let csv: CSV
    let settings: Settings

    // Row or column to use for x values
    let index: Int

    // The four sides of the data plane
    let dataEdges: Plane
    // and the plot plane
    let plotEdges: Plane

    // Vertical positions
    let titleY: Double
    let legendY: Double
    let xTitleY: Double
    let xTicksY: Double

    // Horizontal positions
    let yTitleX: Double
    let yTickX: Double

    // path colours
    let colours: [String]

    // path tags
    let names: [String]

    // Tags
    let xmlTag = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>"
    var svgTag: String {
        String(
                format: "<svg width=\"%d\" height=\"%d\" xmlns=\"http://www.w3.org/2000/svg\">",
                settings.width, settings.height
        )
    }
    let svgTagEnd = "</svg>"
    let comment = """
    <!--
        Created by \(AppInfo.name): \(AppInfo.version) (\(AppInfo.build)) \(AppInfo.origin)
      -->
    """

    init(_ csv: CSV, _ settings: Settings) {
        self.csv = csv
        self.settings = settings

        self.index = settings.index - 1

        dataEdges = SVG.sidesFromData(csv, settings)

        // Calculate vertical positions
        var pos = Double(settings.height - 5)
        titleY = pos
        if settings.title != "" { pos -= settings.titleSize * 1.25 }
        legendY = pos
        pos -= settings.legendSize * 1.25
        xTitleY = pos
        if settings.xTitle != "" { pos -= settings.axesSize * 1.25 }
        xTicksY = pos
        if settings.xTick >= 0 { pos -= settings.labelSize * 1.25 }
        let bottomY = pos

        // Calculate horizontal positions
        pos = 5
        if settings.yTitle != "" { pos += settings.axesSize * 1.25 }
        yTitleX = pos
        // Give some extra space for minus sign
        if settings.yTick >= 0 { pos += settings.labelSize * (dataEdges.left < 0.0 ? 3.5 : 4.0) }
        yTickX = pos
        pos += Double(settings.strokeWidth)

        plotEdges = Plane(
            top: 10, bottom: bottomY,
            left: pos, right: Double(settings.width) - settings.labelSize * 2.0
        )

        // Initialize path columns
        let ct = settings.inColumns ? csv.colCt : csv.rowCt
        var colours: [String] = []
        var names: [String] = []
        for i in 0..<ct {
            if i < settings.colours.count && settings.colours[i] != "" {
                colours.append(settings.colours[i])
            } else {
                colours.append(SVG.Colours.nextColour())
            }
            if i < settings.names.count && settings.names[i] != "" {
                names.append(settings.names[i])
            } else if settings.headers > 0 {
                names.append(SVG.headerText(i, csv: csv, inColumns: settings.inColumns))
            } else {
                names.append(SVG.headerText(i, csv: nil, inColumns: settings.inColumns))
            }
        }
        self.colours = colours
        self.names = names
    }

    func svgLineGroup(_ ts: TransScale) -> [String] {
        var result: [String] = []
        result.append("<g clip-path=\"url(#plotable)\" >")
        result.append(contentsOf: settings.inColumns ? columnPlot(ts) : rowPlot(ts))
        result.append("</g>")

        return result
    }

    func gen() -> [String] {
        let ts = TransScale(from: dataEdges, to: plotEdges)

        var result: [String] = [ xmlTag, svgTag, comment ]
        result.append(contentsOf: svgDefs())
        result.append(svgAxes(ts))
        if settings.xTick >= 0 { result.append(svgXtick(ts)) }
        if settings.yTick >= 0 { result.append(svgYtick(ts)) }
        result.append(contentsOf: svgLineGroup(ts))
        if settings.xTitle != "" {
            result.append(xTitle(settings.xTitle, x: plotEdges.hMid, y: xTitleY))
        }
        if settings.yTitle != "" {
            result.append(yTitle(settings.yTitle, x: yTitleX, y: plotEdges.vMid))
        }
        result.append(svgLegends(Double(settings.width)/2.0, legendY))
        if settings.title != "" { result.append(svgTitle()) }
        result.append(svgTagEnd)

        return result
    }
}

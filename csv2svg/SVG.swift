//
//  SVG.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-18.
//

import Foundation

class SVG {

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

        dataEdges = SVG.sidesFromColumns(csv, settings)

        // Calculate vertical positions
        var pos = Double(settings.height - 5)
        titleY = pos
        if settings.title != "" { pos -= 40 }
        legendY = pos
        if settings.names.count > 0 || settings.headers > 0 { pos -= 25 }
        xTitleY = pos
        if settings.xTitle != "" { pos -= 12 }
        xTicksY = pos
        if settings.xTick > 0 { pos -= 20 }
        let bottomY = pos

        // Calculate horizontal positions
        pos = 5
        if settings.yTitle != "" { pos += 12 }
        yTitleX = pos
        if settings.yTick > 0 { pos += 30 }
        yTickX = pos
        pos += 2

        plotEdges = Plane(
            top: 10, bottom: bottomY,
            left: pos, right: Double(settings.width - 8)
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
                names.append(SVG.headerText(i, csv: csv, inColumn: settings.inColumns))
            } else {
                names.append("")
            }
        }
        self.colours = colours
        self.names = names
    }

    func svgLineGroup(_ ts: TransScale) -> [String] {
        var result: [String] = []
        result.append(svgAxes(ts))
        if settings.xTick > 0 { result.append(svgXtick(ts)) }
        if settings.yTick > 0 { result.append(svgYtick(ts)) }
        result.append("<g clip-path=\"url(#plotable)\" >")
        result.append(contentsOf: columnPlot(ts))
        result.append("</g>")

        return result
    }

    func gen() -> [String] {
        let ts = TransScale(from: dataEdges, to: plotEdges)

        var result: [String] = [ xmlTag, svgTag, comment ]
        result.append(contentsOf: svgDefs())
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

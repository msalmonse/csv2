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

    // Positions
    let positions: Positions

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

        positions = Positions(settings, dataLeft: dataEdges.left)

        plotEdges = Plane(
            top: settings.baseFontSize, bottom: positions.bottomY,
            left: positions.leftX, right: Double(settings.width) - settings.labelSize * 2.0
        )

        // Initialize path columns
        let ct = settings.inColumns ? csv.colCt : csv.rowCt
        var colours: [String] = []
        var names: [String] = []
        for i in 0..<ct {
            if i < settings.colours.count && settings.colours[i] != "" {
                colours.append(settings.colours[i])
            } else if settings.black {
                colours.append("black")
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
}

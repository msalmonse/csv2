//
//  SVG/SVG.swift
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

    // plot widths
    var plotWidth: Double { settings.strokeWidth }
    var shapeWidth: Double { plotWidth * 1.75 }

    let csv: CSV
    let settings: Settings

    // Row or column to use for x values
    let index: Int

    // The four sides of the data plane
    let dataEdges: Plane
    // the plot plane
    let plotEdges: Plane
    // and the allowed drawing plain
    let allowedEdges: Plane

    // Plot area height and width
    let height: Double
    let width: Double

    // Positions for various elements
    let positions: Positions

    // Path Properties
    let props: [PathProperties]

    // limit of distance between data points
    let limit: Double

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

        height = Double(settings.height)
        width = Double(settings.width)
        allowedEdges = Plane(
            top: -0.5 * height, bottom: 1.5 * height,
            left: -0.5 * width, right: 1.5 * width
        )
        dataEdges = SVG.sidesFromData(csv, settings)

        positions = Positions(settings, dataLeft: dataEdges.left)

        limit = settings.dataPointDistance

        plotEdges = Plane(
            top: settings.baseFontSize, bottom: positions.bottomY,
            left: positions.leftX, right: positions.rightX
        )

        // Initialize path info
        let ct = settings.inColumns ? csv.colCt : csv.rowCt
        var props = Array(repeating: PathProperties(), count: ct)
        SVG.plotFlags(settings, ct, &props)             // setup first so that the other functions can use them
        SVG.plotColours(settings, ct, &props)
        SVG.plotDashes(settings, ct, plotEdges.width, &props)
        SVG.plotNames(settings, csv, ct, &props)
        SVG.plotShapes(settings, ct, index: settings.index - 1, &props)
        self.props = props
    }
}

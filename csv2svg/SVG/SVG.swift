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
    var subTitlePX: String { String(format: "%.1fpx", settings.subTitleSize) }
    var titlePX: String { String(format: "%.1fpx", settings.titleSize) }

    // number of rows or columns
    var plotCount: Int

    // plot widths
    var strokeWidth: Double { settings.strokeWidth }
    var shapeWidth: Double { strokeWidth * 1.75 }

    let csv: CSV
    let settings: Settings

    // Row or column to use for x values
    let index: Int

    // The four sides of the data plane
    let dataPlane: Plane
    // the plot plane
    let plotPlane: Plane
    // and the allowed drawing plain
    let allowedPlane: Plane

    // Plot area height and width
    let height: Double
    let width: Double

    // Positions for various elements
    let positions: Positions

    // Path Properties
    let props: [PathProperties]

    // limit of distance between data points
    let limit: Double

    // sub title
    let subTitle: String

    // Styles to use
    let styles: [String: Style]

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

        self.index = settings.index

        height = Double(settings.height)
        width = Double(settings.width)
        allowedPlane = Plane(
            top: -0.5 * height, bottom: 1.5 * height,
            left: -0.5 * width, right: 1.5 * width
        )
        dataPlane = SVG.sidesFromData(csv, settings)

        positions = Positions(settings, dataLeft: dataPlane.left)

        limit = settings.dataPointDistance

        plotPlane = Plane(
            top: settings.baseFontSize, bottom: positions.bottomY,
            left: positions.leftX, right: positions.rightX
        )

        plotCount = settings.inColumns ? csv.colCt : csv.rowCt

        // Initialize path info
        var props = Array(repeating: PathProperties(), count: plotCount)
        // setup first so that the other functions can use them
        SVG.plotFlags(settings, plotCount, &props)
        SVG.plotColours(settings, plotCount, &props)
        SVG.plotDashes(settings, plotCount, plotPlane.width, &props)
        SVG.plotNames(settings, csv, plotCount, &props)
        SVG.plotShapes(settings, plotCount, index: settings.index, &props)
        self.props = props

        subTitle = settings.subTitle != ""
            ? settings.subTitle
            : Self.subTitleText(csv: csv, inColumns: settings.inColumns, header: settings.subTitleHeader)

        styles = SVG.styleDict(settings)
    }
}

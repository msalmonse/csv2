//
//  SVG/SVG.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-18.
//

import Foundation

class SVG: ReflectedStringConvertible {
    // plot widths
    var strokeWidth: Double { settings.css.strokeWidth }
    var shapeWidth: Double { strokeWidth * 1.75 }

    let csv: CSV
    let settings: Settings

    // font sizes
    let sizes: FontSizes
    var axesSize: Double { return sizes.axesSize }
    var labelSize: Double { return sizes.labelSize }
    var legendSize: Double { return sizes.legendSize }
    var subTitleSize: Double { return sizes.subTitleSize }
    var titleSize: Double { return sizes.titleSize }

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
    let propsList: [PathProperties]

    // limit of distance between data points
    let limit: Double

    // sub title
    let subTitle: String

    // log x and y axes
    var logx: Bool { settings.logx && dataPlane.left > 0.0 }
    var logy: Bool { settings.logy && dataPlane.bottom > 0.0 }

    // id for this svg
    let svgID: String
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

    init(_ csv: CSV, _ settings: Settings) {
        self.csv = csv
        self.settings = settings
        sizes = FontSizes(size: settings.dim.baseFontSize)
        self.index = settings.csv.index
        svgID = !settings.css.id.isEmpty ? settings.css.id
            : "ID-\(Int.random(in: 1...(1 << 24)).x0(6))"
        height = settings.height
        width = settings.width
        allowedPlane = Plane(
            top: -0.5 * height, bottom: 1.5 * height,
            left: -0.5 * width, right: 1.5 * width
        )
        dataPlane = SVG.sidesFromData(csv, settings)

        positions = Positions(settings, dataLeft: dataPlane.left, sizes: sizes)

        limit = settings.plot.dataPointDistance

        plotPlane = Plane(
            top: positions.topY, bottom: positions.bottomY,
            left: positions.leftX, right: positions.rightX
        )

        let plotCount = settings.inColumns ? csv.colCt : csv.rowCt

        // Initialize path info
        var props = Array(repeating: PathProperties(), count: plotCount)
        // setup first so that the other functions can use them
        SVG.plotFlags(settings, plotCount, &props)
        SVG.plotClasses(settings, plotCount, &props)
        SVG.plotColours(settings, plotCount, &props)
        SVG.plotDashes(settings, plotCount, plotPlane.width, &props)
        SVG.plotNames(settings, csv, plotCount, &props)
        SVG.plotShapes(settings, plotCount, index: settings.csv.index, &props)
        propsList = props

        subTitle = !settings.subTitle.isEmpty
            ? settings.subTitle
            : plotCount == 0 ? ""
            : Self.subTitleText(csv: csv, inColumns: settings.inColumns, header: settings.csv.subTitleHeader)
    }
}

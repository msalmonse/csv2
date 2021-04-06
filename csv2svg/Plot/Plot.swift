//
//  Plot.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-04-06.
//

import Foundation

class Plot: ReflectedStringConvertible {
    // plot widths
    var strokeWidth: Double { settings.css.strokeWidth }
    var shapeWidth: Double { strokeWidth * 1.75 }

    let csv: CSV
    let settings: Settings
    let plotter: Plotter

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
    let propsList: PropertiesList

    // limit of distance between data points
    let limit: Double

    // sub title
    let subTitle: String

    // log x and y axes
    var logx: Bool { settings.svg.logx && dataPlane.left > 0.0 }
    var logy: Bool { settings.svg.logy && dataPlane.bottom > 0.0 }

    init(_ csv: CSV, _ settings: Settings, _ plotter: Plotter) {
        self.csv = csv
        self.settings = settings
        self.plotter = plotter

        self.index = settings.csv.index
        height = settings.height
        width = settings.width
        allowedPlane = Plane(
            top: -0.5 * height, bottom: 1.5 * height,
            left: -0.5 * width, right: 1.5 * width
        )
        dataPlane = Sides.fromData(csv, settings)

        positions = Positions(settings, dataLeft: dataPlane.left)

        limit = settings.plot.dataPointDistance

        plotPlane = Plane(
            top: positions.topY, bottom: positions.bottomY,
            left: positions.leftX, right: positions.rightX
        )

        let plotCount = settings.inColumns ? csv.colCt : csv.rowCt

        // Initialize path info
        var props = PropertiesList(count: plotCount, settings: settings)
        // setup first so that the other functions can use them
        plotFlags(settings, plotCount, &props.plots)
        plotClasses(settings, plotCount, &props.plots)
        plotColours(settings, plotCount, &props.plots)
        plotDashes(settings, plotCount, plotPlane.width, &props.plots)
        plotNames(settings, csv, plotCount, &props.plots)
        plotShapes(settings, plotCount, index: settings.csv.index, &props.plots)
        propsList = props

        subTitle = ""
    }
}

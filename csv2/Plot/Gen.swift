//
//  SVG/Gen.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-10.
//

import Foundation

extension Plot {

    /// Generate an  group with the plot lines

    func lineGroup() {
        plotter.plotClipStart(plotPlane: plotPlane)
        settings.inColumns ? columnPlot() : rowPlot()
        plotter.plotClipEnd()
    }

    /// Generate a plotter document

    func gen() {
        plotter.plotHead(positions: positions, plotPlane: plotPlane, stylesList: stylesList)
        if settings.dim.xTick >= 0 { xTick() }
        if settings.dim.yTick >= 0 { yTick() }
        if settings.csv.xTagsHeader >= 0 { xTags() }
        axes()
        lineGroup()
        if settings.plotter.xTitle.hasContent {
            xTitleText(settings.plotter.xTitle, x: plotPlane.hMid, y: positions.xTitleY)
        }
        if settings.plotter.yTitle.hasContent {
            yTitleText(settings.plotter.yTitle, x: positions.yTitleX, y: plotPlane.vMid)
        }
        if settings.plotter.legends { legend() }
        if let subTitle = subTitleLookup() { subTitleText(subTitle) }
        if settings.plotter.title.hasContent { titleText() }

        plotter.plotTail()
    }

    /// Generate an SVG to display a shape
    /// - Parameters:
    ///   - name: shape name
    ///   - colour: stroke colour

    func shapeGen(name: String, colour: String) {
        if let shape = Shape.lookup(name) {
            var stylesList = StylesList(count: 1, settings: settings)
            stylesList.plots[0].cssClass = name
            stylesList.plots[0].colour = colour
            plotter.plotHead(positions: positions, plotPlane: plotPlane, stylesList: stylesList)
            let shapePath = Path([
                    PathComponent.moveTo(xy: Point(x: width/2.0, y: height/2.0)),
                    shape.pathComponent(w: shapeWidth)
                ]
            )
            plotter.plotPath(shapePath, styles: stylesList.plots[0], fill: false)
            plotter.plotTail()
        }
    }

    /// Generate a pie chart

    func pieGen() {
        plotter.plotHead(positions: positions, plotPlane: plotPlane, stylesList: stylesList)

        let row1 = settings.csv.headerRows

        // calculate the size of the squares that can fit in plotPlane
        // cols for number of columns, rows for number of rows and side for side of square
        // cols * side <= width
        // rows * side <= height
        // rows * cols >= count
        let rows = ceil(sqrt(Double(csv.rowCt - row1) * plotPlane.height/plotPlane.width))
        let side = floor(plotPlane.height/rows)
        let cols = Int(floor(plotPlane.width/side))

        let maxRadiusX = side - sizes.pieLabel.size * 4.0
        let maxRadiusY = side - sizes.pieLabel.spacing * 2.0
        let radius = floor(min(maxRadiusX, maxRadiusY) * 0.4)

        var rowY = plotPlane.top + side/2.0
        var colX = plotPlane.left + side/2.0

        for row in row1..<csv.rowCt {
            let centre = Point(x: colX, y: rowY)
            plotPie(row, settings.csv.headerColumns, centre: centre, radius: radius)
            colX += side
            if ((row - row1) % cols) == cols - 1 {
                rowY += side
                colX = plotPlane.left + side/2.0
            }
        }

        if settings.plotter.legends { legend() }
        if let subTitle = subTitleLookup() { subTitleText(subTitle) }
        if settings.plotter.title.hasContent { titleText() }

        plotter.plotTail()
    }

    /// Generate a chart

    func chartGen() {
        switch settings.chartType {
        case .pieChart: pieGen()
        default: gen()
        }
    }
}

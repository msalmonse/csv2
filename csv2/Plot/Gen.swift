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

        let maxRadiusX = ts.xpos(1.0) - ts.xpos(0.0) - sizes.pieLabel.size * 4.0
        let maxRadiusY = plotPlane.height - sizes.pieLabel.spacing * 2.0
        let radius = floor(min(maxRadiusX, maxRadiusY) * 0.4)
        let row1 = settings.csv.headerRows
        for row in row1..<csv.rowCt {
            let centre = ts.pos(x: Double(row - row1), y: 1.0)
            plotPie(row, settings.csv.headerColumns, centre: centre, radius: radius)
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

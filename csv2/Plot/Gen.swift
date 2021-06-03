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
        plotter.plotClipStart(clipPlane: clipPlane)
        plotValues()
        plotter.plotClipEnd()
    }

    /// Generate a plotter document

    func gen() {
        plotter.plotHead(positions: positions, clipPlane: clipPlane, stylesList: stylesList)
        if settings.doubleValue(.xTick) >= 0 { xTick() }
        if settings.doubleValue(.yTick) >= 0 { yTick() }
        if settings.intValue(.xTagsHeader) >= 0 { xTags() }
        axes()
        lineGroup()
        if settings.hasContent(.xTitle) {
            xTitleText(settings.stringValue(.xTitle), x: plotPlane.hMid, y: positions.xTitleY)
        }
        if settings.hasContent(.yTitle) {
            yTitleText(settings.stringValue(.yTitle), x: positions.yTitleX, y: plotPlane.vMid)
        }
        if settings.boolValue(.legends) { legend() }
        if let subTitle = subTitleLookup() { subTitleText(subTitle) }
        if settings.hasContent(.title) { titleText() }

        if settings.boolValue(.draft) {
            plotter.plotText(
                x: width / 2.0, y: height / 2.0,
                text: settings.stringValue(.draftText),
                styles: stylesList.draft
            )
        }

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
            plotter.plotHead(positions: positions, clipPlane: clipPlane, stylesList: stylesList)
            let shapePath = Path([
                    PathComponent.moveTo(xy: Point(x: width / 2.0, y: height / 2.0)),
                    shape.pathComponent(w: shapeWidth)
                ]
            )
            plotter.plotPath(shapePath, styles: stylesList.plots[0], fill: false)
            plotter.plotTail()
        }
    }

    /// Generate a pie chart

    func pieGen() {
        func leftMargin(_ ct: Int) -> Double {
            let free = plotPlane.width - Double(ct) * side
            return floor(free / 2.0)
        }

        func topMargin() -> Double {
            let free = plotPlane.height - rows * side
            return floor(free / 2.0)
        }

        plotter.plotHead(positions: positions, clipPlane: clipPlane, stylesList: stylesList)

        let row1 = settings.intValue(.headerRows)
        let pieCt = csv.rowCt - row1

        // calculate the size of the squares that can fit in plotPlane
        // cols for number of columns, rows for number of rows and side for side of square
        // cols * side <= width
        // rows * side <= height
        // rows * cols >= count
        // rows² <= count * height/width
        var rows = ceil(sqrt(Double(pieCt) * plotPlane.height / plotPlane.width))
        let side = floor(plotPlane.height / rows)
        let cols = floor(plotPlane.width / side)
        if cols * (rows - 1) >= Double(pieCt) {
            rows -= 1
        }

        let maxRadiusX = side - sizes.pieLabel.size * 4.0
        let maxRadiusY = side - sizes.pieLabel.spacing * 2.0
        let radius = floor(min(maxRadiusX, maxRadiusY) * 0.4)

        var rowY = topMargin() - side / 2.0
        var colX = 0.0

        let colsPerRow = Int(cols)
        for row in row1..<csv.rowCt {
            if ((row - row1) % colsPerRow) == 0 {
                rowY += side
                colX = leftMargin(min(colsPerRow, csv.rowCt - row)) + side / 2.0
            }
            let centre = Point(x: colX, y: rowY)
            plotPie(row, settings.intValue(.headerColumns), centre: centre, radius: radius)
            colX += side
        }

        if settings.boolValue(.legends) { legend() }
        if let subTitle = subTitleLookup() { subTitleText(subTitle) }
        if settings.hasContent(.title) { titleText() }

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

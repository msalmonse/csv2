//
//  SVG/Gen.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-10.
//

import Foundation

extension Plot {

    /// Generate an  group with the plot lines

    func horizontalGroup() {
        plotter.plotClipStart(clipPlane: clipPlane)
        plotHorizontal()
        plotter.plotClipEnd()
    }

    /// Generate a horizontal chart

    private func horizontalGen() {
        plotter.plotHead(positions: positions, clipPlane: clipPlane, stylesList: stylesList)
        if settings.doubleValue(.xTick) >= 0 { xTick() }
        if settings.doubleValue(.yTick) >= 0 { yTick() }
        if settings.intValue(.xTagsHeader) >= 0 { xTags() }
        horizontalAxes()
        horizontalGroup()
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

    /// Generate a vertical chart

    private func verticalGen() {
        plotter.plotHead(positions: positions, clipPlane: clipPlane, stylesList: stylesList)
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

    private func pieGen() {
        plotter.plotHead(positions: positions, clipPlane: clipPlane, stylesList: stylesList)

        plotPies()

        if settings.boolValue(.legends) { legend() }
        if let subTitle = subTitleLookup() { subTitleText(subTitle) }
        if settings.hasContent(.title) { titleText() }

        plotter.plotTail()
    }

    /// Generate a chart

    func chartGen() {
        switch settings.chartType {
        case .pieChart: pieGen()
        case .horizontal: horizontalGen()
        case .vertical: verticalGen()
        }
    }
}

//
//  SVG/Gen.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-10.
//

import Foundation

extension Plot {

    /// Generate an  group with the plot lines
    /// - Returns: Array of SVG elements

    func lineGroup() -> String {
        let result = settings.inColumns ? columnPlot() : rowPlot()

        return plotter.plotGroup(plotPlane: plotPlane, lines: result.joined(separator: "\n"))
    }

    /// Generate a plotter document
    /// - Returns: array of string elements

    func gen() -> [String] {
        var result: [String] = []
        result.append(plotter.plotHead(positions: positions, plotPlane: plotPlane, propsList: propsList))
        if settings.dim.xTick >= 0 { result.append(xTick()) }
        if settings.dim.yTick >= 0 { result.append(yTick()) }
        result.append(axes())
        result.append(lineGroup())
        if settings.plotter.xTitle.hasContent {
            result.append(xTitleText(settings.plotter.xTitle, x: plotPlane.hMid, y: positions.xTitleY))
        }
        if settings.plotter.yTitle.hasContent {
            result.append(yTitleText(settings.plotter.yTitle, x: positions.yTitleX, y: plotPlane.vMid))
        }
        if settings.plotter.legends { result.append(legend()) }
        if let subTitle = subTitleLookup() { result.append(subTitleText(subTitle)) }
        if settings.plotter.title.hasContent { result.append(titleText()) }

        result.append(plotter.plotTail())

        return result
    }

    /// Generate an SVG to display a shape
    /// - Parameters:
    ///   - name: shape name
    ///   - colour: stroke colour
    /// - Returns: SVG as an array of strings

    func shapeGen(name: String, colour: String) -> [String] {
        var result: [String] = []
        if let shape = Shape.lookup(name) {
            var propsList = PropertiesList(count: 1, settings: settings)
            propsList.plots[0].cssClass = name
            propsList.plots[0].colour = colour
            result.append(plotter.plotHead(positions: positions, plotPlane: plotPlane, propsList: propsList))
            let shapePath = [
                PathCommand.moveTo(x: width/2.0, y: height/2.0),
                shape.pathCommand(w: shapeWidth)
            ]
            result.append(plotter.plotPath(shapePath, props: propsList.plots[0], fill: false))
            result.append(plotter.plotTail())
        }

        return result
    }
}

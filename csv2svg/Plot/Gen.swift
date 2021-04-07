//
//  SVG/Gen.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-10.
//

import Foundation

extension Plot {

    /// Generate an  group with the plot lines
    /// - Parameter ts: TransScale object
    /// - Returns: Array of SVG elements

    func lineGroup(_ ts: TransScale) -> String {
        let result = settings.inColumns ? columnPlot(ts) : rowPlot(ts)

        return plotter.plotGroup(lines: result.joined(separator: "\n"))
    }

    /// Generate a plotter document
    /// - Returns: array of string elements

    func gen() -> [String] {
        let ts = TransScale(from: dataPlane, to: plotPlane, logx: logx, logy: logy)

        var result: [String] = []
        result.append(plotter.plotHead(positions: positions, plotPlane: plotPlane, propsList: propsList))
        if settings.dim.xTick >= 0 { result.append(xTick(ts)) }
        if settings.dim.yTick >= 0 { result.append(yTick(ts)) }
        result.append(axes(ts))
        // if settings.plotter.logoURL.hasContent { result.append(logoImage()) }
        result.append(lineGroup(ts))
        if settings.plotter.xTitle.hasContent {
            result.append(xTitleText(settings.plotter.xTitle, x: plotPlane.hMid, y: positions.xTitleY))
        }
        if settings.plotter.yTitle.hasContent {
            result.append(yTitleText(settings.plotter.yTitle, x: positions.yTitleX, y: plotPlane.vMid))
        }
        // if settings.plotter.legends { result.append(legend()) }
        if subTitle.hasContent { result.append(subTitleText()) }
        if settings.plotter.title.hasContent { result.append(titleText()) }

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
            var props = Properties()
            props.cssClass = "shape"
            let shapePath = [
                PathCommand.moveTo(x: width/2.0, y: height/2.0),
                shape.pathCommand(w: shapeWidth)
            ]
            result.append(plotter.plotPath(shapePath, props: props))
        }

        return result
    }
}

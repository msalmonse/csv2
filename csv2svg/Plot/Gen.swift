//
//  SVG/Gen.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-10.
//

import Foundation

extension Plot {

    /// Generate an svg document
    /// - Returns: array of svg elements

    func gen() -> [String] {
        let ts = TransScale(from: dataPlane, to: plotPlane, logx: logx, logy: logy)

        var result: [String] = []
        result.append(plotter.plotHead())
        if settings.dim.xTick >= 0 { result.append(xTick(ts)) }
        if settings.dim.yTick >= 0 { result.append(yTick(ts)) }
        result.append(axes(ts))
        if settings.svg.logoURL.hasContent { result.append(logoImage()) }
        result.append(contentsOf: lineGroup(ts))
        if settings.svg.xTitle.hasContent {
            result.append(xTitleText(settings.svg.xTitle, x: plotPlane.hMid, y: positions.xTitleY))
        }
        if settings.svg.yTitle.hasContent {
            result.append(yTitleText(settings.svg.yTitle, x: positions.yTitleX, y: plotPlane.vMid))
        }
        if settings.svg.legends { result.append(legend()) }
        if subTitle.hasContent { result.append(subTitleText()) }
        if settings.svg.title.hasContent { result.append(titleText()) }

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

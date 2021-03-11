//
//  SVG/PlotCommon.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-07.
//

import Foundation
extension SVG {

    /// Plot a series of x and y values
    /// - Parameters:
    ///   - xValues: abscissa values
    ///   - yValues: ordinate values
    ///   - stroke: stroke colour
    ///   - shape: the shape to use for scattered pllots
    ///   - ts: TranScale object
    /// - Returns: Path String

    func plotCommon(
        _ xValues: [Double?],
        _ yValues: [Double?],
        stroke: String,
        shape: Shape?,
        ts: TransScale
    ) -> String {
        var pathPoints: [PathCommand] = []
        var move = true
        var single = false      // single point

        for i in settings.headers..<xValues.count {
            if xValues[i] == nil || i >= yValues.count || yValues[i] == nil {
                move = true
                if single {
                    pathPoints.append(.circle(r: shapeWidth))
                    single = false
                }
            } else {
                let xPos = ts.xpos(xValues[i]!)
                let yPos = ts.ypos(yValues[i]!)
                if shape != nil {
                    pathPoints.append(.moveTo(x: xPos, y: yPos))
                    pathPoints.append(shape!.pathCommand(w: shapeWidth))
                } else if move {
                    pathPoints.append(.moveTo(x: xPos, y: yPos))
                    move = false
                    single = true
                } else {
                    pathPoints.append(.lineTo(x: xPos, y: yPos))
                    single = false
                }
            }
        }
        return Self.svgPath(pathPoints, stroke: stroke, width: plotWidth)
    }
}

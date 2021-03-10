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
    ///   - ts: TranScale object
    /// - Returns: Path String

    func plotCommon(
        _ xValues: [Double?],
        _ yValues: [Double?],
        scattered: Bool,
        stroke: String,
        ts: TransScale
    ) -> String {
        var pathPoints: [PathCommand] = []
        var move = true
        var single = false      // single point
        let width = settings.strokeWidth
        let shapeWidth = Double(width)/2.0

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
                if scattered {
                    pathPoints.append(.circleAt(x: xPos, y: yPos, r: shapeWidth))
                }
                if move {
                    pathPoints.append(.moveTo(x: xPos, y: yPos))
                    move = false
                    single = true
                } else {
                    pathPoints.append(.lineTo(x: xPos, y: yPos))
                    single = false
                }
            }
        }
        return Self.svgPath(pathPoints, stroke: stroke, width: width)
    }
}

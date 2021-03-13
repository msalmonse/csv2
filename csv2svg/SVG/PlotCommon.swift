//
//  SVG/PlotCommon.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-07.
//

import Foundation
extension SVG {

    func posClip(_ pos: Point) -> Point {
        let minY = Double(settings.height) * -10.0
        let maxY = Double(settings.height) * 11.0
        if pos.y < minY { return Point(x: pos.x, y: minY) }
        if pos.y > maxY { return Point(x: pos.x, y: maxY) }
        return pos
    }

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
                let pos = posClip(ts.pos(x: xValues[i]!, y: yValues[i]!))
                if shape != nil {
                    pathPoints.append(.moveTo(x: pos.x, y: pos.y))
                    pathPoints.append(shape!.pathCommand(w: shapeWidth))
                } else if move {
                    pathPoints.append(.moveTo(x: pos.x, y: pos.y))
                    move = false
                    single = true
                } else {
                    pathPoints.append(.lineTo(x: pos.x, y: pos.y))
                    single = false
                }
            }
        }
        return Self.svgPath(pathPoints, stroke: stroke, width: plotWidth)
    }
}

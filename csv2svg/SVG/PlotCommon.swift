//
//  SVG/PlotCommon.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-07.
//

import Foundation
extension SVG {

    func posClip(_ pos: Point) -> (Point, Bool) {
        var x = pos.x
        var y = pos.y
        if x < allowedEdges.left { x = allowedEdges.left }
        if x > allowedEdges.right { x = allowedEdges.right }
        if y < allowedEdges.top { y = allowedEdges.top }
        if y > allowedEdges.bottom { y = allowedEdges.bottom }
        if x == pos.x && y == pos.y { return (pos, false) }
        return (Point(x: x, y: y), true)
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
        var clippedBefore = false

        for i in settings.headers..<xValues.count {
            if xValues[i] == nil || i >= yValues.count || yValues[i] == nil {
                if !clippedBefore && single {
                    pathPoints.append(.circle(r: shapeWidth))
                }
                move = true
                single = false
            } else {
                let (pos, clipped) = posClip(ts.pos(x: xValues[i]!, y: yValues[i]!))
                if clipped && clippedBefore { move = true }
                if !clipped && shape != nil {
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
                clippedBefore = clipped
            }
        }
        return Self.svgPath(pathPoints, stroke: stroke, width: plotWidth)
    }
}

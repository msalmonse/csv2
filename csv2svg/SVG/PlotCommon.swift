//
//  SVG/PlotCommon.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-07.
//

import Foundation
extension SVG {

    /// State of the plot

    enum PlotState {
        case move, moved, online, clipped, clipped2, scatter
    }

    /// Clip a position if it lies outside bounds
    /// - Parameter pos: position
    /// - Returns: new position and indicator of clipping

    private func posClip(_ pos: Point) -> (Point, Bool) {
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
    ///   - pointed: this plot has data points
    ///   - ts: TranScale object
    /// - Returns: Path String

// swiftlint:disable function_body_length

    func plotCommon(
        _ xValues: [Double?],
        _ yValues: [Double?],
        stroke: String,
        shape: Shape?,
        pointed: Bool = false,
        ts: TransScale
    ) -> String {
        var pathPoints: [PathCommand] = []
        var state: PlotState = (shape == nil || pointed) ? .move : .scatter
        var lastPos = Point.inf

        for i in settings.headers..<xValues.count {
            if xValues[i] == nil || i >= yValues.count || yValues[i] == nil {
                switch state {
                case .moved:
                    if !pointed { pathPoints.append(.circle(r: shapeWidth)) } // single data point so mark it
                    state = .move
                case .scatter, .clipped2: break
                default: state = .move
                }
            } else {
                let (pos, clipped) = posClip(ts.pos(x: xValues[i]!, y: yValues[i]!))
                if !clipped {
                    // move from a clipped state to an unclipped one
                    switch state {
                    case .clipped, .clipped2: state = .online
                    default: break
                    }
                }
                switch state {
                case .move:
                    pathPoints.append(.moveTo(x: pos.x, y: pos.y))
                    state = .moved
                    // Data point?
                    if !clipped && pointed && !pos.close(lastPos, limit: limit) {
                        pathPoints.append(shape!.pathCommand(w: shapeWidth))
                        lastPos = pos
                    }
                case .moved, .online:
                    pathPoints.append(.lineTo(x: pos.x, y: pos.y))
                    state = clipped ? .clipped : .online
                    // Data point?
                    if !clipped && pointed && !pos.close(lastPos, limit: limit) {
                        pathPoints.append(shape!.pathCommand(w: shapeWidth))
                        lastPos = pos
                    }
                case .clipped:
                    // Draw line even if previously clipped but not if clipped now
                    if clipped {
                        state = .clipped2
                    } else {
                        pathPoints.append(.lineTo(x: pos.x, y: pos.y))
                        state = clipped ? .clipped2 : .online
                    }
                    // Data point?
                    if !clipped && pointed && !pos.close(lastPos, limit: limit) {
                        pathPoints.append(shape!.pathCommand(w: shapeWidth))
                        lastPos = pos
                    }
                case .scatter:
                    if !clipped {
                        pathPoints.append(.moveTo(x: pos.x, y: pos.y))
                        pathPoints.append(shape!.pathCommand(w: shapeWidth))
                    }
                case .clipped2:
                    // Ignore all data till we are not clipped, just move
                    pathPoints.append(.moveTo(x: pos.x, y: pos.y))
                }
            }
        }
        return Self.svgPath(pathPoints, stroke: stroke, width: plotWidth)
    }
}

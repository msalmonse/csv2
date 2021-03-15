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

    /// Common state

    private class CommonState {
        var pathPoints: [PathCommand] = []
        var lastPos = Point.inf
        var state: PlotState
        let plotShape: PathCommand

        init(_ scattered: Bool, _ plotShape: PathCommand) {
            state = scattered ? .scatter : .move
            self.plotShape = plotShape
        }
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
    ///   - xiValues: abscissa values
    ///   - yValues: ordinate values
    ///   - stroke: stroke colour
    ///   - shape: the shape to use for scattered pllots
    ///   - pointed: this plot has data points
    ///   - ts: TranScale object
    /// - Returns: Path String

    func plotCommon(
        _ xiValues: [XIvalue],
        _ yValues: [Double?],
        stroke: String,
        shape: Shape?,
        pointed: Bool = false,
        ts: TransScale
    ) -> String {
        var commonState = CommonState(
            (shape != nil && !pointed),
            shape?.pathCommand(w: shapeWidth) ?? .circle(r: shapeWidth)
        )

        for i in settings.headers..<xiValues.count {
            let x = xiValues[i].x
            let j = xiValues[i].i
            let y = j < yValues.count ? yValues[j] : nil
            if x == nil ||  y == nil {
                switch commonState.state {
                case .moved:
                    // single data point so mark it
                    if !pointed { commonState.pathPoints.append(commonState.plotShape) }
                    commonState.state = .move
                case .scatter, .clipped2: break
                default: commonState.state = .move
                }
            } else {
                let (pos, clipped) = posClip(ts.pos(x: x!, y: y!))
                plotOne(
                    pos: pos, clipped: clipped,
                    pointed: pointed,
                    commonState: &commonState
                )
            }
        }
        return Self.svgPath(commonState.pathPoints, stroke: stroke, width: plotWidth)
    }

    /// Plot a single point, mainly to reduce the size of plotCommon()
    /// - Parameters:
    ///   - pos: position to plot
    ///   - clipped: has the position been clipped?
    ///   - pointed: plot data points?
    ///   - commonState: the state shared with plotCommon

    private func plotOne(
        pos: Point,
        clipped: Bool,
        pointed: Bool,
        commonState: inout CommonState
    ) {
        if !clipped {
            // move from a clipped state to an unclipped one
            switch commonState.state {
            case .clipped, .clipped2: commonState.state = .online
            default: break
            }
        }
        switch commonState.state {
        case .move:
            commonState.pathPoints.append(.moveTo(x: pos.x, y: pos.y))
            commonState.state = .moved
            // Data point?
            if !clipped && pointed && !pos.close(commonState.lastPos, limit: limit) {
                commonState.pathPoints.append(commonState.plotShape)
                commonState.lastPos = pos
            }
        case .moved, .online:
            commonState.pathPoints.append(.lineTo(x: pos.x, y: pos.y))
            commonState.state = clipped ? .clipped : .online
            // Data point?
            if !clipped && pointed && !pos.close(commonState.lastPos, limit: limit) {
                commonState.pathPoints.append(commonState.plotShape)
                commonState.lastPos = pos
            }
        case .clipped:
            // Draw line even if previously clipped but not if clipped now
            if clipped {
                commonState.state = .clipped2
            } else {
                commonState.pathPoints.append(.lineTo(x: pos.x, y: pos.y))
                commonState.state = clipped ? .clipped2 : .online
            }
            // Data point?
            if !clipped && pointed && !pos.close(commonState.lastPos, limit: limit) {
                commonState.pathPoints.append(commonState.plotShape)
                commonState.lastPos = pos
            }
        case .scatter:
            if !clipped {
                commonState.pathPoints.append(.moveTo(x: pos.x, y: pos.y))
                commonState.pathPoints.append(commonState.plotShape)
            }
        case .clipped2:
            // Ignore all data till we are not clipped, just move
            commonState.pathPoints.append(.moveTo(x: pos.x, y: pos.y))
        }
    }
}

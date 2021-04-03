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

    private class PlotCommonState {
        var pathPoints: [PathCommand] = []
        var shapePoints: [PathCommand] = []
        var prevDataPoint = Point.inf
        var prevPlotPoint = Point.inf
        var state: PlotState
        let props: PathProperties

        let limit: Double
        let ts: TransScale

        init(
            props: PathProperties,
            ts: TransScale,
            limit: Double
        ) {
            self.ts = ts
            self.limit = limit
            self.props = props
            state = props.scattered ? .scatter : .move
        }

        /// Handle an x or y of nil

        func nilPlot(_ plotShape: PathCommand) {
            switch state {
            case .moved:
                // single data point so mark it
                if !props.pointed { shapePoints.append(plotShape) }
                state = .move
            case .scatter, .clipped2: break
            default: state = .move
            }
        }

        /// Plot a single point
        /// - Parameters:
        ///   - pos: position to plot
        ///   - clipped: was pos clipped?

        func plotOne(
            _ pos: Point,
            clipped: Bool,
            plotShape: PathCommand
        ) {
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
                shapePoints.append(.moveTo(x: pos.x, y: pos.y))
                state = .moved
                // Data point?
                if !clipped && props.pointed && !pos.close(prevDataPoint, limit: limit) {
                    shapePoints.append(plotShape)
                    prevDataPoint = pos
                }
            case .moved, .online:
                pathPoints.append(.lineTo(x: pos.x, y: pos.y))
                state = clipped ? .clipped : .online
                // Data point?
                if !clipped && props.pointed && !pos.close(prevDataPoint, limit: limit) {
                    shapePoints.append(.moveTo(x: pos.x, y: pos.y))
                    shapePoints.append(plotShape)
                    prevDataPoint = pos
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
                if !clipped && props.pointed && !pos.close(prevDataPoint, limit: limit) {
                    shapePoints.append(.moveTo(x: pos.x, y: pos.y))
                    shapePoints.append(plotShape)
                    prevDataPoint = pos
                }
            case .scatter:
                if !clipped {
                    shapePoints.append(.moveTo(x: pos.x, y: pos.y))
                    shapePoints.append(plotShape)
                }
            case .clipped2:
                // Ignore all data till we are not clipped, just move
                pathPoints.append(.moveTo(x: pos.x, y: pos.y))
            }
            prevPlotPoint = pos
        }
    }

    /// Clip a position if it lies outside bounds
    /// - Parameter pos: position
    /// - Returns: new position and indicator of clipping

    private func posClip(_ pos: Point) -> (Point, Bool) {
        var x = pos.x
        var y = pos.y
        if x < allowedPlane.left { x = allowedPlane.left }
        if x > allowedPlane.right { x = allowedPlane.right }
        if y < allowedPlane.top { y = allowedPlane.top }
        if y > allowedPlane.bottom { y = allowedPlane.bottom }
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
        _ props: PathProperties,
        ts: TransScale
    ) -> String {
        let state = PlotCommonState(
            props: props,
            ts: ts,
            limit: limit
        )
        var yɑ = Double.infinity
        let plotShape = props.shape?.pathCommand(w: shapeWidth) ?? .circleStar(w: shapeWidth)

        func xypos(_ i: Int) -> Point? {
            guard xiValues.hasIndex(i) else { return nil }
            guard let x = xiValues[i].x else { return nil }
            let j = xiValues[i].i
            guard yValues.hasIndex(j), let y = yValues[j] else { return nil }
            return Point(x: x, y: y)
        }

        for i in settings.headers..<xiValues.count {
            var pos = xypos(i)
            if pos == nil {
                state.nilPlot(plotShape)
            } else {
                if settings.plot.smooth > 0.0 {
                    // Use exponential moving average
                    if yɑ != Double.infinity {
                        pos = Point(x: pos!.x, y: (1 - settings.plot.smooth) * pos!.y + yɑ)
                    }
                    yɑ = pos!.y * settings.plot.smooth
                }
                let (pos, clipped) = posClip(ts.pos(pos!))
                state.plotOne(pos, clipped: clipped, plotShape: plotShape)
            }
        }
        state.nilPlot(plotShape)        // handle any trailing singletons
        return Self.path(state.pathPoints + state.shapePoints, cssClass: props.cssClass!)
    }
}

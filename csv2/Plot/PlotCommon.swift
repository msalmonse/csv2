//
//  SVG/PlotCommon.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-07.
//

import Foundation
extension Plot {

    /// State of the plot

    enum PlotState {
        case move, moved, online, clipped, clipped2, scatter, staple
    }

    /// Common state

    private class PlotCommonState {
        var pathPoints: [PathCommand] = []
        var shapePoints: [PathCommand] = []
        var prevDataPoint = Point.inf
        var prevPlotPoint = Point.inf
        var state: PlotState
        let props: Properties
        let staple: Staple?

        let limit: Double
        let ts: TransScale

        init(
            props: Properties,
            ts: TransScale,
            limit: Double,
            staple: Staple?
        ) {
            self.ts = ts
            self.limit = limit
            self.props = props
            self.staple = staple

            switch (props.scattered, props.staple > 0, staple == nil) {
            case (true,_,_): state = .scatter
            case(false,true,true): state = .staple
            default: state = .move
            }
        }

        /// Handle an x or y of nil

        func nilPlot(_ plotShape: PathCommand) {
            switch state {
            case .moved:
                // single data point so mark it
                if !props.pointed { shapePoints.append(plotShape) }
                state = .move
            case .scatter, .staple, .clipped2: break
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
            nextPlotPoint: Point?,
            pos0: Point?,
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
                if props.bezier == 0.0 || nextPlotPoint == nil {
                    pathPoints.append(.lineTo(x: pos.x, y: pos.y))
                } else {
                    // calculate the start of the quadratic bézier curve
                    let qStart = pos.partWay(prevPlotPoint, part: props.bezier)
                    let qEnd = pos.partWay(nextPlotPoint!, part: props.bezier)
                    pathPoints.append(.lineTo(x: qStart.x, y: qStart.y))
                    pathPoints.append(.qBezierTo(x: qEnd.x, y: qEnd.y, cx: pos.x, cy: pos.y))
                }
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
            case .staple:
                if let p0 = pos0 {
                    shapePoints.append(staple!.path(p0: p0, y: pos.y, props.staple))
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
        _ props: Properties,
        ts: TransScale,
        staple: Staple?
    ) -> String {
        let state = PlotCommonState(
            props: props,
            ts: ts,
            limit: limit,
            staple: staple
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
            var pos0: Point? = nil
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
                var nextPos = xypos(i + 1)
                if nextPos != nil { (nextPos, _) = posClip(ts.pos(nextPos!)) }
                if props.staple >= 0 && staple != nil { (pos0, _) = posClip(Point(x: pos.x, y: 0.0)) }
                state.plotOne(pos, clipped: clipped, nextPlotPoint: nextPos, pos0: pos0, plotShape: plotShape)
            }
        }
        state.nilPlot(plotShape)        // handle any trailing singletons
        return plotter.plotPath(state.pathPoints + state.shapePoints, props: props, fill: false)
    }
}

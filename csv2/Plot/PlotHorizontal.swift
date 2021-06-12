//
//  PlotHorizontal.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-07.
//

import Foundation

extension Plot {

    /// State of the plot

    enum PlotState {
        case bar, move, moved, online, clipped, clipped2, scatter
    }

    /// Common state

    private class PlotCommonState {
        var pathComponents = Path()
        var shapeComponents = Path()
        var prevDataPoint = Point.inf
        var prevPlotPoint = Point.inf
        var prevPosPosition = Plane.PointPosition()
        var state: PlotState
        let styles: Styles
        weak var plot: Plot?
        let bar: Bar?

        let limit: Double
        let ts: TransScale

        init(
            styles: Styles,
            ts: TransScale,
            limit: Double,
            plot: Plot,
            bar: Bar?
        ) {
            self.ts = ts
            self.limit = limit
            self.styles = styles
            self.plot = plot
            self.bar = bar

            switch (styles.options[.scattered], styles.bar >= 0, bar != nil) {
            case (true,_,_): state = .scatter
            case(false,true,true): state = .bar
            default: state = .move
            }
        }

        /// Close the current if filling

        func closePath() {
            pathComponents.append(.vertTo(y: plot!.point00.y))
            pathComponents.append(.closePath)
        }

        /// Handle an x or y of nil
        /// - Parameter plotShape: shape to plot if necessary

        func nilPlot(_ plotShape: PathComponent) {
            switch state {
            case .moved:
                // single data point so mark it
                if !styles.options[.pointed] {
                    shapeComponents.append(.moveTo(xy: prevPlotPoint))
                    shapeComponents.append(plotShape)
                }
                state = .move
            case .scatter, .bar, .clipped2:
                if !styles.options[.filled] { break }
                fallthrough
            case .online:
                if styles.options[.filled] { closePath() }
                state = .move
            default:
                state = .move
            }
        }

        /// Add a data point
        /// - Parameters:
        ///   - plotShape: shape to use
        ///   - pos: where to add it
        ///   - clipped: was pos clipped?

        func addDataPoint(_ plotShape: PathComponent, at pos: Point, clipped: Bool) {
            if !clipped && styles.options[.pointed] && !pos.close(prevDataPoint, limit: limit) {
                shapeComponents.append(.moveTo(xy: pos))
                shapeComponents.append(plotShape)
                prevDataPoint = pos
            }
        }

        /// Plot a single point
        /// - Parameters:
        ///   - pos: position to plot
        ///   - clipped: was pos clipped?

        func plotOne(
            _ pos: Point,
            _ posPosition: Plane.PointPosition,
            nextPlotPoint: Point?,
            plotShape: PathComponent
        ) {
            let clipped = !posPosition.isInside
            let filled = styles.options[.filled]
            let traversed = posPosition.hasTraversed(prevPosPosition)

            if !clipped {
                // move from a clipped state to an unclipped one
                switch state {
                case .clipped, .clipped2:
                    state = .online
                default: break
                }
            }

            switch state {
            case .move:
                if filled {
                    pathComponents.append(.moveTo(xy: Point(x: pos.x, y: plot!.point00.y)))
                    pathComponents.append(.lineTo(xy: pos))
                } else {
                    pathComponents.append(.moveTo(xy: pos))
                }
                state = .moved
                // Data point?
                addDataPoint(plotShape, at: pos, clipped: clipped)
            case .moved, .online:
                if styles.bezier == 0.0 || nextPlotPoint == nil {
                    pathComponents.append(.lineTo(xy: pos))
                } else {
                    // calculate the start of the quadratic bézier curve
                    let qStart = pos.partWay(prevPlotPoint, part: styles.bezier)
                    let qEnd = pos.partWay(nextPlotPoint!, part: styles.bezier)
                    pathComponents.append(.lineTo(xy: qStart))
                    pathComponents.append(.qBezierTo(xy: qEnd, cxy: pos))
                }
                state = clipped ? .clipped : .online
                // Data point?
                addDataPoint(plotShape, at: pos, clipped: clipped)
            case .clipped:
                // Draw line even if previously clipped but not if clipped now
                pathComponents.append(.lineTo(xy: pos))
                if clipped {
                    state = .clipped2
                } else {
                    state = .online
                }
                // Data point?
                addDataPoint(plotShape, at: pos, clipped: clipped)
            case .scatter:
                if !clipped {
                    shapeComponents.append(.moveTo(xy: pos))
                    shapeComponents.append(plotShape)
                }
            case .bar:
                if let (p0, _) = plot?.posClip(Point(x: pos.x, y: plot?.point00.y ?? 0.0)) {
                    pathComponents.append(bar!.path(p0: p0, y: pos.y, styles.bar))
                }
            case .clipped2:
                if filled {
                    if traversed {
                        closePath()
                        pathComponents.append(.moveTo(xy: Point(x: pos.x, y: plot!.point00.y)))
                        pathComponents.append(.lineTo(xy: pos))
                    } else {
                        pathComponents.append(.lineTo(xy: pos))
                    }
                } else {
                    pathComponents.append(.moveTo(xy: pos))
                }
            }
            prevPlotPoint = pos
            prevPosPosition = posPosition
        }
    }

    /// Clip a position if it lies outside bounds
    /// - Parameter pos: position
    /// - Returns: new position and indicator of clipping

    private func posClip(_ pos: Point) -> (Point, Plane.PointPosition) {
        let posPosition = allowedPlane.position(pos)
        var x = pos.x
        var y = pos.y
        if  posPosition[.left] { x = allowedPlane.left }
        if posPosition[.right] { x = allowedPlane.right }
        if posPosition[.above] { y = allowedPlane.top }
        if posPosition[.below] { y = allowedPlane.bottom }

        return (Point(x: x, y: y), posPosition)
    }

    /// Plot a series of x and y values
    /// - Parameters:
    ///   - xiValues: abscissa values
    ///   - yValues: ordinate values
    ///   - styles: plot properties
    ///   - staple: staple diagram details

    func onePlot(
        _ xiValues: [XIvalue],
        _ yValues: [Double?],
        _ styles: Styles,
        bar: Bar?
    ) {
        let state = PlotCommonState(
            styles: styles,
            ts: ts,
            limit: limit,
            plot: self,
            bar: bar
        )
        var yɑ = Double.infinity
        let plotShape = styles.shape?.pathComponent(w: shapeWidth) ?? .circleStar(w: shapeWidth)
        let smooth = settings.doubleValue(.smooth)

        func xypos(_ i: Int) -> Point? {
            guard xiValues.hasIndex(i), let x = xiValues[i].x else { return nil }
            let j = xiValues[i].i
            guard yValues.hasIndex(j), let y = yValues[j] else { return nil }
            return Point(x: x, y: y)
        }

        for i in settings.intValue(.headerColumns)..<xiValues.count {
            var pos = xypos(i)
            if pos == nil {
                state.nilPlot(plotShape)
            } else {
                if smooth > 0.0 {
                    // Use exponential moving average
                    if yɑ != Double.infinity {
                        pos = Point(x: pos!.x, y: (1 - smooth) * pos!.y + yɑ)
                    }
                    yɑ = pos!.y * smooth
                }
                let (pos, posPosition) = posClip(ts.pos(pos!))
                var nextPos = xypos(i + 1)
                if nextPos != nil { (nextPos, _) = posClip(ts.pos(nextPos!)) }
                state.plotOne(pos, posPosition, nextPlotPoint: nextPos, plotShape: plotShape)
            }
        }
        state.nilPlot(plotShape)        // handle any trailing singletons
        var plotProps = styles
        let fill = plotProps.bar >= 0 || styles.options[.filled]
        if fill {
            if let rgba = plotProps.fill {
                plotProps.fill = rgba.multiplyingBy(alpha: 0.75)
            }
        }
        plotter.plotPath(state.pathComponents, styles: plotProps, fill: fill)
        plotter.plotPath(state.shapeComponents, styles: plotProps, fill: false)
    }

    /// Plot the non-index and non header rows

    func plotHorizontal() {
        let xiValues = settings.boolValue(.sortx) ? xiList().sorted() : xiList()
        let bar = barGet(xiValues)
        for i in 0..<csv.rowCt where i != index && stylesList.plots[i].options[.included] {
            let yValues = csv.rowValues(i)
            onePlot(
                xiValues, yValues,
                stylesList.plots[i],
                bar: bar
            )
        }
    }
}

//
//  SvgAxes.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-01.
//

import Foundation

extension SVG {

    /// Draw axes
    /// - Parameter ts: scaling and tranlating object
    /// - Returns: paths with axes

    func svgAxes(_ ts: TransScale) -> String {
        var path: [PathCommand] = []

        if dataEdges.inVert(0.0) {
            path.append(.moveTo(x: plotEdges.left, y: ts.ypos(0.0)))
            path.append(.horizTo(x: plotEdges.right))
        }
        if dataEdges.inHoriz(0.0) {
            path.append(.moveTo(x: ts.xpos(0), y: plotEdges.bottom))
            path.append(.vertTo(y: plotEdges.top))
        }

        return Self.svgPath(path, stroke: "Black", width: settings.strokeWidth)
    }

    /// Normalize tick value
    /// - Parameters:
    ///   - tick: tick specified
    ///   - dataDiff: data value range
    ///   - posDiff: plottable dimension
    /// - Returns: new tick value

    func tickNorm(_ tick: Int, dataDiff: Double, posDiff: Double) -> Double {
        let dpp = dataDiff/posDiff  // data per pixel - how much data does each pixel show
        let spacing = Double(tick)
        if spacing/dpp > 15.0 { return spacing }
        return (15.0 * dpp).rounded(.awayFromZero)
    }

    /// Draw vertical ticks
    /// - Parameter ts: scaling and translating object
    /// - Returns: path for the ticks

    func svgXtick(_ ts: TransScale) -> String {
        var path: [PathCommand] = []
        var labels = [""]
        let tick = tickNorm(settings.xTick, dataDiff: dataEdges.width, posDiff: plotEdges.width)
        var x = tick    // the zero line is plotted by svgAxes
        let xMax = max(dataEdges.right, -dataEdges.left)

        while x <= xMax {
            if dataEdges.inHoriz(x) {
                path.append(.moveTo(x: ts.xpos(x), y: plotEdges.bottom))
                path.append(.vertTo(y: plotEdges.top))
                labels.append(xLabel(label(x), x: ts.xpos(x), y: xTicksY))
            }
            if dataEdges.inHoriz(-x) {
                path.append(.moveTo(x: ts.xpos(-x), y: plotEdges.bottom))
                path.append(.vertTo(y: plotEdges.top))
                labels.append(xLabel(label(-x), x: ts.xpos(-x), y: xTicksY))
            }
            x += tick
        }

        return Self.svgPath(path, stroke: "Silver") + labels.joined(separator: "\n")
    }

    /// Draw horizontal ticks
    /// - Parameter ts: scaling and translating object
    /// - Returns: path for the ticks

    func svgYtick(_ ts: TransScale) -> String {
        var path: [PathCommand] = []
        var labels = [""]
        let tick = tickNorm(settings.yTick, dataDiff: dataEdges.height, posDiff: plotEdges.height)
        var y = tick    // the zero line is plotted by svgAxes
        let yMax = max(dataEdges.top, -dataEdges.bottom)
        let labelEnd = plotEdges.left - 2

        while y <= yMax {
            if dataEdges.inVert(y) {
                path.append(.moveTo(x: plotEdges.left, y: ts.ypos(y)))
                path.append(.horizTo(x: plotEdges.right))
                labels.append(yLabel(label(y), x: labelEnd, y: ts.ypos(y)))
            }
            if dataEdges.inVert(-y) {
                path.append(.moveTo(x: plotEdges.left, y: ts.ypos(-y)))
                path.append(.horizTo(x: plotEdges.right))
                labels.append(yLabel(label(-y), x: labelEnd, y: ts.ypos(-y)))
            }
            y += tick
        }

        return Self.svgPath(path, stroke: "Silver") + labels.joined(separator: "\n")
    }
}

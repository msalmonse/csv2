//
//  SVG/Axes.swift
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

        return Self.svgPath(path, stroke: "Black", width: plotWidth)
    }

    /// Normalize tick value
    /// - Parameters:
    ///   - tick: tick specified
    ///   - dpp: data per pixel - how much data does each pixel show
    ///   - minSize: minimum number of pixels between ticks allowed
    ///   - maxSize: maximum number of pixels between ticks allowed
    /// - Returns: new tick value

    private func tickNorm(_ tick: Double, dpp: Double, minSize: Double, maxSize: Double) -> Double {
        let ppt = tick/dpp      // pixels per tick
        if ppt >= minSize && ppt <= maxSize { return tick }
        let raw = minSize * dpp
        // calculate the power of 10 less than the raw tick
        let pow10 = exp(floor(log10(raw)) * log(10))
        var norm = ceil(raw/pow10) * pow10
        if norm > 0.1 && norm < 1.0 { norm = 1.0 }  // < .01 is where labels use e format
        // return the tick as an an integer times the power of 10
        return norm
    }

    /// Draw vertical ticks
    /// - Parameter ts: scaling and translating object
    /// - Returns: path for the ticks

    func svgXtick(_ ts: TransScale) -> String {
        var path: [PathCommand] = []
        var labels = [""]
        let tick = tickNorm(
            settings.xTick,
            dpp: dataEdges.width/plotEdges.width,
            minSize: settings.labelSize * 3.0,
            maxSize: plotEdges.width/5.0
        )
        var x = tick    // the zero line is plotted by svgAxes
        let xMax = max(dataEdges.right, -dataEdges.left)

        while x <= xMax {
            if dataEdges.inHoriz(x) {
                path.append(.moveTo(x: ts.xpos(x), y: plotEdges.bottom))
                path.append(.vertTo(y: plotEdges.top))
                labels.append(xLabel(label(x), x: ts.xpos(x), y: positions.xTicksY))
            }
            if dataEdges.inHoriz(-x) {
                path.append(.moveTo(x: ts.xpos(-x), y: plotEdges.bottom))
                path.append(.vertTo(y: plotEdges.top))
                labels.append(xLabel(label(-x), x: ts.xpos(-x), y: positions.xTicksY))
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
        let tick = tickNorm(
            settings.yTick,
            dpp: dataEdges.height/plotEdges.height,
            minSize: settings.labelSize * 1.25,
            maxSize: plotEdges.height/5.0
        )
        var y = tick    // the zero line is plotted by svgAxes
        let yMax = max(dataEdges.top, -dataEdges.bottom)

        while y <= yMax {
            if dataEdges.inVert(y) {
                path.append(.moveTo(x: plotEdges.left, y: ts.ypos(y)))
                path.append(.horizTo(x: plotEdges.right))
                labels.append(yLabel(label(y), x: positions.yTickX, y: ts.ypos(y)))
            }
            if dataEdges.inVert(-y) {
                path.append(.moveTo(x: plotEdges.left, y: ts.ypos(-y)))
                path.append(.horizTo(x: plotEdges.right))
                labels.append(yLabel(label(-y), x: positions.yTickX, y: ts.ypos(-y)))
            }
            y += tick
        }

        return Self.svgPath(path, stroke: "Silver") + labels.joined(separator: "\n")
    }
}

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

    func axes(_ ts: TransScale) -> String {
        var path: [PathCommand] = []
        let x0 = logy ? 1.0 : 0.0
        let y0 = logx ? 1.0 : 0.0

        if dataPlane.inVert(x0) {
            path.append(.moveTo(x: plotPlane.left, y: ts.ypos(x0)))
            path.append(.horizTo(x: plotPlane.right))
        }
        if dataPlane.inHoriz(y0) {
            path.append(.moveTo(x: ts.xpos(y0), y: plotPlane.bottom))
            path.append(.vertTo(y: plotPlane.top))
        }

        return Self.path(path, cssClass: "axes")
    }

    /// Normalize tick value
    /// - Parameters:
    ///   - tick: tick specified
    ///   - dpp: data per pixel - how much data does each pixel show
    ///   - minSize: minimum number of pixels between ticks allowed
    ///   - maxSize: maximum number of pixels between ticks allowed
    ///   - isLog: is this tick logarithmic?
    /// - Returns: new tick value

    private func tickNorm(
        _ tick: Double,
        dpp: Double,
        minSize: Double,
        maxSize: Double,
        isLog: Bool = false
    ) -> Double {
        let dppLocal = isLog ? log10(dpp) : dpp
        let ppt = tick/dppLocal      // pixels per tick
        if ppt >= minSize && ppt <= maxSize { return tick }
        let raw = minSize * dppLocal
        var norm = 0.0
        if raw > 0.0 {
            // calculate the power of 10 less than the raw tick
            let pow10 = pow(10.0, floor(log10(raw)))
            norm = pow10
            // return the tick as an an integer times the power of 10 if not lag axis
            if !isLog { norm *= ceil(raw/pow10) }
            if norm > 0.1 && norm < 1.0 { norm = 1.0 }  // < .1 is where labels use e format
        } else {
            // raw is -ve as values are less than zero
            // make it smaller than we must to get as many ticks as we can
            norm = pow(10.0, floor(log10(dpp * minSize)) - 1.0)
        }
        return norm
    }

    /// Draw vertical ticks
    /// - Parameter ts: scaling and translating object
    /// - Returns: path for the ticks

    func xTick(_ ts: TransScale) -> String {
        var path: [PathCommand] = []
        var labels = [""]
        var tick = tickNorm(
            settings.xTick,
            dpp: dataPlane.width/plotPlane.width,
            minSize: settings.labelSize * 3.5,
            maxSize: plotPlane.width/5.0,
            isLog: logx
        )
        let intTick = (tick.rounded() == tick)
        var x = tick    // the zero line is plotted by svgAxes
        let xMax = max(dataPlane.right, -dataPlane.left) + tick * 0.5 // fudge a little for strange tick values

        while x <= xMax {
            if dataPlane.inHoriz(x) {
                path.append(.moveTo(x: ts.xpos(x), y: plotPlane.bottom))
                path.append(.vertTo(y: plotPlane.top))
                labels.append(xLabelText(label(x, intTick), x: ts.xpos(x), y: positions.xTicksY))
            }
            if dataPlane.inHoriz(-x) {
                path.append(.moveTo(x: ts.xpos(-x), y: plotPlane.bottom))
                path.append(.vertTo(y: plotPlane.top))
                labels.append(xLabelText(label(-x, intTick), x: ts.xpos(-x), y: positions.xTicksY))
            }
            x += tick
            if logx && x > 10.0 * tick {
                tick *= 10.0
                x = tick
            }
        }

        return Self.path(path, cssClass: "xtick") + labels.joined(separator: "\n")
    }

    /// Draw horizontal ticks
    /// - Parameter ts: scaling and translating object
    /// - Returns: path for the ticks

    func yTick(_ ts: TransScale) -> String {
        var path: [PathCommand] = []
        var labels = [""]
        var tick = tickNorm(
            settings.yTick,
            dpp: dataPlane.height/plotPlane.height,
            minSize: settings.labelSize * 1.25,
            maxSize: plotPlane.height/5.0,
            isLog: logy
        )
        let intTick = (tick.rounded() == tick)
        var y = tick    // the zero line is plotted by svgAxes
        let yMax = max(dataPlane.top, -dataPlane.bottom)

        while y <= yMax {
            if dataPlane.inVert(y) {
                path.append(.moveTo(x: plotPlane.left, y: ts.ypos(y)))
                path.append(.horizTo(x: plotPlane.right))
                labels.append(yLabelText(label(y, intTick), x: positions.yTickX, y: ts.ypos(y)))
            }
            if dataPlane.inVert(-y) {
                path.append(.moveTo(x: plotPlane.left, y: ts.ypos(-y)))
                path.append(.horizTo(x: plotPlane.right))
                labels.append(yLabelText(label(-y, intTick), x: positions.yTickX, y: ts.ypos(-y)))
            }
            y += tick
            if logy && y > 10.0 * tick {
                tick *= 10.0
                y = tick
            }
        }

        return Self.path(path, cssClass: "ytick") + labels.joined(separator: "\n")
    }
}

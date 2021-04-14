//
//  SVG/Axes.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-01.
//

import Foundation

extension Plot {

    /// Draw axes
    /// - Returns: paths with axes

    func axes() -> String {
        var axesPath: [PathCommand] = []
        let x0 = logy ? 1.0 : 0.0
        let y0 = logx ? 1.0 : 0.0

        if dataPlane.inVert(x0) {
            axesPath.append(.moveTo(x: plotPlane.left, y: ts.ypos(x0)))
            axesPath.append(.horizTo(x: plotPlane.right))
        }
        if dataPlane.inHoriz(y0) {
            axesPath.append(.moveTo(x: ts.xpos(y0), y: plotPlane.bottom))
            axesPath.append(.vertTo(y: plotPlane.top))
        }

        return plotter.plotPath(axesPath, props: propsList.axes, fill: false)
    }

    /// Draw abcissa tags
    /// - Returns: String to draw tags

    func xTags() -> String {
        let xiValues = xiList()
        let k = settings.csv.xTagHeader
        var tagsPath: [PathCommand] = []
        var labels = [""]

        /// Fetch text from csv data
        /// - Parameters:
        ///   - i1: one index
        ///   - i2: the other index
        /// - Returns: text if everything is OK

        func getText(_ i1: Int, _ i2: Int) -> String {
            if settings.inRows {
                if csv.data.hasIndex(i2) && csv.data[i2].hasIndex(i1) {
                    return csv.data[i2][i1]
                } else {
                    return ""
                }
            } else {
                if csv.data.hasIndex(i1) && csv.data[i1].hasIndex(i2) {
                    return csv.data[i1][i2]
                } else {
                    return ""
                }
            }
        }

        for i in xiValues.indices where i >= settings.headers {
            if let x = xiValues[i].x, dataPlane.inHoriz(x) {
                let j = xiValues[i].i
                let text = getText(j, k)
                if  text.hasContent {
                    let xpos = ts.xpos(x)
                    tagsPath.append(.moveTo(x: xpos, y: positions.xTagsTopY))
                    tagsPath.append(.vertTo(y: plotPlane.top))
                    labels.append(
                        plotter.plotText(x: xpos, y: positions.xTagsY, text: text,
                                         props: propsList.xLabel
                        )
                    )
                }
            }
        }
        return plotter.plotPath(tagsPath, props: propsList.xLabel, fill: false)
            + labels.joined(separator: "\n")
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
    /// - Returns: path for the ticks

    func xTick() -> String {
        var tickPath: [PathCommand] = []
        var labels = [""]
        var tick = tickNorm(
            settings.dim.xTick,
            dpp: dataPlane.width/plotPlane.width,
            minSize: labelSize * 3.5,
            maxSize: plotPlane.width/5.0,
            isLog: logx
        )
        let intTick = (tick.rounded() == tick)
        var x = tick    // the zero line is plotted by svgAxes
        let xMax = max(dataPlane.right, -dataPlane.left) + tick * 0.5 // fudge a little for strange tick values

        while x <= xMax {
            if dataPlane.inHoriz(x) {
                tickPath.append(.moveTo(x: ts.xpos(x), y: plotPlane.bottom))
                tickPath.append(.vertTo(y: plotPlane.top))
                labels.append(xLabelText(label(x, intTick), x: ts.xpos(x), y: positions.xTicksY))
            }
            if dataPlane.inHoriz(-x) {
                tickPath.append(.moveTo(x: ts.xpos(-x), y: plotPlane.bottom))
                tickPath.append(.vertTo(y: plotPlane.top))
                labels.append(xLabelText(label(-x, intTick), x: ts.xpos(-x), y: positions.xTicksY))
            }
            x += tick
            if logx && x > 10.0 * tick {
                tick *= 10.0
                x = tick
            }
        }

        return plotter.plotPath(tickPath, props: propsList.xLabel, fill: false) + labels.joined(separator: "\n")
    }

    /// Draw horizontal ticks
    /// - Returns: path for the ticks

    func yTick() -> String {
        var tickPath: [PathCommand] = []
        var labels = [""]
        var tick = tickNorm(
            settings.dim.yTick,
            dpp: dataPlane.height/plotPlane.height,
            minSize: labelSize * 1.25,
            maxSize: plotPlane.height/5.0,
            isLog: logy
        )
        let intTick = (tick.rounded() == tick)
        var y = tick    // the zero line is plotted by svgAxes
        let yMax = max(dataPlane.top, -dataPlane.bottom)

        while y <= yMax {
            if dataPlane.inVert(y) {
                tickPath.append(.moveTo(x: plotPlane.left, y: ts.ypos(y)))
                tickPath.append(.horizTo(x: plotPlane.right))
                labels.append(yLabelText(label(y, intTick), x: positions.yTickX, y: ts.ypos(y)))
            }
            if dataPlane.inVert(-y) {
                tickPath.append(.moveTo(x: plotPlane.left, y: ts.ypos(-y)))
                tickPath.append(.horizTo(x: plotPlane.right))
                labels.append(yLabelText(label(-y, intTick), x: positions.yTickX, y: ts.ypos(-y)))
            }
            y += tick
            if logy && y > 10.0 * tick {
                tick *= 10.0
                y = tick
            }
        }

        return plotter.plotPath(tickPath, props: propsList.yLabel, fill: false) + labels.joined(separator: "\n")
    }
}

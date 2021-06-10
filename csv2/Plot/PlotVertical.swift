//
//  PlotVertical.swift
//  csv2
//
//  Created by Michael Salmon on 2021-06-06.
//

import Foundation

extension Plot {

    /// Hold the state of a vertical chart

    private struct VerticalState {
        // half of the bar height
        let halfHeight = 0.46
        var counter = 0
        let first: Int
        let included: BitMap
        let zero: Double
        let mid: Double
        var tags: Int

        /// Initializer for VerticalState
        /// - Parameters:
        ///   - left: lowest data value
        ///   - mid: middle data value
        ///   - settings: chart settings

        init(zero: Double, mid: Double, settings: Settings) {
            let headerColumns = settings.intValue(.headerColumns)
            first = headerColumns
            included = settings.bitmapValue(.include) - BitMap(lsb: headerColumns)
            self.zero = zero
            self.mid = mid
            tags = settings.intValue(.xTagsHeader)
        }

        /// Get  the next counter value
        /// - Parameter step: how big a step to take
        /// - Returns: new counter

        @discardableResult
        mutating func nextDown(_ step: Int = 1) -> Double {
            counter += step
            return Double(counter)
        }
    }

    /// Plot a single row of data
    /// - Parameters:
    ///   - row: now number
    ///   - state: chart state

    private func plotOneRow(_ row: Int, state: inout VerticalState) {
        let yValues = csv.rowValues(row)
        for col in yValues.indices where state.included[col] {
            let y = state.nextDown()
            if let x = yValues[col] {
                var path = Path()
                path.append(.moveTo(xy: ts.pos(Point(x: state.zero, y: y - state.halfHeight))))
                path.append(.horizTo(x: ts.xpos(x)))
                path.append(.vertTo(y: ts.ypos(y + state.halfHeight)))
                path.append(.horizTo(x: ts.xpos(state.zero)))
                path.append(.closePath)
                plotter.plotPath(path, styles: stylesList.plots[col], fill: true)
                plotter.plotPath(path, styles: stylesList.plots[col], fill: false)
            }
        }
    }

    /// Plot data vertically

    func plotVertical() {
        var state = VerticalState(zero: max(0,0, dataPlane.left), mid: dataPlane.hMid, settings: settings)
        let headerRows = settings.intValue(.headerRows)

        let barHeight = ceil(ts.ypos(2.0) - ts.ypos(1.0))
        let vTag = stylesList.xTags.with(\.fontSize, of: barHeight)

        for row in csv.values.indices where row >= headerRows {
            plotOneRow(row, state: &state)
            if let tag = csv.rowHeader(row, header: state.tags) {
                let y = state.nextDown()
                let textPos = ts.pos(Point(x: state.mid, y: y))
                plotter.plotText(x: textPos.x, y: textPos.y, text: tag, styles: vTag)
            }
            state.nextDown(2)
        }
    }
}

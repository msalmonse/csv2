//
//  PlotVertical.swift
//  csv2
//
//  Created by Michael Salmon on 2021-06-06.
//

import Foundation

extension Plot {

    private struct VerticalState {
        var counter = 0
        let first: Int
        let included: BitMap
        let left: Double
        let mid: Double
        var tags: Int

        init(left: Double, mid: Double, settings: Settings) {
            let headerColumns = settings.intValue(.headerColumns)
            first = headerColumns
            included = settings.bitmapValue(.include) - BitMap(lsb: headerColumns)
            self.left = left
            self.mid = mid
            tags = settings.intValue(.xTagsHeader)
        }

        @discardableResult
        mutating func nextDown(_ step: Int = 1) -> Int {
            counter += step
            return counter
        }
    }

    private func plotOneRow(_ row: Int, state: inout VerticalState) {
        let yValues = csv.rowValues(row)
        for col in yValues.indices where state.included[col] {
            let y = Double(state.nextDown())
            if let x = yValues[col] {
                let start = ts.pos(Point(x: state.left, y: y))
                let end = ts.pos(Point(x: x, y: y))
                var path = Path()
                path.append(.moveTo(xy: start))
                path.append(.lineTo(xy: end))
                plotter.plotPath(path, styles: stylesList.plots[col], fill: false)
            }
        }
    }

    /// Plot data vertically

    func plotVertical() {
        var state = VerticalState(left: dataPlane.left, mid: dataPlane.hMid, settings: settings)
        let headerRows = settings.intValue(.headerRows)

        for row in csv.values.indices where row >= headerRows {
            plotOneRow(row, state: &state)
            if let tag = csv.rowHeader(row, header: state.tags) {
                let y = Double(state.nextDown())
                let textPos = ts.pos(Point(x: state.mid, y: y))
                plotter.plotText(x: textPos.x, y: textPos.y, text: tag, styles: stylesList.xTags)
            }
            state.nextDown(2)
        }
    }
}

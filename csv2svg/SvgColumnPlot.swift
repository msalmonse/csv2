//
//  SvgColumnPlot.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-23.
//

import Foundation

extension SVG {

    /// Calculate a list of x values, either a range or a data column
    /// - Returns: list of x values
    private func xList() -> [Double?] {
        if index < 0 {
            return (-settings.headerRows..<csv.data.count).map { Double($0) }
        } else {
            return csv.columnValues(index)
        }

    }

    /// Plot the non-index and non header columns
    /// - Parameter ts: a TransScale object
    /// - Returns: An array of the path elements for the columns

    func columnPlot(_ ts: TransScale) -> [String] {
        var paths: [String] = []

        let xValues = xList()
        for i in 0..<csv.colCt where i != index {
            let yValues = csv.columnValues(i)
            paths.append(
                plotCommon(xValues, yValues, stroke: colours[i], ts: ts)
            )
        }
        return paths
    }
}

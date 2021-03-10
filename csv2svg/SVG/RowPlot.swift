//
//  SVG/RowPlot.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-07.
//

import Foundation

extension SVG {

    /// Calculate a list of x values, either a range or a data column
    /// - Returns: list of x values
    private func xList() -> [Double?] {
        if index < 0 {
            return (-settings.headerColumns..<csv.colCt).map { Double($0) }
        } else {
            return csv.rowValues(index)
        }

    }

    /// Plot the non-index and non header rows
    /// - Parameter ts: a TransScale object
    /// - Returns: An array of the path elements for the columns

    func rowPlot(_ ts: TransScale) -> [String] {
        var paths: [String] = []

        let xValues = xList()
        for i in 0..<csv.rowCt where i != index {
            let yValues = csv.rowValues(i)
            paths.append(
                plotCommon(
                    xValues, yValues,
                    scattered: (settings.scatterPlots >> i) & 1 == 1,
                    stroke: colours[i],
                    ts: ts
                )
            )
        }
        return paths
    }
}

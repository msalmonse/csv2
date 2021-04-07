//
//  SVG/ColumnPlot.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-23.
//

import Foundation

extension Plot {

    /// Calculate a list of x values, either a range or a data column
    /// - Returns: list of x and i values

    private func xiList() -> [XIvalue] {
        if index < 0 {
            return (-settings.csv.headerRows..<csv.rowCt).map { XIvalue(x: Double($0), i: $0) }
        } else {
            let val = csv.columnValues(index)
            return (0 ..< csv.rowCt).map { XIvalue(x: val[$0], i: $0) }
        }
    }

    /// Plot the non-index and non header columns
    /// - Parameter ts: a TransScale object
    /// - Returns: An array of the path elements for the columns

    func columnPlot(_ ts: TransScale) -> [String] {
        var paths: [String] = []

        let xiValues = settings.plot.sortx ? xiList().sorted() : xiList()
        for i in 0..<csv.colCt where i != index && propsList.plots[i].included {
            let yValues = csv.columnValues(i)
            paths.append(
                plotCommon(
                    xiValues, yValues,
                    propsList.plots[i],
                    ts: ts
                )
            )
        }
        return paths
    }
}

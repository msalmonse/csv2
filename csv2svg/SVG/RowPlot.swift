//
//  SVG/RowPlot.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-07.
//

import Foundation

extension SVG {

    /// Calculate a list of x values, either a range or a data column
    /// - Returns: list of x and i values
    private func xiList() -> [XIvalue] {
        if index < 0 {
            return (-settings.headerColumns..<csv.colCt).map { XIvalue(x: Double($0), i: $0) }
        } else {
            let val = csv.rowValues(index)
            return (0 ..< csv.rowCt).map { XIvalue(x: val[$0], i: $0) }
        }
    }

    /// Plot the non-index and non header rows
    /// - Parameter ts: a TransScale object
    /// - Returns: An array of the path elements for the columns

    func rowPlot(_ ts: TransScale) -> [String] {
        var paths: [String] = []

        let xiValues = settings.plot.sortx ? xiList().sorted() : xiList()
        for i in 0..<csv.rowCt where i != index && propsList[i].included {
            let yValues = csv.rowValues(i)
            paths.append(
                plotCommon(
                    xiValues, yValues,
                    propsList[i],
                    ts: ts
                )
            )
        }
        return paths
    }
}

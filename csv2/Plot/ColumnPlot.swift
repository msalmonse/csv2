//
//  SVG/ColumnPlot.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-23.
//

import Foundation

extension Plot {

    /// Plot the non-index and non header columns
    /// - Returns: An array of the path elements for the columns

    func columnPlot() -> [String] {
        var paths: [String] = []

        let xiValues = settings.plot.sortx ? xiList().sorted() : xiList()
        let staple = stapleGet(xiValues)
        for i in 0..<csv.colCt where i != index && propsList.plots[i].included {
            let yValues = csv.columnValues(i)
            paths.append(
                plotCommon(
                    xiValues, yValues,
                    propsList.plots[i],
                    staple: staple
                )
            )
        }
        return paths
    }
}

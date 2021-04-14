//
//  SVG/RowPlot.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-07.
//

import Foundation

extension Plot {

    /// Plot the non-index and non header rows
    /// - Returns: An array of the path elements for the columns

    func rowPlot() -> [String] {
        var paths: [String] = []

        let xiValues = settings.plot.sortx ? xiList().sorted() : xiList()
        let staple = stapleGet(xiValues)
        for i in 0..<csv.rowCt where i != index && propsList.plots[i].included {
            let yValues = csv.rowValues(i)
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

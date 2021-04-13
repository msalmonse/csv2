//
//  SVG/RowPlot.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-07.
//

import Foundation

extension Plot {

    /// Plot the non-index and non header rows
    /// - Parameter ts: a TransScale object
    /// - Returns: An array of the path elements for the columns

    func rowPlot(_ ts: TransScale) -> [String] {
        var paths: [String] = []

        let xiValues = settings.plot.sortx ? xiList().sorted() : xiList()
        let staple = stapleGet(xiValues, ts)
        for i in 0..<csv.rowCt where i != index && propsList.plots[i].included {
            let yValues = csv.rowValues(i)
            paths.append(
                plotCommon(
                    xiValues, yValues,
                    propsList.plots[i],
                    ts: ts,
                    staple: staple
                )
            )
        }
        return paths
    }
}

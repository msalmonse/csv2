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

    func columnPlot() {
        let xiValues = settings.plot.sortx ? xiList().sorted() : xiList()
        let bar = barGet(xiValues)
        for i in 0..<csv.colCt where i != index && stylesList.plots[i].included {
            let yValues = csv.columnValues(i)
            plotCommon(
                xiValues, yValues,
                stylesList.plots[i],
                bar: bar
            )
        }
    }
}

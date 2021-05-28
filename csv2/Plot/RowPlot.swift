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

    func rowPlot() {
        let xiValues = settings.boolValue(.sortx) ? xiList().sorted() : xiList()
        let bar = barGet(xiValues)
        for i in 0..<csv.rowCt where i != index && stylesList.plots[i].options[.included] {
            let yValues = csv.rowValues(i)
            plotCommon(
                xiValues, yValues,
                stylesList.plots[i],
                bar: bar
            )
        }
    }
}

//
//  PlotVertical.swift
//  csv2
//
//  Created by Michael Salmon on 2021-06-06.
//

import Foundation

extension Plot {
    /// Plot data vertically

    func plotVertical() {
        let tagsColumn = settings.intValue(.xTags)

        for i in 0..<csv.rowCt where i != index && stylesList.plots[i].options[.included] {
            let yValues = csv.rowValues(i)
            let tag = csv.rowHeader(i, header: tagsColumn)
        }
    }
}

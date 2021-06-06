//
//  PlotVertical.swift
//  csv2
//
//  Created by Michael Salmon on 2021-06-06.
//

import Foundation

extension Plot {

    func plotOneRow(_ row: Int, _ first: Int, _ tag: String, _ counter: inout Counter) {
        let yValues = csv.rowValues(row)
        for col in yValues.indices where col >= first {
            print(yValues[col]!, to: &standardError)
        }
    }

    /// Plot data vertically

    func plotVertical() {
        let headerColumns = settings.intValue(.headerColumns)
        let included = settings.bitmapValue(.include) - BitMap(lsb: headerColumns)
        var counter = Counter()
        let tagsColumn = settings.intValue(.xTagsHeader)

        for row in csv.values.indices where included[row] {
            let tag = csv.rowHeader(row, header: tagsColumn) ?? ""
            plotOneRow(row, headerColumns, tag, &counter)
        }
    }
}

//
//  CSVswap.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-31.
//

import Foundation

extension CSV {

    /// Swap the rows and collumns of a CSV
    /// - Returns: CSV with swapped rows and columns

    func swap() -> CSV {
        var newData: [[String]] = (0..<colCt).map { _ in [] }

        for row in data {
            for i in 0..<colCt {
                newData[i].append(row.hasIndex(i) ? row[i] : "")
            }
        }
        return CSV(newData)
    }
}

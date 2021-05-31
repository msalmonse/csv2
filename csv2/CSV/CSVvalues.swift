//
//  CSVvalues.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-31.
//

import Foundation

extension CSV {

    /// Return a column of values
    /// - Parameters:
    ///   - col: the column number
    ///   - from: the first row to fetch data from
    /// - Returns: list of values

    func columnValues(_ col: Int, from row1: Int = 0) -> [Double?] {
        var result: [Double?] = []

        if values.hasIndex(row1) {
            for row in values[row1...] {
                if row.hasIndex(col) {
                    result.append(row[col])
                } else {
                    result.append(nil)
                }
            }
        }

        return result
    }

    /// Return a row of values
    /// - Parameters:
    ///   - col: the row number
    ///   - from: the first column to fetch data from
    /// - Returns: list of values

    func rowValues(_ row: Int, from col1: Int = 0) -> [Double?] {
        var result: [Double?] = []

        if values.hasIndex(row) && values[row].hasIndex(col1) {
            result.append(contentsOf: values[row][col1...])
        }

        return result
    }
}

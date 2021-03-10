//
//  SVG/Header.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-01.
//

import Foundation

extension SVG {

    /// Extract name from column header
    /// - Parameters:
    ///   - column: column number
    ///   - csv: csv object
    /// - Returns: column header

    static private func columnHeader(_ column: Int, csv: CSV?) -> String {
        if csv != nil && csv!.data[0].count > column && column >= 0 && csv!.data[0][column] != "" {
            return csv!.data[0][column].replacingOccurrences(of: "\"", with: "")
        }
        return String(format: "Column %d", column + 1)
    }

    /// Extract name from column header
    /// - Parameters:
    ///   - row: row number
    ///   - csv: csv object
    /// - Returns: row header

    static private func rowHeader(_ row: Int, csv: CSV?) -> String {
        if csv != nil && row >= 0 && row < csv!.rowCt && csv!.data[row][0] != "" {
            return csv!.data[row][0].replacingOccurrences(of: "\"", with: "")
        }
        return String(format: "Row %d", row + 1)
    }

    /// Extract name from row or header column
    /// - Parameters:
    ///   - i: row or column number
    ///   - csv: csv object
    ///   - inColumn: is data arranged in columns
    /// - Returns: row or column header

    static func headerText(_ i: Int, csv: CSV?, inColumns: Bool) -> String {
        return inColumns ? columnHeader(i, csv: csv) : rowHeader(i, csv: csv)
    }
}

//
//  SvgHeader.swift
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

    static private func columnHeader(_ column: Int, csv: CSV) -> String {
        if csv.data.count > column && column >= 0 {
            return csv.data[0][column].replacingOccurrences(of: "\"", with: "")
        }
        return ""
    }
    
    /// Extract name from row or header column
    /// - Parameters:
    ///   - i: row or column number
    ///   - csv: csv object
    ///   - inColumn: is data arranged in columns
    /// - Returns: row or column header

    static func headerText(_ i: Int, csv: CSV, inColumn: Bool) -> String {
        return inColumn ? columnHeader(i, csv: csv) : ""
    }
}

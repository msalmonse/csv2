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
    ///   - header: the row or column that has the names
    /// - Returns: column header

    static private func columnHeader(_ column: Int, csv: CSV?, _ header: Int) -> String {
        if csv != nil && csv!.data[header].count > column && column >= 0
            && csv!.data[header][column].notEmpty {
                return csv!.data[header][column]
        }
        return String(format: "Column %d", column + 1)
    }

    /// Extract name from column header
    /// - Parameters:
    ///   - row: row number
    ///   - csv: csv object
    ///   - header: the row or column that has the names
    /// - Returns: row header

    static private func rowHeader(_ row: Int, csv: CSV?, header: Int) -> String {
        if csv != nil && row >= 0 && row < csv!.rowCt && csv!.data[row][header].notEmpty {
            return csv!.data[row][header]
        }
        return String(format: "Row %d", row + 1)
    }

    /// Extract name from row or header column
    /// - Parameters:
    ///   - i: row or column number
    ///   - csv: csv object
    ///   - inColumn: is data arranged in columns
    ///   - header: the row or column that has the names
    /// - Returns: row or column header

    static func headerText(_ i: Int, csv: CSV?, inColumns: Bool, header: Int) -> String {
        return inColumns ? columnHeader(i, csv: csv, header) : rowHeader(i, csv: csv, header: header)
    }

    /// Extract sub title from row or column
    /// - Parameters:
    ///   - csv: csv object
    ///   - inColumns: is data in rows or columns
    ///   - header: row or column with the sub title
    /// - Returns: sub title

    static func subTitleText(csv: CSV, inColumns: Bool, header: Int) -> String {
        guard header >= 0 else { return "" }
        var text: [String] = []
        if inColumns {
            text = csv.data.count > header ? csv.data[header] : []
        } else {
            for row in csv.data where header < row.count {
                text.append(row[header])
            }
        }

        return text.joined(separator: " ").trimmingCharacters(in: .whitespaces)
    }
}

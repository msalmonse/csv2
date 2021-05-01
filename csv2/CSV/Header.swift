//
//  SVG/Header.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-01.
//

import Foundation

extension CSV {

    /// Extract name from column header
    /// - Parameters:
    ///   - column: column number
    ///   - csv: csv object
    ///   - header: the row or column that has the names
    /// - Returns: column header

    func columnHeader(_ column: Int, _ header: Int) -> String? {
        if data.hasIndex(header) && data[header].hasIndex(column) && data[header][column].hasContent {
                return data[header][column]
        }
        return nil
    }

    /// Extract name from column header
    /// - Parameters:
    ///   - row: row number
    ///   - csv: csv object
    ///   - header: the row or column that has the names
    /// - Returns: row header

    func rowHeader(_ row: Int, header: Int) -> String? {
        if data.hasIndex(row) && data[row].hasIndex(header) && data[row][header].hasContent {
            return data[row][header]
        }
        return nil
    }

    /// Extract name from row or header column
    /// - Parameters:
    ///   - i: row or column number
    ///   - csv: csv object
    ///   - inColumn: is data arranged in columns
    ///   - header: the row or column that has the names
    /// - Returns: row or column header

    func headerText(_ i: Int, _ inColumns: Bool, header: Int) -> String? {
        return inColumns ? columnHeader(i, header) : rowHeader(i, header: header)
    }

    /// Extract sub title from row or column
    /// - Parameters:
    ///   - csv: csv object
    ///   - inColumns: is data in rows or columns
    ///   - header: row or column with the sub title
    /// - Returns: sub title

    func subTitleText(inColumns: Bool, header: Int) -> String {
        guard header >= 0 else { return "" }
        var text: [String] = []
        if inColumns {
            text = data.hasIndex(header) ? data[header] : []
        } else {
            for row in data where row.hasIndex(header) {
                text.append(row[header])
            }
        }

        return text.joined(separator: " ").trimmingCharacters(in: .whitespaces)
    }
}

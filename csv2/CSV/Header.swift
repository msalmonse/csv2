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

    /// Extract sub title from row or column
    /// - Parameters:
    ///   - header: row or column with the sub title
    /// - Returns: sub title

    func subTitleText(header: Int) -> String {
        guard header >= 0 else { return "" }
        var text: [String] = []
        for row in data where row.hasIndex(header) {
            text.append(row[header])
        }

        return text.joined(separator: " ").trimmingCharacters(in: .whitespaces)
    }
}

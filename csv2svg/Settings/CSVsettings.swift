//
//  CSVsettings.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-30.
//

import Foundation

extension Settings {
    struct CSV {
        // Header rows and columns
        let headerColumns: Int
        let headerRows: Int
        let nameHeader: Int
        let subTitleHeader: Int

        // Index for x values in csv data
        let index: Int

        // Data is grouped in rows?
        let rowGrouping: Bool
    }

    static func jsonCSV(from container: KeyedDecodingContainer<CodingKeys>?) -> CSV {
        return CSV(
            headerColumns: keyedIntValue(from: container, forKey: .headerColumns),
            headerRows: keyedIntValue(from: container, forKey: .headerRows),
            nameHeader: keyedIntValue(from: container, forKey: .nameHeader) - 1,
            subTitleHeader: keyedIntValue(from: container, forKey: .subTitleHeader) - 1,
            index: keyedIntValue(from: container, forKey: .index) - 1,
            rowGrouping: keyedBoolValue(from: container, forKey: .rowGrouping)
        )
    }
}

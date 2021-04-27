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
        let xTagsHeader: Int

        // Index for x values in csv data
        let index: Int

        // Data is grouped in rows?
        let rowGrouping: Bool
    }

    static func jsonCSV(from container: KeyedDecodingContainer<CodingKeys>?, defaults: Defaults) -> CSV {
        // 1 is subtracted because in the real world things start with 1 but here we start with 0
        return CSV(
            headerColumns: keyedIntValue(from: container, forKey: .headerColumns, defaults: defaults,
                                         in: Defaults.headerBounds),
            headerRows: keyedIntValue(from: container, forKey: .headerRows, defaults: defaults,
                                      in: Defaults.headerBounds),
            nameHeader: keyedIntValue(from: container, forKey: .nameHeader, defaults: defaults,
                                      in: Defaults.headerBounds) - 1,
            subTitleHeader: keyedIntValue(from: container, forKey: .subTitleHeader,
                                          defaults: defaults, in: Defaults.headerBounds) - 1,
            xTagsHeader: keyedIntValue(from: container, forKey: .xTagsHeader, defaults: defaults,
                                      in: Defaults.headerBounds) - 1,
            index: keyedIntValue(from: container, forKey: .index, defaults: defaults,
                                 in: Defaults.headerBounds) - 1,
            rowGrouping: keyedBoolValue(from: container, forKey: .rowGrouping, defaults: defaults)
        )
    }
}

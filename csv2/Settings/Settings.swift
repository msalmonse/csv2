//
//  Settings.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-16.
//

import Foundation

class Settings: Decodable, ReflectedStringConvertible {
    // Storage for settings
    internal var values: SettingsValues

    // Some shortcuts
    let height: Double
    let index: Int
    var shapeWidth: Double { strokeWidth * 1.75 }
    let strokeWidth: Double
    let width: Double

    // Type of chart
    let chartType: ChartType

    // Text to use in comments
    let comment = """
        Created by \(AppInfo.name): \(AppInfo.version) (\(AppInfo.branch):\(AppInfo.build)) \(AppInfo.origin)
        """

    required init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)

        var chartType: ChartType = .horizontal
        let chart = Self.keyedStringValue(from: container, forKey: .chartType, defaults: defaults)
        switch chart.lowercased() {
        case "piechart": chartType = .pieChart
        case "horizontal": chartType = .horizontal
        default: break
        }
        self.chartType = chartType

        // Although this is a Defaults property it can be loaded from the JSON file
        defaults.bounded = Self.keyedBoolValue(from: container, forKey: .bounded, defaults: defaults)

        var values = SettingsValues()
        for key in CodingKeys.allCases {
            switch key.codingType {
            case .isBool:
                let val = Self.keyedBoolSettingsValue(from: container, forKey: key, defaults: defaults)
                values.setValue(key, val)
            case .isDouble:
                let val = Self.keyedDoubleSettingsValue(from: container, forKey: key, defaults: defaults,
                                                        in: key.doubleBounds)
                values.setValue(key, val)
            case .isInt:
                let val = Self.keyedIntSettingsValue(from: container, forKey: key, defaults: defaults,
                                                     in: key.intBounds)
                values.setValue(key, val)
            case .isInt1:
                let val = Self.keyedInt1SettingsValue(from: container, forKey: key, defaults: defaults,
                                                      in: key.intBounds)
                values.setValue(key, val)
            case .isString:
                let val = Self.keyedStringSettingsValue(from: container, forKey: key, defaults: defaults)
                values.setValue(key, val)
            case .isStringArray:
                let val = Self.keyedStringArraySettingsValue(from: container, forKey: key, defaults: defaults)
                values.setValue(key, val)
            case .isNone: break
            }
        }
        Self.loadForeground(from: container, defaults: defaults, into: &values)
        Self.loadPDF(from: container, defaults: defaults, into: &values)

        index = values.intValue(.index)
        height = Double(values.intValue(.height))
        width = Double(values.intValue(.width))
        strokeWidth = values.doubleValue(.strokeWidth)

        self.values = values
    }

    /// Load contents of file into object
    /// - Parameter url: file path
    /// - Throws:
    /// - Returns: a new Setting

    static func load(_ url: URL) throws -> Settings {
        let data = (try? Data(contentsOf: url)) ?? "{}".data(using: .utf8) ?? Data()
        return try Self.loadFrom(data)
    }

    /// Load contents of String into object
    /// - Parameter contents: JSON string
    /// - Throws:
    /// - Returns: a new Setting

    static func load(_ contents: String) throws -> Settings {
        let data = contents.data(using: .utf8) ?? Data()
        return try Self.loadFrom(data)
    }

    /// Load from data into object
    /// - Parameter data: JSON data
    /// - Throws:
    /// - Returns: a new Setting

    static func loadFrom(_ data: Data) throws -> Settings {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(Settings.self, from: data)
        } catch {
            print(error, to: &standardError)
            throw error
        }
    }

    /// Swap values for rows and columns

    func swapRowsColumns() {
        let headerRows = values.value(.headerRows)
        let headerCols = values.value(.headerColumns)
        values.setValue(.headerColumns, headerRows)
        values.setValue(.headerRows, headerCols)
    }
}

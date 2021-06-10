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
        let values = try Self.getValues(from: decoder)

        var chartType: ChartType = .horizontal
        let chart = values.stringValue(.chartType)
        if "horizontal".hasPrefix(chart) {
            chartType = .horizontal
        } else if "piechart".hasPrefix(chart) {
            chartType = .pieChart
        } else if "vertical".hasPrefix(chart) {
            chartType = .vertical
        } else {
            throw ErrorMessage(message: "\"\(chart)\" is not a known chart type")
        }
        self.chartType = chartType

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

//
//  Settings.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-16.
//

import Foundation

class Settings: Decodable, ReflectedStringConvertible {
    // Type of chart
    let chartType: ChartType

    // CSS settings
    let css: Settings.CSS

    // CSV related settings
    let csv: Settings.CSV

    // Dimension settings
    let dim: Settings.Dimensions

    // Foreground colour settings
    let fg: Settings.ForegroundColours

    // PDF related settings
    let pdf: Settings.PDF

    // Plot related settings
    let plot: Settings.Plot

    // Plotter related settings
    let plotter: Settings.Plotter

    // svg width and height
    var height: Double { return Double(dim.height) }
    var width: Double { return Double(dim.width) }

    // Header rows and columns
    var headers: Int { return inColumns ? csv.headerRows : csv.headerColumns }

    var inColumns: Bool { return !csv.rowGrouping }
    var inRows: Bool { return csv.rowGrouping }

    // Text to use in comments
    let comment = """
        Created by \(AppInfo.name): \(AppInfo.version) (\(AppInfo.branch):\(AppInfo.build)) \(AppInfo.origin)
        """

        /// Check if a row or column is included
    /// - Parameter i: row or column number
    /// - Returns: true if included

    func included(_ i: Int) -> Bool {
        return ((plot.include >> i) & 1) == 1
    }

    required init(from decoder: Decoder) {
        let container = try? decoder.container(keyedBy: CodingKeys.self)

        var chartType = defaults.chartType
        if let chart = Self.optionalKeyedStringValue(from: container, forKey: .chartType) {
            switch chart.lowercased() {
            case "piechart": chartType = .pieChart
            case "horizontal": chartType = .horizontal
            default: break
            }
        }
        self.chartType = chartType

        // Although this is a Defaults property it can be loaded from the JSON file
        defaults.bounded = Self.keyedBoolValue(from: container, forKey: .bounded, defaults: defaults)
        css = Self.jsonCSS(from: container, defaults: defaults)
        csv = Self.jsonCSV(from: container, defaults: defaults)
        dim = Self.jsonDimensions(from: container, defaults: defaults)
        plot = Self.jsonPlot(from: container, defaults)
        plotter = Self.jsonPlotter(from: container, defaults: defaults)

        let fgContainer = try?
            container?.nestedContainer(keyedBy: Settings.CodingKeys.self, forKey: .foregroundColours)
        fg = Self.jsonForegroundColours(from: fgContainer, defaults: defaults)

        let pdfContainer = try?
            container?.nestedContainer(keyedBy: Settings.CodingKeys.self, forKey: .pdf)
        pdf = Self.jsonPDF(from: pdfContainer, defaults: defaults)
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
}

//
//  Settings.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-16.
//

import Foundation

class Settings: Decodable, ReflectedStringConvertible {
    // CSS settings
    let css: Settings.CSS

    // CSV related settings
    let csv: Settings.CSV

    // Dimension settings
    let dim: Settings.Dimensions

    // Plot related settings
    let plot: Settings.Plot

    // svg width and height
    var height: Double { return Double(dim.height) }
    var width: Double { return Double(dim.width) }

    // svg sub-title title, x axis title and y axis title
    let subTitle: String
    let title: String
    let xTitle: String
    let yTitle: String

    // Header rows and columns
    var headers: Int { return inColumns ? csv.headerRows : csv.headerColumns }


    // Include plot info in svg
    let legends: Bool

    var inColumns: Bool { return !csv.rowGrouping }
    var inRows: Bool { return csv.rowGrouping }

    // Lag axes?
    let logx: Bool
    let logy: Bool

    let logoURL: String
    let svgInclude: String

    /// Check if a row or column is included
    /// - Parameter i: row or column number
    /// - Returns: true if included

    func included(_ i: Int) -> Bool {
        return ((plot.include >> i) & 1) == 1
    }

    required init(from decoder: Decoder) {
        let container = try? decoder.container(keyedBy: CodingKeys.self)

        css = Self.jsonCSS(from: container)
        csv = Self.jsonCSV(from: container)
        dim = Self.jsonDimensions(from: container)
        plot = Self.jsonPlot(from: container)

        legends = Self.keyedBoolValue(from: container, forKey: .legends)
        logoURL = Self.keyedStringValue(from: container, forKey: .logoURL)
        logx = Self.keyedBoolValue(from: container, forKey: .logx)
        logy = Self.keyedBoolValue(from: container, forKey: .logy)
        subTitle = Self.keyedStringValue(from: container, forKey: .subTitle)
        svgInclude = Self.keyedStringValue(from: container, forKey: .svgInclude)
        title = Self.keyedStringValue(from: container, forKey: .title)
        xTitle = Self.keyedStringValue(from: container, forKey: .xTitle)
        yTitle = Self.keyedStringValue(from: container, forKey: .yTitle)
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

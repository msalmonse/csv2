//
//  Settings.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-16.
//

import Foundation

class Settings: Decodable, ReflectedStringConvertible {
    // CSS settings
    let css: CSS

    // Dimension settings
    let dim: Dimensions

    // Plot related settings
    let plot: Plot

    // svg width and height
    var height: Double { return Double(dim.height) }
    var width: Double { return Double(dim.width) }

    // svg sub-title title, x axis title and y axis title
    let subTitle: String
    let title: String
    let xTitle: String
    let yTitle: String

    // Header rows and columns
    let headerColumns: Int
    let headerRows: Int
    var headers: Int { return inColumns ? headerRows : headerColumns }
    let nameHeader: Int
    let subTitleHeader: Int

    // Index for x values in csv data
    let index: Int

    // Include plot info in svg
    let legends: Bool

    // Data is grouped in rows?
    let rowGrouping: Bool
    var inColumns: Bool { return !rowGrouping }
    var inRows: Bool { return rowGrouping }

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
        dim = Self.jsonDimensions(from: container)
        plot = Self.jsonPlot(from: container)

        headerColumns = Self.keyedIntValue(from: container, forKey: .headerColumns)
        headerRows = Self.keyedIntValue(from: container, forKey: .headerRows)
        index = Self.keyedIntValue(from: container, forKey: .index) - 1     // use 0 based
        legends = Self.keyedBoolValue(from: container, forKey: .legends)
        logoURL = Self.keyedStringValue(from: container, forKey: .logoURL)
        logx = Self.keyedBoolValue(from: container, forKey: .logx)
        logy = Self.keyedBoolValue(from: container, forKey: .logy)
        nameHeader = Self.keyedIntValue(from: container, forKey: .nameHeader) - 1   // use 0 based
        rowGrouping = Self.keyedBoolValue(from: container, forKey: .rowGrouping)
        subTitle = Self.keyedStringValue(from: container, forKey: .subTitle)
        subTitleHeader = Self.keyedIntValue(from: container, forKey: .subTitleHeader) - 1   // use 0 based
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

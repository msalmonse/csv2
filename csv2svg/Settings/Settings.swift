//
//  Settings.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-16.
//

import Foundation

class Settings: Decodable, ReflectedStringConvertible {
    // Dimension settings
    let dim: Dimensions

    // svg width and height
    var height: Double { return Double(dim.height) }
    var width: Double { return Double(dim.width) }

    // opacity for plots
    let opacity: Double

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

    // sort the x values before plotting
    let sortx: Bool

    // Smooth plots, 0.0 means no smoothing
    let smooth: Double

    // Include plot info in svg
    let legends: Bool

    // Data is grouped in rows?
    let rowGrouping: Bool
    var inColumns: Bool { return !rowGrouping }
    var inRows: Bool { return rowGrouping }

    // Use dashed lines
    let dashedLines: Int
    // Which plots to include
    let include: Int
    // Plots to show as scattered
    let scatterPlots: Int
    // show data points
    let showDataPoints: Int
    // distance between points
    let dataPointDistance: Double
    // Shapes to use for datapoints and scatter plots
    let shapes: [String]

    // Dash patterns
    let dashes: [String]

    // Path colours
    let colours: [String]
    // Force unassigned colours to black
    let black: Bool
    // Background colour
    let backgroundColour: String

    // font related stuff
    let bold: Bool
    let fontFamily: String
    let italic: Bool

    // Path stroke width
    let strokeWidth: Double

    // Path names
    let names: [String]

    // Lag axes?
    let logx: Bool
    let logy: Bool

    // include stuff
    let cssClasses: [String]
    let cssExtras: [String]
    let cssID: String
    let cssInclude: String
    let logoURL: String
    let svgInclude: String

    /// Check if a row or column is included
    /// - Parameter i: row or column number
    /// - Returns: true if included

    func included(_ i: Int) -> Bool {
        return ((include >> i) & 1) == 1
    }

    required init(from decoder: Decoder) {
        let container = try? decoder.container(keyedBy: CodingKeys.self)

        dim = Self.newDimension(from: container)
        backgroundColour = Self.keyedStringValue(from: container, forKey: .backgroundColour)
        black = Self.keyedBoolValue(from: container, forKey: .black)
        bold = Self.keyedBoolValue(from: container, forKey: .bold)
        cssClasses = Self.keyedStringArray(from: container, forKey: .cssClasses)
        cssExtras = Self.keyedStringArray(from: container, forKey: .cssExtras)
        cssID = Self.keyedStringValue(from: container, forKey: .cssID)
        cssInclude = Self.keyedStringValue(from: container, forKey: .cssInclude)
        dashedLines = Self.keyedIntValue(from: container, forKey: .dashedLines)
        dataPointDistance = Self.keyedDoubleValue(from: container, forKey: .dataPointDistance)
        fontFamily = Self.keyedStringValue(from: container, forKey: .fontFamily)
        headerColumns = Self.keyedIntValue(from: container, forKey: .headerColumns)
        headerRows = Self.keyedIntValue(from: container, forKey: .headerRows)
        include = Self.keyedIntValue(from: container, forKey: .include)
        index = Self.keyedIntValue(from: container, forKey: .index) - 1     // use 0 based
        italic = Self.keyedBoolValue(from: container, forKey: .italic)
        legends = Self.keyedBoolValue(from: container, forKey: .legends)
        logoURL = Self.keyedStringValue(from: container, forKey: .logoURL)
        logx = Self.keyedBoolValue(from: container, forKey: .logx)
        logy = Self.keyedBoolValue(from: container, forKey: .logy)
        nameHeader = Self.keyedIntValue(from: container, forKey: .nameHeader) - 1   // use 0 based
        opacity = Self.keyedDoubleValue(from: container, forKey: .opacity)
        rowGrouping = Self.keyedBoolValue(from: container, forKey: .rowGrouping)
        sortx = Self.keyedBoolValue(from: container, forKey: .sortx)
        scatterPlots = Self.keyedIntValue(from: container, forKey: .scatterPlots)
        showDataPoints = Self.keyedIntValue(from: container, forKey: .showDataPoints)
        smooth = Self.keyedDoubleValue(from: container, forKey: .smooth)
        strokeWidth = Self.keyedDoubleValue(from: container, forKey: .strokeWidth)
        subTitle = Self.keyedStringValue(from: container, forKey: .subTitle)
        subTitleHeader = Self.keyedIntValue(from: container, forKey: .subTitleHeader) - 1   // use 0 based
        svgInclude = Self.keyedStringValue(from: container, forKey: .svgInclude)
        title = Self.keyedStringValue(from: container, forKey: .title)
        xTitle = Self.keyedStringValue(from: container, forKey: .xTitle)
        yTitle = Self.keyedStringValue(from: container, forKey: .yTitle)

        colours = Self.keyedStringArray(from: container, forKey: .colours)
        dashes = Self.keyedStringArray(from: container, forKey: .dashes)
        names = Self.keyedStringArray(from: container, forKey: .names)
        shapes = Self.keyedStringArray(from: container, forKey: .shapes)
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

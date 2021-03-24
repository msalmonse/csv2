//
//  Settings.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-16.
//

import Foundation

class Settings: Codable, ReflectedStringConvertible {
    // svg width and height
    let height: Int
    let width: Int

    // base font size
    let baseFontSize: Double

    // opacity for plots
    let opacity: Double

    // Font sizes
    var axesSize: Double { return baseFontSize * 1.2 }
    var labelSize: Double { return baseFontSize }
    var legendSize: Double { return baseFontSize * 1.3 }
    var subTitleSize: Double { return baseFontSize * 1.5 }
    var titleSize: Double { return baseFontSize * 2.5 }

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

    // Include plot info in svg
    let legends: Bool

    // minimum and maximum for x and y axes
    // nil means not specified
    let xMax: Double
    let xMin: Double
    let yMax: Double
    let yMin: Double

    // Ticks on the x and y axes
    let xTick: Double
    let yTick: Double

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

    /// Check if a row or column is included
    /// - Parameter i: row or column number
    /// - Returns: true if included

    func included(_ i: Int) -> Bool {
        return ((include >> i) & 1) == 1
    }

    /// Return the boolean default for the key
    /// - Parameter key: Coding key for Settings
    /// - Returns: bool default value

    private static func boolDefault(_ key: CodingKeys) -> Bool {
        switch key {
        case .black: return Defaults.black
        case .bold: return Defaults.bold
        case .italic: return Defaults.italic
        case .legends: return Defaults.legends
        case .logx: return Defaults.logx
        case .logy: return Defaults.logy
        case .rowGrouping: return Defaults.rowGrouping
        case .sortx: return Defaults.sortx
        default: return false
        }
    }

    /// Convenience function to decode a keyed Bool
    /// - Parameters:
    ///   - container: decoded data container
    ///   - key: the key into the decoded data
    ///   - defaultValue: the default value
    /// - Returns: decoded or default value

    private static func keyedBoolValue(
        from container: KeyedDecodingContainer<CodingKeys>?,
        forKey key: CodingKeys
    ) -> Bool {
        if container == nil { return boolDefault(key) }
        return (try? container!.decodeIfPresent(Bool.self, forKey: key)) ?? boolDefault(key)
    }

    /// Return the integer default for the key
    /// - Parameter key: Coding key for Settings
    /// - Returns: integer default value

    private static func doubleDefault(_ key: CodingKeys) -> Double {
        switch key {
        case .baseFontSize: return Defaults.baseFontSize
        case .dataPointDistance: return Defaults.dataPointDistance
        case .opacity: return Defaults.opacity
        case .strokeWidth: return Defaults.strokeWidth
        case .xMax: return Defaults.xMax
        case .xMin: return Defaults.xMin
        case .xTick: return Defaults.xTick
        case .yMax: return Defaults.yMax
        case .yMin: return Defaults.yMin
        case .yTick: return Defaults.yTick
        default: return 0.0
        }
    }

    /// Convenience function to decode a keyed Int
    /// - Parameters:
    ///   - container: decoded data container
    ///   - key: the key into the decoded data
    /// - Returns: decoded or default value

    private static func keyedDoubleValue(
        from container: KeyedDecodingContainer<CodingKeys>?,
        forKey key: CodingKeys
    ) -> Double {
        if container == nil { return doubleDefault(key) }
        return (try? container!.decodeIfPresent(Double.self, forKey: key)) ?? doubleDefault(key)
    }

    /// Return the integer default for the key
    /// - Parameter key: Coding key for Settings
    /// - Returns: integer default value

    private static func intDefault(_ key: CodingKeys) -> Int {
        switch key {
        case .dashedLines: return Defaults.dashedLines
        case .headerColumns: return Defaults.headers
        case .headerRows: return Defaults.headers
        case .height: return Defaults.height
        case .include: return Defaults.include
        case .index: return Defaults.index
        case .nameHeader: return Defaults.nameHeader
        case .scatterPlots: return Defaults.scattered
        case .showDataPoints: return Defaults.showDataPoints
        case .subTitleHeader: return Defaults.subTitleHeader
        case .width: return Defaults.width
        default: return 0
        }
    }

    /// Convenience function to decode a keyed Int
    /// - Parameters:
    ///   - container: decoded data container
    ///   - key: the key into the decoded data
    ///   - defaultValue: the default value
    /// - Returns: decoded or default value

    private static func keyedIntValue(
        from container: KeyedDecodingContainer<CodingKeys>?,
        forKey key: CodingKeys
    ) -> Int {
        if container == nil { return intDefault(key) }
        return (try? container!.decodeIfPresent(Int.self, forKey: key)) ?? intDefault(key)
    }

    /// Return the string default for the key
    /// - Parameter key: Coding key for Settings
    /// - Returns: integer default value

    private static func stringDefault(_ key: CodingKeys) -> String {
        switch key {
        case .backgroundColour: return Defaults.backgroundColour
        case .fontFamily: return Defaults.fontFamily
        case .subTitle: return Defaults.subTitle
        case .title: return Defaults.title
        default: return ""
        }
    }

    /// Convenience function to decode a keyed String
    /// - Parameters:
    ///   - container: decoded data container
    ///   - key: the key into the decoded data
    ///   - defaultValue: the default value
    /// - Returns: decoded or default value

    private static func keyedStringValue(
        from container: KeyedDecodingContainer<CodingKeys>?,
        forKey key: CodingKeys
    ) -> String {
        if container == nil { return stringDefault(key) }
        return (try? container!.decodeIfPresent(String.self, forKey: key)) ?? stringDefault(key)
    }

    /// Return the integer default for the key
    /// - Parameter key: Coding key for Settings
    /// - Returns: integer default value

    private static func stringArrayDefault(_ key: CodingKeys) -> [String] {
        switch key {
        case .colours: return Defaults.colours
        case .dashes: return Defaults.dashes
        case .names: return Defaults.names
        case .shapes: return Defaults.shapes
        default: return []
        }
    }

    /// Convenience function to decode a keyed String Array
    /// - Parameters:
    ///   - container: decoded data container
    ///   - key: the key into the decoded data
    ///   - defaultValue: the default value
    /// - Returns: decoded or default value

    private static func keyedStringArray(
        from container: KeyedDecodingContainer<CodingKeys>?,
        forKey key: CodingKeys
    ) -> [String] {
        var values: [String] = []
        var arrayContainer = try? container?.nestedUnkeyedContainer(forKey: key)
        if arrayContainer == nil { return stringArrayDefault(key) }
        while !arrayContainer!.isAtEnd {
            values.append((try? arrayContainer?.decode(String.self)) ?? "")
        }

        return values
    }

    required init(from decoder: Decoder) {
        let container = try? decoder.container(keyedBy: CodingKeys.self)

        backgroundColour = Self.keyedStringValue(from: container, forKey: .backgroundColour)
        baseFontSize = Self.keyedDoubleValue(from: container, forKey: .baseFontSize)
        black = Self.keyedBoolValue(from: container, forKey: .black)
        bold = Self.keyedBoolValue(from: container, forKey: .bold)
        dashedLines = Self.keyedIntValue(from: container, forKey: .dashedLines)
        dataPointDistance = Self.keyedDoubleValue(from: container, forKey: .dataPointDistance)
        fontFamily = Self.keyedStringValue(from: container, forKey: .fontFamily)
        headerColumns = Self.keyedIntValue(from: container, forKey: .headerColumns)
        headerRows = Self.keyedIntValue(from: container, forKey: .headerRows)
        height = Self.keyedIntValue(from: container, forKey: .height)
        include = Self.keyedIntValue(from: container, forKey: .include)
        index = Self.keyedIntValue(from: container, forKey: .index) - 1     // use 0 based
        italic = Self.keyedBoolValue(from: container, forKey: .italic)
        legends = Self.keyedBoolValue(from: container, forKey: .legends)
        logx = Self.keyedBoolValue(from: container, forKey: .logx)
        logy = Self.keyedBoolValue(from: container, forKey: .logy)
        nameHeader = Self.keyedIntValue(from: container, forKey: .nameHeader) - 1   // use 0 based
        opacity = Self.keyedDoubleValue(from: container, forKey: .opacity)
        rowGrouping = Self.keyedBoolValue(from: container, forKey: .rowGrouping)
        sortx = Self.keyedBoolValue(from: container, forKey: .sortx)
        scatterPlots = Self.keyedIntValue(from: container, forKey: .scatterPlots)
        showDataPoints = Self.keyedIntValue(from: container, forKey: .showDataPoints)
        strokeWidth = Self.keyedDoubleValue(from: container, forKey: .strokeWidth)
        subTitle = Self.keyedStringValue(from: container, forKey: .subTitle)
        subTitleHeader = Self.keyedIntValue(from: container, forKey: .subTitleHeader) - 1   // use 0 based
        title = Self.keyedStringValue(from: container, forKey: .title)
        width = Self.keyedIntValue(from: container, forKey: .width)
        xTitle = Self.keyedStringValue(from: container, forKey: .xTitle)
        yTitle = Self.keyedStringValue(from: container, forKey: .yTitle)

        xMax = Self.keyedDoubleValue(from: container, forKey: .xMax)
        xMin = Self.keyedDoubleValue(from: container, forKey: .xMin)
        yMax = Self.keyedDoubleValue(from: container, forKey: .yMax)
        yMin = Self.keyedDoubleValue(from: container, forKey: .yMin)

        xTick = Self.keyedDoubleValue(from: container, forKey: .xTick)
        yTick = Self.keyedDoubleValue(from: container, forKey: .yTick)

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

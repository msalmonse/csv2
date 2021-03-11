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

    // Font sizes
    var axesSize: Double { return baseFontSize * 1.2 }
    var labelSize: Double { return baseFontSize }
    var legendSize: Double { return baseFontSize * 1.3 }
    var titleSize: Double { return baseFontSize * 2.5 }

    // svg title, x axis title and y axis title
    let title: String
    let xTitle: String
    let yTitle: String

    // Header rows and columns
    let headerColumns: Int
    let headerRows: Int
    var headers: Int { return inColumns ? headerRows : headerColumns }

    // Index for x values in csv data
    let index: Int

    // minimum and maximum for x and y axes
    // nil means not specified
    let xMax: Double
    let xMin: Double
    let yMax: Double
    let yMin: Double

    // Ticks on the x and y axes
    let xTick: Int
    let yTick: Int

    // Data is grouped in rows?
    let rowGrouping: Bool
    var inColumns: Bool { return !rowGrouping }
    var inRows: Bool { return rowGrouping }

    // Plats to show as scattered
    let scatterPlots: Int
    let shapes: [String]

    /// Test to see if a plot is a scatter plot
    /// - Parameter plot: plot number
    /// - Returns: true if a scatter plot

    func  scattered(_ plot: Int) -> Bool {
        return ((scatterPlots >> plot) & 1) == 1
    }

    // Path colours
    let colours: [String]
    // Force unassigned colours to black
    let black: Bool

    // Path stroke width
    let strokeWidth: Double

    // Path names
    let names: [String]

    /// Return the boolean default for the key
    /// - Parameter key: Coding key for Settings
    /// - Returns: bool default value

    private static func boolDefault(_ key: CodingKeys) -> Bool {
        switch key {
        case .black: return Defaults.black
        case .rowGrouping: return Defaults.rowGrouping
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
        case .strokeWidth: return Defaults.strokeWidth
        case .xMax: return Defaults.xMax
        case .xMin: return Defaults.xMin
        case .yMax: return Defaults.yMax
        case .yMin: return Defaults.yMin
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
        case .headerColumns: return Defaults.headers
        case .headerRows: return Defaults.headers
        case .height: return Defaults.height
        case .index: return Defaults.index
        case .scatterPlots: return Defaults.scattered
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

    /// Return the integer default for the key
    /// - Parameter key: Coding key for Settings
    /// - Returns: integer default value

    private static func stringDefault(_ key: CodingKeys) -> String {
        switch key {
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
        if arrayContainer != nil {
            while !arrayContainer!.isAtEnd {
                values.append((try? arrayContainer?.decode(String.self)) ?? "")
            }
        }

        return values
    }

    required init(from decoder: Decoder) {
        let container = try? decoder.container(keyedBy: CodingKeys.self)

        baseFontSize = Self.keyedDoubleValue(from: container, forKey: .baseFontSize)
        black = Self.keyedBoolValue(from: container, forKey: .black)
        headerColumns = Self.keyedIntValue(from: container, forKey: .headerColumns)
        headerRows = Self.keyedIntValue(from: container, forKey: .headerRows)
        height = Self.keyedIntValue(from: container, forKey: .height)
        index = Self.keyedIntValue(from: container, forKey: .index)
        rowGrouping = Self.keyedBoolValue(from: container, forKey: .rowGrouping)
        scatterPlots = Self.keyedIntValue(from: container, forKey: .scatterPlots)
        strokeWidth = Self.keyedDoubleValue(from: container, forKey: .strokeWidth)
        title = Self.keyedStringValue(from: container, forKey: .title)
        width = Self.keyedIntValue(from: container, forKey: .width)
        xTitle = Self.keyedStringValue(from: container, forKey: .xTitle)
        yTitle = Self.keyedStringValue(from: container, forKey: .yTitle)

        xMax = Self.keyedDoubleValue(from: container, forKey: .xMax)
        xMin = Self.keyedDoubleValue(from: container, forKey: .xMin)
        yMax = Self.keyedDoubleValue(from: container, forKey: .yMax)
        yMin = Self.keyedDoubleValue(from: container, forKey: .yMin)

        xTick = Self.keyedIntValue(from: container, forKey: .xTick)
        yTick = Self.keyedIntValue(from: container, forKey: .yTick)

        colours = Self.keyedStringArray(from: container, forKey: .colours)
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

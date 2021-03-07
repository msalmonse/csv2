//
//  Settings.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-16.
//

import Foundation

class Settings: Codable {
    // svg width and height
    let height: Int
    let width: Int

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
    let xMax: Double?
    let xMin: Double?
    let yMax: Double?
    let yMin: Double?

    // Ticks on the x and y axes
    let xTick: Int
    let yTick: Int

    // Data is grouped in columns?
    let inColumns: Bool

    // Path colours
    let colours: [String]

    // Path stroke width
    let strokeWidth: Int

    // Path names
    let names: [String]

    /// Convenience function to decode a keyed Int
    /// - Parameters:
    ///   - container: decoded data container
    ///   - key: the key into the decoded data
    ///   - defaultValue: the default value
    /// - Returns: decoded or default value

    private static func keyedIntValue(
        from container: KeyedDecodingContainer<CodingKeys>?,
        forKey key: CodingKeys,
        defaultValue: Int
    ) -> Int {
        if container == nil { return defaultValue }
        return (try? container!.decodeIfPresent(Int.self, forKey: key)) ?? defaultValue
    }

    /// Convenience function to decode a keyed Bool
    /// - Parameters:
    ///   - container: decoded data container
    ///   - key: the key into the decoded data
    ///   - defaultValue: the default value
    /// - Returns: decoded or default value

    private static func keyedBoolValue(
        from container: KeyedDecodingContainer<CodingKeys>?,
        forKey key: CodingKeys,
        defaultValue: Bool
    ) -> Bool {
        if container == nil { return defaultValue }
        return (try? container!.decodeIfPresent(Bool.self, forKey: key)) ?? defaultValue
    }

    /// Convenience function to decode a keyed String
    /// - Parameters:
    ///   - container: decoded data container
    ///   - key: the key into the decoded data
    ///   - defaultValue: the default value
    /// - Returns: decoded or default value

    private static func keyedStringValue(
        from container: KeyedDecodingContainer<CodingKeys>?,
        forKey key: CodingKeys,
        defaultValue: String
    ) -> String {
        if container == nil { return defaultValue }
        return (try? container!.decodeIfPresent(String.self, forKey: key)) ?? defaultValue
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

        headerColumns = Self.keyedIntValue(from: container, forKey: .headerColumns, defaultValue: 0)
        headerRows = Self.keyedIntValue(from: container, forKey: .headerRows, defaultValue: 0)
        height = Self.keyedIntValue(from: container, forKey: .height, defaultValue: 500)
        inColumns = Self.keyedBoolValue(from: container, forKey: .index, defaultValue: true)
        index = Self.keyedIntValue(from: container, forKey: .index, defaultValue: 0)
        strokeWidth = Self.keyedIntValue(from: container, forKey: .strokeWidth, defaultValue: 2)
        title = Self.keyedStringValue(from: container, forKey: .title, defaultValue: "")
        width = Self.keyedIntValue(from: container, forKey: .width, defaultValue: 500)
        xTitle = Self.keyedStringValue(from: container, forKey: .xTitle, defaultValue: "")
        yTitle = Self.keyedStringValue(from: container, forKey: .yTitle, defaultValue: "")

        xMax = try? container?.decodeIfPresent(Double.self, forKey: .xMax)
        xMin = try? container?.decodeIfPresent(Double.self, forKey: .xMin)
        yMax = try? container?.decodeIfPresent(Double.self, forKey: .yMax)
        yMin = try? container?.decodeIfPresent(Double.self, forKey: .yMin)

        xTick = Self.keyedIntValue(from: container, forKey: .xTick, defaultValue: -1)
        yTick = Self.keyedIntValue(from: container, forKey: .yTick, defaultValue: -1)

        colours = Self.keyedStringArray(from: container, forKey: .colours)
        names = Self.keyedStringArray(from: container, forKey: .names)
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

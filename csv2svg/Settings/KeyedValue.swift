//
//  KeyedValue.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-30.
//

import Foundation

extension Settings {

    /// Return the boolean default for the key
    /// - Parameter key: Coding key for Settings
    /// - Returns: bool default value

    private static func boolDefault(_ key: CodingKeys, _ defaults: Defaults) -> Bool {
        switch key {
        case .black: return defaults.black
        case .bold: return defaults.bold
        case .italic: return defaults.italic
        case .legends: return defaults.legends
        case .logx: return defaults.logx
        case .logy: return defaults.logy
        case .rowGrouping: return defaults.rowGrouping
        case .sortx: return defaults.sortx
        default: return false
        }
    }

    /// Convenience function to decode a keyed Bool
    /// - Parameters:
    ///   - container: decoded data container
    ///   - key: the key into the decoded data
    ///   - defaultValue: the default value
    /// - Returns: decoded or default value

    static func keyedBoolValue(
        from container: KeyedDecodingContainer<CodingKeys>?,
        forKey key: CodingKeys,
        defaults: Defaults
    ) -> Bool {
        if container == nil { return boolDefault(key, defaults) }
        return (try? container!.decodeIfPresent(Bool.self, forKey: key)) ?? boolDefault(key, defaults)
    }

    /// Return the integer default for the key
    /// - Parameter key: Coding key for Settings
    /// - Returns: integer default value

    private static func doubleDefault(_ key: CodingKeys, _ defaults: Defaults) -> Double {
        switch key {
        case .baseFontSize: return defaults.baseFontSize
        case .dataPointDistance: return defaults.dataPointDistance
        case .logoHeight: return defaults.logoHeight
        case .logoWidth: return defaults.logoWidth
        case .opacity: return defaults.opacity
        case .reserveBottom: return defaults.reserveBottom
        case .reserveLeft: return defaults.reserveLeft
        case .reserveRight: return defaults.reserveRight
        case .reserveTop: return defaults.reserveTop
        case .smooth: return defaults.smooth
        case .strokeWidth: return defaults.strokeWidth
        case .xMax: return defaults.xMax
        case .xMin: return defaults.xMin
        case .xTick: return defaults.xTick
        case .yMax: return defaults.yMax
        case .yMin: return defaults.yMin
        case .yTick: return defaults.yTick
        default: return 0.0
        }
    }

    /// Convenience function to decode a keyed Int
    /// - Parameters:
    ///   - container: decoded data container
    ///   - key: the key into the decoded data
    /// - Returns: decoded or default value

    static func keyedDoubleValue(
        from container: KeyedDecodingContainer<CodingKeys>?,
        forKey key: CodingKeys,
        defaults: Defaults
    ) -> Double {
        if container == nil { return doubleDefault(key, defaults) }
        return (try? container!.decodeIfPresent(Double.self, forKey: key)) ?? doubleDefault(key, defaults)
    }

    /// Return the integer default for the key
    /// - Parameter key: Coding key for Settings
    /// - Returns: integer default value

    private static func intDefault(_ key: CodingKeys, _ defaults: Defaults) -> Int {
        switch key {
        case .dashedLines: return defaults.dashedLines
        case .headerColumns: return defaults.headers
        case .headerRows: return defaults.headers
        case .height: return defaults.height
        case .include: return defaults.include
        case .index: return defaults.index
        case .nameHeader: return defaults.nameHeader
        case .scatterPlots: return defaults.scattered
        case .showDataPoints: return defaults.showDataPoints
        case .subTitleHeader: return defaults.subTitleHeader
        case .width: return defaults.width
        default: return 0
        }
    }

    /// Convenience function to decode a keyed Int
    /// - Parameters:
    ///   - container: decoded data container
    ///   - key: the key into the decoded data
    ///   - defaultValue: the default value
    /// - Returns: decoded or default value

    static func keyedIntValue(
        from container: KeyedDecodingContainer<CodingKeys>?,
        forKey key: CodingKeys,
        defaults: Defaults
    ) -> Int {
        if container == nil { return intDefault(key, defaults) }
        return (try? container!.decodeIfPresent(Int.self, forKey: key)) ?? intDefault(key, defaults)
    }

    /// Return the string default for the key
    /// - Parameter key: Coding key for Settings
    /// - Returns: integer default value

    private static func stringDefault(_ key: CodingKeys, _ defaults: Defaults) -> String {
        switch key {
        case .backgroundColour: return defaults.backgroundColour
        case .cssID: return defaults.cssID
        case .cssInclude: return defaults.cssInclude
        case .fontFamily: return defaults.fontFamily
        case .logoURL: return defaults.logoURL
        case .subTitle: return defaults.subTitle
        case .svgInclude: return defaults.svgInclude
        case .title: return defaults.title
        default: return ""
        }
    }

    /// Convenience function to decode a keyed String
    /// - Parameters:
    ///   - container: decoded data container
    ///   - key: the key into the decoded data
    ///   - defaultValue: the default value
    /// - Returns: decoded or default value

    static func keyedStringValue(
        from container: KeyedDecodingContainer<CodingKeys>?,
        forKey key: CodingKeys,
        defaults: Defaults
    ) -> String {
        if container == nil { return stringDefault(key, defaults) }
        return (try? container!.decodeIfPresent(String.self, forKey: key)) ?? stringDefault(key, defaults)
    }

    /// Return the integer default for the key
    /// - Parameter key: Coding key for Settings
    /// - Returns: integer default value

    private static func stringArrayDefault(_ key: CodingKeys, _ defaults: Defaults) -> [String] {
        switch key {
        case .colours: return defaults.colours
        case .cssClasses: return defaults.cssClasses
        case .cssExtras: return defaults.cssExtras
        case .dashes: return defaults.dashes
        case .names: return defaults.names
        case .shapes: return defaults.shapes
        default: return []
        }
    }

    /// Convenience function to decode a keyed String Array
    /// - Parameters:
    ///   - container: decoded data container
    ///   - key: the key into the decoded data
    ///   - defaultValue: the default value
    /// - Returns: decoded or default value

    static func keyedStringArray(
        from container: KeyedDecodingContainer<CodingKeys>?,
        forKey key: CodingKeys,
        defaults: Defaults
    ) -> [String] {
        var values: [String] = []
        var arrayContainer = try? container?.nestedUnkeyedContainer(forKey: key)
        if arrayContainer == nil { return stringArrayDefault(key, defaults) }
        while !arrayContainer!.isAtEnd {
            values.append((try? arrayContainer?.decode(String.self)) ?? "")
        }

        return values
    }

}

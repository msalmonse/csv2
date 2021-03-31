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

    static func keyedBoolValue(
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
        case .logoHeight: return Defaults.logoHeight
        case .logoWidth: return Defaults.logoWidth
        case .opacity: return Defaults.opacity
        case .reserveBottom: return Defaults.reserveBottom
        case .reserveLeft: return Defaults.reserveLeft
        case .reserveRight: return Defaults.reserveRight
        case .reserveTop: return Defaults.reserveTop
        case .smooth: return Defaults.smooth
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

    static func keyedDoubleValue(
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

    static func keyedIntValue(
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
        case .cssID: return Defaults.cssID
        case .cssInclude: return Defaults.cssInclude
        case .fontFamily: return Defaults.fontFamily
        case .logoURL: return Defaults.logoURL
        case .subTitle: return Defaults.subTitle
        case .svgInclude: return Defaults.svgInclude
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

    static func keyedStringValue(
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
        case .cssClasses: return Defaults.cssClasses
        case .cssExtras: return Defaults.cssExtras
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

    static func keyedStringArray(
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

}

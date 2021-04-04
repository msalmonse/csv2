//
//  KeyedValue.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-30.
//

import Foundation

extension Settings {

    private static func outOfRange(val: String, range: String, substitute: String, key: CodingKeys) {
        print("""
                \(val) is not allowed for parameter \(key.name).
                The allowed range is \(range), \(substitute) substituted.
                """,
                to: &standardError
            )
    }

    /// Check to see that the default value is the same as the global default
    /// - Parameters:
    ///   - key: Coding key for Settings
    ///   - defaults: the command line defaults
    /// - Returns: true if they are not the same

    private static func boolIsChanged(_ key: CodingKeys, _ defaults: Defaults) -> Bool {
        return boolDefault(key, defaults) != boolDefault(key, Defaults.global)
    }

    /// Return the boolean default for the key
    /// - Parameters:
    ///   - key: Coding key for Settings
    ///   - defaults: the command line defaults
    /// - Returns: bool default value

    private static func boolDefault(_ key: CodingKeys, _ defaults: Defaults) -> Bool {
        switch key {
        case .black: return defaults.black
        case .bold: return defaults.bold
        case .comment: return defaults.comment
        case .hover: return defaults.hover
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
    ///   - defaults: the command line defaults
    /// - Returns: decoded or default value

    static func keyedBoolValue(
        from container: KeyedDecodingContainer<CodingKeys>?,
        forKey key: CodingKeys,
        defaults: Defaults
    ) -> Bool {
        if container == nil || boolIsChanged(key, defaults) { return boolDefault(key, defaults) }
        return (try? container!.decodeIfPresent(Bool.self, forKey: key)) ?? boolDefault(key, defaults)
    }

    /// Check to see that the default value is the same as the global default
    /// - Parameters:
    ///   - key: Coding key for Settings
    ///   - defaults: the command line defaults
    /// - Returns: true if they are the same

    private static func doubleIsChanged(_ key: CodingKeys, _ defaults: Defaults) -> Bool {
        return doubleDefault(key, defaults) != doubleDefault(key, Defaults.global)
    }

    /// Return the integer default for the key
    /// - Parameters:
    ///   - key: Coding key for Settings
    ///   - defaults: the command line defaults
    /// - Returns: integer default value

    private static func doubleDefault(_ key: CodingKeys, _ defaults: Defaults) -> Double {
        switch key {
        case .baseFontSize: return defaults.baseFontSize
        case .bezier: return defaults.bezier
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
    ///   - defaults: the command line defaults
    ///   - in: optional range of allowed values
    /// - Returns: decoded or default value

    static func keyedDoubleValue(
        from container: KeyedDecodingContainer<CodingKeys>?,
        forKey key: CodingKeys,
        defaults: Defaults,
        in ok: ClosedRange<Double>? = nil
    ) -> Double {
        if container == nil { return doubleDefault(key, defaults) }
        let val = doubleIsChanged(key, defaults) ? doubleDefault(key, defaults)
            : (try? container!.decodeIfPresent(Double.self, forKey: key)) ?? doubleDefault(key, defaults)
        if let ok = ok, !ok.contains(val) {
            let okVal = doubleDefault(key, Defaults.global)
            outOfRange(val: "\(val)", range: "\(ok)", substitute: "\(okVal)", key: key)
            return okVal
        }
        return val
    }

    /// Check to see that the default value is the same as the global default
    /// - Parameters:
    ///   - key: Coding key for Settings
    ///   - defaults: the command line defaults
    /// - Returns: true if they are not the same

    private static func intIsChanged(_ key: CodingKeys, _ defaults: Defaults) -> Bool {
        return intDefault(key, defaults) != intDefault(key, Defaults.global)
    }

    /// Return the integer default for the key
    /// - Parameters:
    ///   - key: Coding key for Settings
    ///   - defaults: the command line defaults
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
    ///   - defaults: the defaults from the command line
    ///   - in: the allowed range
    /// - Returns: decoded or default value

    static func keyedIntValue(
        from container: KeyedDecodingContainer<CodingKeys>?,
        forKey key: CodingKeys,
        defaults: Defaults,
        in ok: ClosedRange<Int>? = nil
    ) -> Int {
        if container == nil { return intDefault(key, defaults) }
        let val = intIsChanged(key, defaults) ? intDefault(key, defaults)
            : (try? container!.decodeIfPresent(Int.self, forKey: key)) ?? intDefault(key, defaults)
        if let ok = ok, !ok.contains(val) {
            let okVal = intDefault(key, Defaults.global)
            outOfRange(val: "\(val)", range: "\(ok)", substitute: "\(okVal)", key: key)
            return okVal
        }
        return val
    }

    /// Check to see that the default value is the same as the global default
    /// - Parameters:
    ///   - key: Coding key for Settings
    ///   - defaults: the command line defaults
    /// - Returns: true if they are not the same

    private static func stringIsChanged(_ key: CodingKeys, _ defaults: Defaults) -> Bool {
        return stringDefault(key, defaults) != stringDefault(key, Defaults.global)
    }

    /// Return the string default for the key
    /// - Parameters:
    ///   - key: Coding key for Settings
    ///   - defaults: the command line defaults
    /// - Returns: string default value

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
    ///   - key: Coding key for Settings
    ///   - defaults: the command line defaults
    /// - Returns: decoded or default value

    static func keyedStringValue(
        from container: KeyedDecodingContainer<CodingKeys>?,
        forKey key: CodingKeys,
        defaults: Defaults
    ) -> String {
        if container == nil || stringIsChanged(key, defaults) { return stringDefault(key, defaults) }
        return (try? container!.decodeIfPresent(String.self, forKey: key)) ?? stringDefault(key, defaults)
    }

    /// Check to see that the default value is the same as the global default
    /// - Parameters:
    ///   - key: Coding key for Settings
    ///   - defaults: the command line defaults
    /// - Returns: true if they are not the same

    private static func stringArrayIsChanged(_ key: CodingKeys, _ defaults: Defaults) -> Bool {
        return stringArrayDefault(key, defaults) != stringArrayDefault(key, Defaults.global)
    }

    /// Return the integer default for the key
    /// - Parameters:
    ///   - key: Coding key for Settings
    ///   - defaults: the command line defaults
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
    ///   - defaults: the command line defaults
    /// - Returns: decoded or default value

    static func keyedStringArray(
        from container: KeyedDecodingContainer<CodingKeys>?,
        forKey key: CodingKeys,
        defaults: Defaults
    ) -> [String] {
        if stringArrayIsChanged(key, defaults) { return stringArrayDefault(key, defaults) }
        var values: [String] = []
        var arrayContainer = try? container?.nestedUnkeyedContainer(forKey: key)
        if arrayContainer == nil { return stringArrayDefault(key, defaults) }
        while !arrayContainer!.isAtEnd {
            values.append((try? arrayContainer?.decode(String.self)) ?? "")
        }

        return values
    }
}

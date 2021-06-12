//
//  Defaults.swift
//  csv2
//
//  Created by Michael Salmon on 2021-03-08.
//

import Foundation

private let initialDefaults: SettingsDict = [
    .backgroundColour: .colourValue(val: .clear),
    .barOffset: .doubleMinusOne,
    .barWidth: .doubleMinusOne,
    .baseFontSize: .doubleValue(val: 10.0),
    .bounded: .boolTrue,
    .canvasID: .stringValue(val: "csvplot"),
    .chartType: .stringValue(val: "horizontal"),
    .comment: .boolTrue,
    .dataPointDistance: .doubleValue(val: 10.0),
    .draftText: .stringValue(val: "DRAFT"),
    .fontFamily: .stringValue(val: "serif"),
    .foregroundColour: .colourValue(val: .black),
    .height: .intValue(val: 600),
    .hover: .boolTrue,
    .include: .bitmapValue(val: BitMap.all),
    .legends: .boolTrue,
    .logoHeight: .doubleValue(val: 64.0),
    .logoWidth: .doubleValue(val: 64.0),
    .nameHeader: .intValue(val: 1),
    .opacity: .doubleValue(val: 1.0),
    .strokeWidth: .doubleValue(val: 2.0),
    .textcolour: .colourValue(val: .black),
    .width: .intValue(val: 800),
    .xMax: .doubleMax,
    .xMin: .doubleMin,
    .yMax: .doubleMax,
    .yMin: .doubleMin
]

// App defaults

struct Defaults {
    static let maxDefault = -Double.infinity
    static let minDefault = Double.infinity

    // Ranges for bounds checking
    static let baseFontSizeBounds = 1.0...100.0
    static let bezierBounds = 0.0...0.5
    static let headerBounds = 0...25
    static let opacityBounds = 0.0...1.0
    static let smoothBounds = 0.0...0.99
    static let strokeWidthBounds = 0.1...100.0

    // Default values
    private var values: SettingsValues

    // This set is used to tag those values set on the command line
    private var onCommandLine: SettingsSet = []

    init() {
        values = SettingsValues(values: initialDefaults)
    }

    /// Should bounds be checked?
    var bounded: Bool {
        get { boolValue(.bounded) }
        set { values.setValue(.bounded, .boolValue(val: newValue)) }
    }

    /// Indicate that a setting was found on the command line
    /// - Parameter key: key found

    mutating func onCLI(_ key: Settings.CodingKeys) {
        onCommandLine.insert(key)
    }

    /// Was a setting found on the command line
    /// - Parameter key: setting key
    /// - Returns: true if found

    func isOnCLI(_ key: Settings.CodingKeys) -> Bool {
        return onCommandLine.contains(key)
    }

    /// Set a value in the SettingsValues dict
    /// - Parameters:
    ///   - key: key into dict
    ///   - value: value to store

    mutating func setValue(_ key: Settings.CodingKeys, _ value: SettingsValue) {
        values.setValue(key, value)
    }

    /// Fetch a BitMap value
    /// - Parameters:
    ///   - key: key in domain
    ///   - domain: domain for key
    /// - Returns: Bool value

    func bitmapValue(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> BitMap {
        return values.bitmapValue(key, in: domain)
    }

    /// Fetch a Bool value
    /// - Parameter key: key of value to fetch
    /// - Returns: Bool value

    func boolValue(_ key: Settings.CodingKeys) -> Bool {
        return values.boolValue(key)
    }

    /// Fetch a Colour value
    /// - Parameters:
    ///   - key: key in domain
    ///   - domain: domain for key
    /// - Returns: String value

    func colourValue(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> RGBAu8? {
        return values.colourValue(key, in: domain)
    }

    /// Fetch a Colour array
    /// - Parameters:
    ///   - key: key in domain
    ///   - domain: domain for key
    /// - Returns: String array

    func colourArray(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> [RGBAu8]? {
        return values.colourArray(key, in: domain)
    }

    /// Fetch a Double value
    /// - Parameter key: key of value to fetch
    /// - Returns: Double value

    func doubleValue(_ key: Settings.CodingKeys) -> Double {
        return values.doubleValue(key)
    }

    /// Fetch an Int Array
    /// - Parameters:
    ///   - key: key in domain
    ///   - domain: domain for key
    /// - Returns: Int Array

    func intArray(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> [Int] {
        return values.intArray(key, in: domain)
    }

    /// Fetch an Int value
    /// - Parameter key: key of value to fetch
    /// - Returns: Int value

    func intValue(_ key: Settings.CodingKeys) -> Int {
        return values.intValue(key)
    }

    /// Fetch a String value
    /// - Parameter key: key of value to fetch
    /// - Returns: String value

    func stringValue(_ key: Settings.CodingKeys) -> String {
        return values.stringValue(key)
    }

    /// Fetch a String array
    /// - Parameter key: key of array to fetch
    /// - Returns: String array

    func stringArray(_ key: Settings.CodingKeys) -> [String] {
        return values.stringArray(key)
    }

    static var initial = Defaults()
}

//
//  Defaults.swift
//  csv2
//
//  Created by Michael Salmon on 2021-03-08.
//

import Foundation

private let initialDefaults: SettingsDict = [
    .backgroundColour: .stringValue(val: "clear"),
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
    .foregroundColour: .stringValue(val: "black"),
    .height: .intValue(val: 600),
    .hover: .boolTrue,
    .include: .intMinusOne,
    .legends: .boolTrue,
    .logoHeight: .doubleValue(val: 64.0),
    .logoWidth: .doubleValue(val: 64.0),
    .nameHeader: .intValue(val: 1),
    .opacity: .doubleValue(val: 1.0),
    .strokeWidth: .doubleValue(val: 2.0),
    .textcolour: .stringValue(val: "black"),
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

    var bounded: Bool {
        get { boolValue(.bounded) }
        set { values.setValue(.bounded, .boolValue(val: newValue)) }
    }

    mutating func onCLI(_ key: Settings.CodingKeys) {
        onCommandLine.insert(key)
    }

    func isOnCLI(_ key: Settings.CodingKeys) -> Bool {
        return onCommandLine.contains(key)
    }

    mutating func setValue(_ key: Settings.CodingKeys, _ value: SettingsValue) {
        values.setValue(key, value)
    }

    func boolValue(_ key: Settings.CodingKeys) -> Bool {
        return values.boolValue(key)
    }

    func doubleValue(_ key: Settings.CodingKeys) -> Double {
        return values.doubleValue(key)
    }

    func intValue(_ key: Settings.CodingKeys) -> Int {
        return values.intValue(key)
    }

    func stringValue(_ key: Settings.CodingKeys) -> String {
        return values.stringValue(key)
    }

    func stringArray(_ key: Settings.CodingKeys) -> [String] {
        return values.stringArray(key)
    }

    static var initial = Defaults()
}

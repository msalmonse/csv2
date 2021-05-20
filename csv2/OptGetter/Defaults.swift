//
//  Defaults.swift
//  csv2
//
//  Created by Michael Salmon on 2021-03-08.
//

import Foundation

/// Holder for default values

enum DefaultValues: Equatable {
    case boolValue(val: Bool)
    case doubleValue(val: Double)
    case intValue(val: Int)
    case stringArray(val: [String])
    case stringValue(val: String)

    static let boolFalse = Self.boolValue(val: false)
    static let boolTrue = Self.boolValue(val: true)
    static let doubleMax = Self.doubleValue(val: Defaults.maxDefault)
    static let doubleMin = Self.doubleValue(val: Defaults.minDefault)
    static let doubleMinusOne = Self.doubleValue(val: -1.0)
    static let doubleZero = Self.doubleValue(val: 0.0)
    static let intMinusOne = Self.intValue(val: -1)
    static let intZero = Self.intValue(val: 0)
    static let stringArrayEmpty = Self.stringArray(val: [])
    static let stringEmpty = Self.stringValue(val: "")
}

typealias DefaultDict = [Settings.CodingKeys: DefaultValues]
typealias SettingsSet = Set<Settings.CodingKeys>

private let globalDefaults: DefaultDict = [
    .backgroundColour: .stringValue(val: "clear"),
    .bared: .intZero,
    .barOffset: .doubleMinusOne,
    .barWidth: .doubleMinusOne,
    .baseFontSize: .doubleValue(val: 10.0),
    .bezier: .doubleZero,
    .black: .boolFalse,
    .bold: .boolFalse,
    .bounded: .boolTrue,
    .canvasID: .stringValue(val: "csvplot"),
    .chartType: .stringValue(val: "horizontal"),
    .comment: .boolTrue,
    .dashedLines: .intZero,
    .dataPointDistance: .doubleValue(val: 10.0),
    .filled: .intZero,
    .fontFamily: .stringValue(val: "serif"),
    .foregroundColour: .stringValue(val: "black"),
    .headerColumns: .intZero,
    .headerRows: .intZero,
    .height: .intValue(val: 600),
    .hover: .boolTrue,
    .include: .intMinusOne,
    .index: .intZero,
    .italic: .boolFalse,
    .legends: .boolTrue,
    .logoHeight: .doubleValue(val: 64.0),
    .logoWidth: .doubleValue(val: 64.0),
    .logx: .boolFalse,
    .logy: .boolFalse,
    .nameHeader: .intValue(val: 1),
    .opacity: .doubleValue(val: 1.0),
    .reserveBottom: .doubleZero,
    .reserveLeft: .doubleZero,
    .reserveRight: .doubleZero,
    .reserveTop: .doubleZero,
    .rowGrouping: .boolFalse,
    .scatterPlots: .intZero,
    .showDataPoints: .intZero,
    .sortx: .boolFalse,
    .smooth: .doubleZero,
    .strokeWidth: .doubleValue(val: 2.0),
    .subTitleHeader: .intZero,
    .textcolour: .stringValue(val: "black"),
    .width: .intValue(val: 800),
    .xMax: .doubleMax,
    .xMin: .doubleMin,
    .xTagsHeader: .intZero,
    .xTick: .doubleZero,
    .yMax: .doubleMax,
    .yMin: .doubleMin,
    .yTick: .doubleZero
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
    var values = globalDefaults

    // This set is used to tag those values set on the command line
    var onCommandLine: SettingsSet = []

    var bounded: Bool {
        get { boolValue(.bounded) }
        set { values[.bounded] = .boolValue(val: newValue) }
    }

    func fromCLI(_ key: Settings.CodingKeys) -> Bool {
        return onCommandLine.contains(key)
    }

    func boolValue(_ key: Settings.CodingKeys) -> Bool {
        switch values[key] ?? .boolFalse {
        case .boolValue(let val): return val
        default: return false
        }
    }

    func doubleValue(_ key: Settings.CodingKeys) -> Double {
        switch values[key] ?? .doubleZero {
        case .doubleValue(let val): return val
        default: return 0.0
        }
    }

    func intValue(_ key: Settings.CodingKeys) -> Int {
        switch values[key] ?? .intZero {
        case .intValue(let val): return val
        default: return 0
        }
    }

    func stringValue(_ key: Settings.CodingKeys) -> String {
        switch values[key] ?? .stringArrayEmpty {
        case .stringValue(let val): return val
        default: return ""
        }
    }

    func stringArray(_ key: Settings.CodingKeys) -> [String] {
        switch values[key] ?? .stringArrayEmpty {
        case .stringArray(let val): return val
        default: return []
        }
    }

    static var global = Defaults()
}

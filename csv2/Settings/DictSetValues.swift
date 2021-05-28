//
//  DictSetValues.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-28.
//

import Foundation

/// Holder for settings values

enum SettingsValue: Equatable {
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

    func unexpectedValue(expected: String, for key: Settings.CodingKeys) {
        func printGot(_ got: String) {
            print("Expected \(expected) but got \(got) for key: \(key)", to: &standardError)
        }

        switch self {
        case .boolValue: printGot("Bool")
        case .doubleValue: printGot("Double")
        case .intValue: printGot("Int")
        case .stringArray: printGot("String Array")
        case .stringValue: printGot("String")
        }
    }
}

typealias SettingsDict = [Settings.CodingKeys: SettingsValue]
typealias SettingsSet = Set<Settings.CodingKeys>

struct SettingsValues {
    var values: SettingsDict = [:]

    mutating func setValue(_ key: Settings.CodingKeys, _ value: SettingsValue) {
        values[key] = value
    }
    
    func boolValue(_ key: Settings.CodingKeys) -> Bool {
        let keyVal = values[key] ?? .boolFalse
        switch keyVal {
        case .boolValue(let val): return val
        default:
            keyVal.unexpectedValue(expected: "Bool", for: key)
            return false
        }
    }

    func doubleValue(_ key: Settings.CodingKeys) -> Double {
        let keyVal = values[key] ?? .doubleZero
        switch keyVal {
        case .doubleValue(let val): return val
        default:
            keyVal.unexpectedValue(expected: "Double", for: key)
            return 0.0
        }
    }

    func intValue(_ key: Settings.CodingKeys) -> Int {
        let keyVal = values[key] ?? .intZero
        switch keyVal {
        case .intValue(let val): return val
        default:
            keyVal.unexpectedValue(expected: "Int", for: key)
            return 0
        }
    }

    func stringValue(_ key: Settings.CodingKeys) -> String {
        let keyVal = values[key] ?? .stringEmpty
        switch keyVal {
        case .stringValue(let val): return val
        default:
            keyVal.unexpectedValue(expected: "String", for: key)
            return ""
        }
    }

    func stringArray(_ key: Settings.CodingKeys) -> [String] {
        let keyVal = values[key] ?? .stringArrayEmpty
        switch keyVal {
        case .stringArray(let val): return val
        default:
            keyVal.unexpectedValue(expected: "String Array", for: key)
            return []
        }
    }
}

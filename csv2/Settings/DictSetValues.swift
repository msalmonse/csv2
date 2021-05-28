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

enum DomainKey {
    case foreground
    case pdf
    case topLevel
}

struct CombinedKey: Hashable {
    let domain: DomainKey
    let key: Settings.CodingKeys
}

typealias SettingsDict = [Settings.CodingKeys: SettingsValue]
typealias DomainDict = [CombinedKey: SettingsValue]
typealias SettingsSet = Set<Settings.CodingKeys>

struct SettingsValues {
    private var values: DomainDict = [:]

    /// Initialize dictionary
    /// - Parameters:
    ///   - values: the initial values
    ///   - domain: domain for values

    init(values: SettingsDict = [:], in domain: DomainKey = .topLevel) {
        for (key, val) in values {
            self.values[CombinedKey(domain: domain, key: key)] = val
        }
    }

    /// Set a value in the values dictionary
    /// - Parameters:
    ///   - key: key to dict
    ///   - value: value to insert
    ///   - domain: domain for key

    mutating func setValue(
        _ key: Settings.CodingKeys,
        _ value: SettingsValue,
        in domain: DomainKey = .topLevel
    ) {
        values[CombinedKey(domain: domain, key: key)] = value
    }

    /// Lookup Bool value
    /// - Parameters:
    ///   - key: key to dict
    ///   - domain: domain for key
    /// - Returns: Bool from dict

    func boolValue(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> Bool {
        let keyVal = values[CombinedKey(domain: domain, key: key)] ?? .boolFalse
        switch keyVal {
        case .boolValue(let val): return val
        default:
            keyVal.unexpectedValue(expected: "Bool", for: key)
            return false
        }
    }

    /// Lookup Double value
    /// - Parameters:
    ///   - key: key to dict
    ///   - domain: domain for key
    /// - Returns: Double from dict

    func doubleValue(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> Double {
        let keyVal = values[CombinedKey(domain: domain, key: key)] ?? .doubleZero
        switch keyVal {
        case .doubleValue(let val): return val
        default:
            keyVal.unexpectedValue(expected: "Double", for: key)
            return 0.0
        }
    }

    /// Lookup Int  value
    /// - Parameters:
    ///   - key: key to dict
    ///   - domain: domain for key
    /// - Returns: Int from dict

    func intValue(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> Int {
        let keyVal = values[CombinedKey(domain: domain, key: key)] ?? .intZero
        switch keyVal {
        case .intValue(let val): return val
        default:
            keyVal.unexpectedValue(expected: "Int", for: key)
            return 0
        }
    }

    /// Lookup String value
    /// - Parameters:
    ///   - key: key to dict
    ///   - domain: domain for key
    /// - Returns: String from dict

    func stringValue(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> String {
        let keyVal = values[CombinedKey(domain: domain, key: key)] ?? .stringEmpty
        switch keyVal {
        case .stringValue(let val): return val
        default:
            keyVal.unexpectedValue(expected: "String", for: key)
            return ""
        }
    }

    /// Lookup String Array value
    /// - Parameters:
    ///   - key: key to dict
    ///   - domain: domain for key
    /// - Returns: String Array from dict

    func stringArray(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> [String] {
        let keyVal = values[CombinedKey(domain: domain, key: key)] ?? .stringArrayEmpty
        switch keyVal {
        case .stringArray(let val): return val
        default:
            keyVal.unexpectedValue(expected: "String Array", for: key)
            return []
        }
    }
}

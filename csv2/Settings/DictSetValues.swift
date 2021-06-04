//
//  DictSetValues.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-28.
//

import Foundation

/// Holder for settings values

enum SettingsValue: Equatable {
    case bitmapValue(val: BitMap)
    case boolValue(val: Bool)
    case doubleValue(val: Double)
    case intArray(val: [Int])
    case intValue(val: Int)
    case stringArray(val: [String])
    case stringValue(val: String)

    static let bitmapNone = Self.bitmapValue(val: BitMap.none)
    static let boolFalse = Self.boolValue(val: false)
    static let boolTrue = Self.boolValue(val: true)
    static let doubleMax = Self.doubleValue(val: Defaults.maxDefault)
    static let doubleMin = Self.doubleValue(val: Defaults.minDefault)
    static let doubleMinusOne = Self.doubleValue(val: -1.0)
    static let doubleZero = Self.doubleValue(val: 0.0)
    static let intEmpty = Self.intArray(val: [])
    static let intZero = Self.intValue(val: 0)
    static let stringArrayEmpty = Self.stringArray(val: [])
    static let stringEmpty = Self.stringValue(val: "")

    func unexpectedValue(expected: String, for key: Settings.CodingKeys) {
        func printGot(_ got: String) {
            print("Expected \(expected) but got \(got) for key: \(key.name)", to: &standardError)
        }

        switch self {
        case .bitmapValue: printGot("BitMap")
        case .boolValue: printGot("Bool")
        case .doubleValue: printGot("Double")
        case .intArray: printGot("Int Array")
        case .intValue: printGot("Int")
        case .stringArray: printGot("String Array")
        case .stringValue: printGot("String")
        }
    }
}

enum DomainKey {
    case canvas
    case foreground
    case pdf
    case topLevel
    case svg
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
    ///   - key: key in domain
    ///   - value: value to insert
    ///   - domain: domain for key

    mutating func setValue(
        _ key: Settings.CodingKeys,
        _ value: SettingsValue?,
        in domain: DomainKey = .topLevel
    ) {
        values[CombinedKey(domain: domain, key: key)] = value
    }

    /// Lookup BitMap value
    /// - Parameters:
    ///   - key: key in domain
    ///   - domain: domain for key
    /// - Returns: BitMap from dict

    func bitmapValue(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> BitMap {
        let keyVal = values[CombinedKey(domain: domain, key: key)] ?? .bitmapNone
        switch keyVal {
        case let .bitmapValue(val): return val
        default:
            keyVal.unexpectedValue(expected: "BitMap", for: key)
            return BitMap.none
        }
    }

    /// Lookup Bool value
    /// - Parameters:
    ///   - key: key in domain
    ///   - domain: domain for key
    /// - Returns: Bool from dict

    func boolValue(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> Bool {
        let keyVal = values[CombinedKey(domain: domain, key: key)] ?? .boolFalse
        switch keyVal {
        case let .boolValue(val): return val
        default:
            keyVal.unexpectedValue(expected: "Bool", for: key)
            return false
        }
    }

    /// Lookup Double value
    /// - Parameters:
    ///   - key: key in domain
    ///   - domain: domain for key
    /// - Returns: Double from dict

    func doubleValue(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> Double {
        let keyVal = values[CombinedKey(domain: domain, key: key)] ?? .doubleZero
        switch keyVal {
        case let .doubleValue(val): return val
        case let .intValue(val): return Double(val)
        default:
            keyVal.unexpectedValue(expected: "Double", for: key)
            return 0.0
        }
    }

    /// Check string for content
    /// - Parameters:
    ///   - key: key in domain
    ///   - domain: domain for key
    /// - Returns: True is string is found and not empty

    func hasContent(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> Bool {
        guard let keyVal = values[CombinedKey(domain: domain, key: key)] else { return false }
        switch keyVal {
        case let .stringValue(val): return val.hasContent
        default:
            keyVal.unexpectedValue(expected: "String", for: key)
            return false
        }
    }

    /// Lookup Int  Array
    /// - Parameters:
    ///   - key: key in domain
    ///   - domain: domain for key
    /// - Returns: Int Array from dict

    func intArray(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> [Int] {
        let keyVal = values[CombinedKey(domain: domain, key: key)] ?? .intEmpty
        switch keyVal {
        case let .bitmapValue(val): return val.intArray()
        case let .intArray(val): return val
        default:
            keyVal.unexpectedValue(expected: "Int Array", for: key)
            return []
        }
    }

    /// Lookup Int  value
    /// - Parameters:
    ///   - key: key in domain
    ///   - domain: domain for key
    /// - Returns: Int from dict

    func intValue(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> Int {
        let keyVal = values[CombinedKey(domain: domain, key: key)] ?? .intZero
        switch keyVal {
        case let .bitmapValue(val):
            print("BitMap converted to Int for \(key.stringValue)", to: &standardError)
            return val.intValue
        case let .intValue(val): return val
        default:
            keyVal.unexpectedValue(expected: "Int", for: key)
            return 0
        }
    }

    /// Lookup String value
    /// - Parameters:
    ///   - key: key in domain
    ///   - domain: domain for key
    /// - Returns: String from dict or nil if missing

    func optionalStringValue(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> String? {
        guard let keyVal = values[CombinedKey(domain: domain, key: key)] else { return nil }
        switch keyVal {
        case let .stringValue(val): return val.isEmpty ? nil : val
        default:
            keyVal.unexpectedValue(expected: "String", for: key)
            return nil
        }
    }

    /// Lookup String value
    /// - Parameters:
    ///   - key: key in domain
    ///   - domain: domain for key
    /// - Returns: String from dict

    func stringValue(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> String {
        let keyVal = values[CombinedKey(domain: domain, key: key)] ?? .stringEmpty
        switch keyVal {
        case let .stringValue(val): return val
        default:
            keyVal.unexpectedValue(expected: "String", for: key)
            return ""
        }
    }

    /// Lookup String Array value
    /// - Parameters:
    ///   - key: key in domain
    ///   - domain: domain for key
    /// - Returns: String Array from dict

    func stringArray(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> [String] {
        let keyVal = values[CombinedKey(domain: domain, key: key)] ?? .stringArrayEmpty
        switch keyVal {
        case let .stringArray(val): return val
        default:
            keyVal.unexpectedValue(expected: "String Array", for: key)
            return []
        }
    }

    /// Lookup  value
    /// - Parameters:
    ///   - key: key in domain
    ///   - domain: domain for key
    /// - Returns: Value or nil if missing

    func value(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> SettingsValue? {
        return values[CombinedKey(domain: domain, key: key)]
    }
}

//
//  GetSet.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-28.
//

import Foundation

extension Settings {
    
    /// Set a value in the SettingsValues dict
    /// - Parameters:
    ///   - key: key in domain
    ///   - value: value to store
    ///   - domain: domain for key

    func setValue(_ key: Settings.CodingKeys, _ value: SettingsValue, in domain: DomainKey = .topLevel) {
        values.setValue(key, value, in: domain)
    }

    /// Fetch a Bool value
    /// - Parameters:
    ///   - key: key in domain
    ///   - domain: domain for key
    /// - Returns: Bool value

    func boolValue(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> Bool {
        return values.boolValue(key, in: domain)
    }

    /// Fetch a Double value
    /// - Parameters:
    ///   - key: key in domain
    ///   - domain: domain for key
    /// - Returns: Double value

    func doubleValue(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> Double {
        return values.doubleValue(key, in: domain)
    }

    /// Fetch an Int value
    /// - Parameters:
    ///   - key: key in domain
    ///   - domain: domain for key
    /// - Returns: Int value

    func intValue(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> Int {
        return values.intValue(key, in: domain)
    }

    /// Fetch a String value
    /// - Parameters:
    ///   - key: key in domain
    ///   - domain: domain for key
    /// - Returns: String value

    func stringValue(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> String {
        return values.stringValue(key, in: domain)
    }

    /// Fetch a String array
    /// - Parameters:
    ///   - key: key in domain
    ///   - domain: domain for key
    /// - Returns: String array

    func stringArray(_ key: Settings.CodingKeys, in domain: DomainKey = .topLevel) -> [String] {
        return values.stringArray(key, in: domain)
    }
}

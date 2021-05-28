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
        if container == nil || defaults.isOnCLI(key) { return defaults.boolValue(key) }
        return (try? container!.decodeIfPresent(Bool.self, forKey: key)) ?? defaults.boolValue(key)
    }

    /// Return decoded Bool as a SettingsValue
    /// - Parameters:
    ///   - container: decoded data container
    ///   - key: key
    ///   - defaults: the command line defaults
    /// - Returns: decoded or default value as a SettingsValue

    static func keyedBoolSettingsValue(
        from container: KeyedDecodingContainer<CodingKeys>?,
        forKey key: CodingKeys,
        defaults: Defaults
    ) -> SettingsValue {
        let val = keyedBoolValue(from: container, forKey: key, defaults: defaults)
        return .boolValue(val: val)
    }

    /// Convenience function to decode a keyed Double
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
        if container == nil { return defaults.doubleValue(key) }
        let val = defaults.isOnCLI(key) ? defaults.doubleValue(key)
            : (try? container!.decodeIfPresent(Double.self, forKey: key)) ?? defaults.doubleValue(key)
        if defaults.bounded, let ok = ok, !ok.contains(val) {
            let okVal = Defaults.initial.doubleValue(key)
            outOfRange(val: "\(val)", range: "\(ok)", substitute: "\(okVal)", key: key)
            return okVal
        }
        return val
    }

    /// Return decoded Double as a SettingsValue
    /// - Parameters:
    ///   - container: decoded data container
    ///   - key: key
    ///   - defaults: the command line defaults
    /// - Returns: decoded or default value as a SettingsValue

    static func keyedDoubleSettingsValue(
        from container: KeyedDecodingContainer<CodingKeys>?,
        forKey key: CodingKeys,
        defaults: Defaults
    ) -> SettingsValue {
        let val = keyedDoubleValue(from: container, forKey: key, defaults: defaults)
        return .doubleValue(val: val)
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
        if container == nil { return defaults.intValue(key) }
        let val = defaults.isOnCLI(key) ? defaults.intValue(key)
            : (try? container!.decodeIfPresent(Int.self, forKey: key)) ?? defaults.intValue(key)
        if defaults.bounded, let ok = ok, !ok.contains(val) {
            let okVal = Defaults.initial.intValue(key)
            outOfRange(val: "\(val)", range: "\(ok)", substitute: "\(okVal)", key: key)
            return okVal
        }
        return val
    }

    /// Return decoded Int as a SettingsValue
    /// - Parameters:
    ///   - container: decoded data container
    ///   - key: key
    ///   - defaults: the command line defaults
    /// - Returns: decoded or default value as a SettingsValue

    static func keyedIntSettingsValue(
        from container: KeyedDecodingContainer<CodingKeys>?,
        forKey key: CodingKeys,
        defaults: Defaults
    ) -> SettingsValue {
        let val = keyedIntValue(from: container, forKey: key, defaults: defaults)
        return .intValue(val: val)
    }

    /// Return the string default for the key
    /// - Parameters:
    ///   - key: Coding key for Settings
    ///   - defaults: the command line defaults
    /// - Returns: string default value

    private static func stringDefault(_ key: CodingKeys, _ defaults: Defaults?) -> String? {
        if let defaults = defaults {
            return defaults.stringValue(key)
        } else {
            return nil
        }
    }

    /// Convenience function to decode a keyed String
    /// - Parameters:
    ///   - container: decoded data container
    ///   - key: Coding key for Settings
    ///   - defaults: the command line defaults
    /// - Returns: decoded or default value or nil

    static func optionalKeyedStringValue(
        from container: KeyedDecodingContainer<CodingKeys>?,
        forKey key: CodingKeys,
        defaults: Defaults? = nil
    ) -> String? {
        if container == nil || (defaults != nil && defaults!.isOnCLI(key)) {
            return stringDefault(key, defaults)
        }
        return (try? container!.decodeIfPresent(String.self, forKey: key)) ?? stringDefault(key, defaults)
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
        return optionalKeyedStringValue(from: container, forKey: key, defaults: defaults) ?? ""
    }

    /// Return decoded String as a SettingsValue
    /// - Parameters:
    ///   - container: decoded data container
    ///   - key: key
    ///   - defaults: the command line defaults
    /// - Returns: decoded or default value as a SettingsValue

    static func keyedStringSettingsValue(
        from container: KeyedDecodingContainer<CodingKeys>?,
        forKey key: CodingKeys,
        defaults: Defaults
    ) -> SettingsValue {
        let val = keyedStringValue(from: container, forKey: key, defaults: defaults)
        return .stringValue(val: val)
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
        if container == nil || defaults.isOnCLI(key) {
            return defaults.stringArray(key)
        }
        var values: [String] = []
        var arrayContainer = try? container?.nestedUnkeyedContainer(forKey: key)
        if arrayContainer == nil { return defaults.stringArray(key) }
        while !arrayContainer!.isAtEnd {
            values.append((try? arrayContainer?.decode(String.self)) ?? "")
        }

        return values
    }

    /// Return decoded StringArray as a SettingsValue
    /// - Parameters:
    ///   - container: decoded data container
    ///   - key: key
    ///   - defaults: the command line defaults
    /// - Returns: decoded or default value as a SettingsValue

    static func keyedStringArraySettingsValue(
        from container: KeyedDecodingContainer<CodingKeys>?,
        forKey key: CodingKeys,
        defaults: Defaults
    ) -> SettingsValue {
        let val = keyedStringArray(from: container, forKey: key, defaults: defaults)
        return .stringArray(val: val)
    }
}

//
//  OptConvertor.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-16.
//

import Foundation
import OptGetter

extension Options {

    /// Set a boolean value and tag it
    /// - Parameters:
    ///   - val: value to set
    ///   - key: key to tag

    @discardableResult
    mutating func getBool(_ val: Bool, key: Settings.CodingKeys?) -> Bool {
        if let key = key {
            values.onCommandLine.insert(key)
            values.values[key] = .boolValue(val: val)
        }
        return val
    }

    /// Set a double value and tag it
    /// - Parameters:
    ///   - val: value to set
    ///   - key: key to tag
    /// - Throws: OptGetterError.illegalValue

    @discardableResult
    mutating func getDouble(_ val: OptValueAt, key: Settings.CodingKeys?) throws -> Double {
        do {
            let dVal = try val.doubleValue()
            if let key = key {
                values.onCommandLine.insert(key)
                values.values[key] = .doubleValue(val: dVal)
            }
            return dVal
        } catch {
            throw error
        }
    }

    /// Get an int value and tag it
    /// - Parameters:
    ///   - val: value to set
    ///   - key: key to tag
    /// - Throws: OptGetterError.illegalValue

    @discardableResult
    mutating func getInt(_ val: OptValueAt, key: Settings.CodingKeys?) throws -> Int {
        do {
            let iVal = try val.intValue()
            if let key = key {
                values.onCommandLine.insert(key)
                values.values[key] = .intValue(val: iVal)
            }
            return iVal
        } catch {
            throw error
        }
    }

    /// Set a string value and tag it
    /// - Parameters:
    ///   - val: value to set
    ///   - key: key to tag

    @discardableResult
    mutating func getString(_ val: OptValueAt, key: Settings.CodingKeys?) -> String {
        let sVal = val.stringValue()
        if let key = key {
            values.onCommandLine.insert(key)
            values.values[key] = .stringValue(val: sVal)
        }
        return sVal
    }

    /// Set a string array and tag it
    /// - Parameters:
    ///   - vals: array to get
    ///   - key: key to tag

    @discardableResult
    mutating func getStringArray(_ vals: OptValuesAt, key: Settings.CodingKeys?) -> [String] {
        let sVals = OptValueAt.stringArray(vals)
        if let key = key {
            values.onCommandLine.insert(key)
            values.values[key] = .stringArray(val: sVals)
        }
        return sVals
    }
}

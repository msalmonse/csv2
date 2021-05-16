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

    mutating func getBool(_ val: Bool, key: Settings.CodingKeys?) -> Bool {
        if let key = key { onCommandLine.insert(key) }
        return val
    }

    /// Set a double value and tag it
    /// - Parameters:
    ///   - val: value to set
    ///   - key: key to tag
    /// - Throws: OptGetterError.illegalValue

    mutating func getDouble(_ val: ValueAt, key: Settings.CodingKeys?) throws -> Double {
        do {
            if let key = key { onCommandLine.insert(key) }
            return try OptGetter.doubleValue(val)
        } catch {
            throw error
        }
    }

    /// Get an double array and tag it
    /// - Parameters:
    ///   - vals: array to get
    ///   - key: key to tag
    /// - Throws: OptGetterError.illegalValue

    mutating func getDoubleArray(_ vals: [ValueAt], key: Settings.CodingKeys?) throws -> [Double] {
        do {
            if let key = key { onCommandLine.insert(key) }
            return try OptGetter.doubleArray(vals)
        }
    }

    /// Get an int value and tag it
    /// - Parameters:
    ///   - val: value to set
    ///   - key: key to tag
    /// - Throws: OptGetterError.illegalValue

    mutating func getInt(_ val: ValueAt, key: Settings.CodingKeys?) throws -> Int {
        do {
            if let key = key { onCommandLine.insert(key) }
            return try OptGetter.intValue(val)
        } catch {
            throw error
        }
    }

    /// Get an int array and tag it
    /// - Parameters:
    ///   - vals: array to get
    ///   - key: key to tag
    /// - Throws: OptGetterError.illegalValue

    mutating func getIntArray(_ vals: [ValueAt], key: Settings.CodingKeys?) throws -> [Int] {
        do {
            if let key = key { onCommandLine.insert(key) }
            return try OptGetter.intArray(vals)
        }
    }

    /// Set a string value and tag it
    /// - Parameters:
    ///   - val: value to set
    ///   - key: key to tag

    mutating func getString(_ val: ValueAt, key: Settings.CodingKeys?) -> String {
        if let key = key { onCommandLine.insert(key) }
        return OptGetter.stringValue(val)
    }

}

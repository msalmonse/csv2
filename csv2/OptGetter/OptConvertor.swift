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

    /// Set a string array and tag it
    /// - Parameters:
    ///   - vals: array to get
    ///   - key: key to tag

    mutating func getStringArray(_ vals: [ValueAt], key: Settings.CodingKeys?) -> [String] {
        if let key = key { onCommandLine.insert(key) }
        return OptGetter.stringArray(vals)
    }

    /// Get a colour value and tag it
    /// - Parameters:
    ///   - val: colour to get
    ///   - key: key to tag
    /// - Throws: OptGetterError.illegalValue

    mutating func getColour(_ val: ValueAt, key: Settings.CodingKeys?) throws -> String {
        let colour = getString(val, key: key)
        if RGBAu8.lookup(colour) != nil { return colour }
        throw OptGetterError.illegalValue(type: "colour", valueAt: val)
    }

    /// Get a colour array and tag it
    /// - Parameters:
    ///   - vals: array to get
    ///   - key: key to tag
    /// - Throws: OptGetterError.illegalValue

    mutating func getColourArray(_ vals: [ValueAt], key: Settings.CodingKeys?) throws -> [String] {
        do {
            if let key = key { onCommandLine.insert(key) }
            return try vals.map { try getColour($0, key: nil) }
        } catch {
            throw error
        }
    }
}

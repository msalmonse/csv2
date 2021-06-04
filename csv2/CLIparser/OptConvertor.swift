//
//  OptConvertor.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-16.
//

import Foundation
import CLIparser

extension Options {

    /// Set a boolean value and tag it
    /// - Parameters:
    ///   - val: value to set
    ///   - key: key to tag

    @discardableResult
    mutating func setBool(_ val: Bool, key: Settings.CodingKeys) -> Bool {
        values.onCLI(key)
        values.setValue(key, .boolValue(val: val))
        return val
    }

    /// Set a double value and tag it
    /// - Parameters:
    ///   - val: value to set
    ///   - key: key to tag
    /// - Throws: CLIparserError.illegalValue

    @discardableResult
    mutating func setDouble(_ val: OptValueAt, key: Settings.CodingKeys) throws -> Double {
        do {
            let dVal = try val.doubleValue()
            values.onCLI(key)
            values.setValue(key, .doubleValue(val: dVal))
            return dVal
        } catch {
            throw error
        }
    }

    /// Get an int value and tag it
    /// - Parameters:
    ///   - val: value to set
    ///   - key: key to tag
    /// - Throws: CLIparserError.illegalValue

    @discardableResult
    mutating func setInt(_ val: OptValueAt, key: Settings.CodingKeys) throws -> Int {
        do {
            let iVal = try val.intValue()
            values.onCLI(key)
            values.setValue(key, .intValue(val: iVal))
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
    mutating func setString(_ val: OptValueAt, key: Settings.CodingKeys) -> String {
        let sVal = val.stringValue()
        values.onCLI(key)
        values.setValue(key, .stringValue(val: sVal))
        return sVal
    }

    /// Set a string array and tag it
    /// - Parameters:
    ///   - vals: array to get
    ///   - key: key to tag

    @discardableResult
    mutating func setStringArray(_ vals: OptValuesAt, key: Settings.CodingKeys) -> [String] {
        let sVals = OptValueAt.stringArray(vals)
        values.onCLI(key)
        values.setValue(key, .stringArray(val: sVals))
        return sVals
    }

    /// Convert a list of strings into a BitMap
    /// - Parameters:
    ///   - vals: list of values
    ///   - key: key to tag
    /// - Throws: CLIparserError.illegalValue
    /// - Returns: BitMap

    @discardableResult
    mutating func setBitmap(_ vals: OptValuesAt, key: Settings.CodingKeys) throws -> BitMap {
        var bitMap = BitMap.none
        if vals.count == 1 && vals[0].stringValue() == "all" {
            bitMap = BitMap.all
        } else {
            var prev = 0
            do {
                for val in vals {
                    let intVal = try val.intValue()
                    if bitMap.okWithOffset.contains(intVal) {
                        bitMap.append(intVal)
                        prev = intVal
                    } else if bitMap.okWithOffset.contains(-intVal) {
                        // negative values are the upper limit of a range
                        for i in (prev + 1)...(-intVal) {
                            bitMap.append(i)
                        }
                        prev = -intVal
                    } else {
                        throw val.error("bitmap")
                    }
                }
            } catch {
                throw error
            }
        }

        values.onCLI(key)
        values.setValue(key, .bitmapValue(val: bitMap))
        return bitMap
    }
}
//
//  formats.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-11.
//

import Foundation

extension Double {

    /// Format a Double in exponential format
    /// - Parameter precision: the number of digits after the point
    /// - Returns: Formatted string

    func e(_ precision: Int) -> String {
        return String(format: "%.*e", precision, self)
    }

    /// Format a Double in fixed point format
    /// - Parameter precision: the number of digits after the point
    /// - Returns: Formatted string

    func f(_ precision: Int) -> String {
        return String(format: "%.*f", precision, self)
    }

    /// Format a Double in "g" format
    /// - Parameter precision: the number of digits after the point
    /// - Returns: Formatted string

    func g(_ precision: Int) -> String {
        return String(format: "%.*g", precision, self)
    }
}

extension Int {
    /// Format an Int
    /// - Parameters:
    ///   - width: string width
    ///   - zeroFill: fill blanks with zeros
    /// - Returns: formatted  string

    func d(_ width: Int = 1, zeroFill: Bool = false) -> String {
        let fmt = zeroFill ? "%0*d" : "%*d"
        return String(format: fmt, width, self)
    }

    /// Format an Int in hex
    /// - Parameters:
    ///   - width: string width
    ///   - zeroFill: fill blanks with zeros
    /// - Returns: formatted  string

    func x(_ width: Int = 1, zeroFill: Bool = false) -> String {
        let fmt = zeroFill ? "%0*x" : "%*x"
        return String(format: fmt, width, self)
    }
}

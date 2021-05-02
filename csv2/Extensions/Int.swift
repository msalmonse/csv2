//
//  Int.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-02.
//

import Foundation

infix operator &== : LogicalDisjunctionPrecedence

extension Int {
    /// Format an Int
    /// - Parameter width: string width
    /// - Returns: formatted  string

    func d(_ width: Int = 1) -> String {
        return String(format: "%*d", width, self)
    }

    /// Format an Int with zero fill
    /// - Parameter width: string width
    /// - Returns: formatted  string

    func d0(_ width: Int = 1) -> String {
        return String(format: "%0*d", width, self)
    }

    /// Format an Int in hex
    /// - Parameters width: string width
    /// - Returns: formatted  string

    func x(_ width: Int = 1) -> String {
        return String(format: "%*x", width, self)
    }

    /// Format an Int in hex with zero fill
    /// - Parameter width: string width
    /// - Returns: formatted  string

    func x0(_ width: Int = 1) -> String {
        return String(format: "%0*x", width, self)
    }

    /// Test for inclusion in a bitset
    /// - Parameters:
    ///   - left: value to test
    ///   - right: mask to test with
    /// - Returns: true if the mask is included

    static func &== (left: Int, right: Int) -> Bool {
        return (left & right) == right
    }
}

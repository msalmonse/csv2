//
//  OptionSet.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-02.
//

import Foundation

extension OptionSet {
    /// Treat each element as an index
    subscript(_ index: Self.Element) -> Bool {
        get { contains(index) }
        set(newValue) { if newValue { insert(index) } else { remove(index) } }
    }

    /// Test for any of a list
    /// - Parameter opts: options to test
    /// - Returns: true is any are set

    func isAny(of opts: [Self.Element]) -> Bool {
        let other = Self(opts)
        return !isDisjoint(with: other)
    }

    /// Test for all of a list
    /// - Parameter opts: options to test
    /// - Returns: true if all are set

    func isAll(of opts: [Self.Element]) -> Bool {
        let other = Self(opts)
        return intersection(other) == other
    }

    /// Test for only elements of a list
    /// - Parameter opts: options to test
    /// - Returns: true if all are set

    func isOnly(_ opts: [Self.Element]) -> Bool {
        let other = Self(opts)
        return union(other) == other
    }

    // Syntactic sugar

    static func ~= (left: Self, right: Self.Element) -> Bool {
        return left.contains(right)
    }

    static func & (left: Self, right: Self) -> Self {
        return left.intersection(right)
    }

    static func & (left: Self, right: [Self.Element]) -> Self {
        return left.intersection(Self(right))
    }

    static func - (left: Self, right: Self) -> Self {
        return left.subtracting(right)
    }
}

//
//  Counter.swift
//  csv2
//
//  Created by Michael Salmon on 2021-06-06.
//

import Foundation

/// A simple counter

struct Counter {
    private(set) var current: Int
    private let step: Int

    /// Initialize the counter
    /// - Parameters:
    ///   - initial: initial value
    ///   - step: step value

    init(_ initial: Int = 0, step: Int = 1) {
        current = initial
        self.step = step
    }

    /// Step the counter
    /// - Parameter mult: step multiplier
    /// - Returns: next value

    @discardableResult
    mutating func next(by mult: Int = 1) -> Int {
        current += step * mult
        return current
    }
}

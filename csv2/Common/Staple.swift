//
//  Staple.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-11.
//

import Foundation

struct Staple {
    static private var current = -1
    static var count: Int { current + 1 }
    static var next: Int {
        current += 1
        return current
    }

    let pixels: Double
}

extension Staple {

    /// Calculate the minimum difference between x values
    /// - Parameter xi: list of x values
    /// - Returns: minimum of x differences

    static func minSpan(_ xi: [XIvalue]) -> Double {
        return xi.indices.dropFirst()
            .map { (xi[$0].x ?? Double.infinity) - (xi[$0 - 1].x ?? Double.infinity) }
            .reduce(Double.infinity) { min($0, $1) }
    }

    /// Check that there are enough poxels for a staple diagram
    /// - Parameter diff: pixels between x values
    /// - Returns: true if there are

    static func spanOK(_ diff: Double) -> Bool {
        return Self.count > 0 && diff/Double(Self.count) > 5.0
    }
}

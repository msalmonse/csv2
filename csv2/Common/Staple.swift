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

    /// Staple width
    let width: Double
    let offsets: [Double]

    init(offset: Double, width: Double) {
        self.width = width
        var offsets = Array(repeating: 0.0, count: Self.count)
        let mid = Self.current/2
        if Self.current &== 1 {
            // even number of staples
            for i in offsets.indices {
                offsets[i] = offset * (Double(i - mid) - 0.5)
            }
        } else {
            for i in offsets.indices {
                offsets[i] = offset * (Double(i - mid))
            }
        }
        self.offsets = offsets
    }

    init(pixels: Double) {
        let count = Double(Self.count)
        let width = pixels/count - 1.0
        let offset = width + 1
        self.init(offset: offset, width: width)
    }
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

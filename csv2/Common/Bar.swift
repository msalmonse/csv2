//
//  Bar.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-11.
//

import Foundation

struct Bar {
    static private var current = -1
    /// Are there any bars?
    static var none: Bool { current < 0 }
    /// How many bars?
    static var count: Int { current + 1 }
    /// The next bar number
    static var next: Int {
        current += 1
        return current
    }

    /// Staple width
    let width: Double
    let offsets: [Double]

    /// Initialize a bar object
    /// - Parameters:
    ///   - offset: the offset between bars
    ///   - width: the width of each bar

    init(offset: Double, width: Double) {
        self.width = width
        var offsets = Array(repeating: 0.0, count: Self.count)
        let mid = Self.current / 2
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

    /// Initialize a bar object
    /// - Parameter pixels: the number of pixels to distribute

    init(pixels: Double) {
        let count = Double(Self.count)
        let pixelsPerBar = pixels / count
        let gap = max(2.0, pixelsPerBar / 16.0)
        let width = floor(pixelsPerBar - gap)
        let offset = width + gap
        self.init(offset: offset, width: width)
    }

    /// Calculate the path to display a bar
    /// - Parameters:
    ///   - origin: The bottom of the bar
    ///   - end: The top or bottom of the bar
    ///   - n: The number of the bar
    /// - Returns: PathComponent to draw the bar

    func path(origin: Point, end: Double, _ n: Int) -> PathComponent {
        return .bar(origin: Point(x: origin.x + offsets[n], y: origin.y), w: width, end: end)
    }
}

extension Bar {

    /// Calculate the minimum difference between x values
    /// - Parameter xi: list of x values
    /// - Returns: minimum of x differences

    static func minSpan(_ xi: [XIvalue], first: Int) -> Double {
        let xValues = xi.indices.filter { $0 >= first && xi[$0].x != nil } .map { xi[$0].x! } .sorted()
        return xValues.indices.dropFirst()
            .map { xValues[$0] - xValues[$0 - 1] }
            .reduce(Double.infinity) { min($0, $1) }
    }

    /// Check that there are enough poxels for a bar diagram
    /// - Parameter diff: pixels between x values
    /// - Returns: true if there are

    static func spanOK(_ diff: Double) -> Bool {
        return !Self.none && diff / Double(Self.count) > 5.0
    }
}

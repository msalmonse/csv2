//
//  Dimensions.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-30.
//

import Foundation

extension Settings {
    /// Dimensions from JSON

    struct Dimensions {
        // svg width and height
        let height: Int
        let width: Int

        // reserved space
        let reserveBottom: Double
        let reserveLeft: Double
        let reserveRight: Double
        let reserveTop: Double

        // base font size
        let baseFontSize: Double

        // minimum and maximum for x and y axes
        // nil means not specified
        let xMax: Double
        let xMin: Double
        let yMax: Double
        let yMin: Double

        // Ticks on the x and y axes
        let xTick: Double
        let yTick: Double
    }

    /// Create new Dimensions struct from JSON
    /// - Parameter container: JSON container
    /// - Returns: new Dimensions object

    static func newDimension(from container: KeyedDecodingContainer<CodingKeys>?) -> Dimensions {
        return Dimensions(
            height: keyedIntValue(from: container, forKey: .height),
            width: keyedIntValue(from: container, forKey: .width),
            reserveBottom: keyedDoubleValue(from: container, forKey: .reserveBottom),
            reserveLeft: keyedDoubleValue(from: container, forKey: .reserveLeft),
            reserveRight: keyedDoubleValue(from: container, forKey: .reserveRight),
            reserveTop: keyedDoubleValue(from: container, forKey: .reserveTop),
            baseFontSize: keyedDoubleValue(from: container, forKey: .baseFontSize),
            xMax: keyedDoubleValue(from: container, forKey: .xMax),
            xMin: keyedDoubleValue(from: container, forKey: .xMin),
            yMax: keyedDoubleValue(from: container, forKey: .yMax),
            yMin: keyedDoubleValue(from: container, forKey: .yMin),
            xTick: keyedDoubleValue(from: container, forKey: .xTick),
            yTick: keyedDoubleValue(from: container, forKey: .yTick)
        )
    }
}

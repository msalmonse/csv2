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

    static func jsonDimensions(
        from container: KeyedDecodingContainer<CodingKeys>?, defaults: Defaults
    ) -> Dimensions {
        return Dimensions(
            height: keyedIntValue(from: container, forKey: .height, defaults: defaults),
            width: keyedIntValue(from: container, forKey: .width, defaults: defaults),
            reserveBottom:
                keyedDoubleValue(from: container, forKey: .reserveBottom, defaults: defaults),
            reserveLeft: keyedDoubleValue(from: container, forKey: .reserveLeft, defaults: defaults),
            reserveRight: keyedDoubleValue(from: container, forKey: .reserveRight, defaults: defaults),
            reserveTop: keyedDoubleValue(from: container, forKey: .reserveTop, defaults: defaults),
            baseFontSize: keyedDoubleValue(from: container, forKey: .baseFontSize, defaults: defaults,
                                           in: Defaults.baseFontSizeBounds),
            xMax: keyedDoubleValue(from: container, forKey: .xMax, defaults: defaults),
            xMin: keyedDoubleValue(from: container, forKey: .xMin, defaults: defaults),
            yMax: keyedDoubleValue(from: container, forKey: .yMax, defaults: defaults),
            yMin: keyedDoubleValue(from: container, forKey: .yMin, defaults: defaults),
            xTick: keyedDoubleValue(from: container, forKey: .xTick, defaults: defaults),
            yTick: keyedDoubleValue(from: container, forKey: .yTick, defaults: defaults)
        )
    }
}

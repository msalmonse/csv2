//
//  SVG/Positions.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-10.
//

import Foundation

// Function to reduce cyclomatic complexity

/// Test if a value is in range
/// - Parameters:
///   - r: range
///   - val: value to test
///   - alt: alternative value
/// - Returns: val if in range. alt otherwise

private func inRange(_ r: Range<Double>, _ val: Double, _ alt: Double = 0.0) -> Double {
    return r.contains(val) ? val : alt
}

extension SVG {

    /// Various layout positions

    struct Positions {
        // Vertical positions
        let bottomY: Double
        let legendY: Double
        let subTitleY: Double
        let titleY: Double
        let topY: Double
        let xTicksY: Double
        let xTitleY: Double

        // Horizontal positions
        let leftX: Double
        let legendX: Double
        let rightX: Double
        let yTickX: Double
        let yTitleX: Double

        /// Initialize a struct with positions on SVG
        /// - Parameters:
        ///   - settings: settings object
        ///   - dataLeft: least abscissa value
        ///   - sizes: font sizes

        init(_ settings: Settings, dataLeft: Double, sizes: FontSizes) {
            // Calculate vertical positions
            // Bottom
            var pos = Double(settings.height) - settings.dim.baseFontSize
            pos -= inRange(0.0..<pos, settings.dim.reserveBottom)
            subTitleY = pos
            pos -= (!settings.subTitle.isEmpty || settings.csv.subTitleHeader >= 0) ? sizes.subTitleSize * 1.25 : 0.0
            titleY = pos
            pos -= (!settings.title.isEmpty) ? sizes.titleSize * 1.25 : 0.0
            xTitleY = pos
            pos -= (!settings.xTitle.isEmpty) ? sizes.axesSize * 1.25 : 0.0
            xTicksY = pos
            pos -= (settings.dim.xTick >= 0) ? sizes.labelSize * 1.25 : 0.0
            bottomY = pos

            // top
            pos = settings.dim.baseFontSize
            pos += inRange(0.0..<bottomY, settings.dim.reserveTop)
            topY = pos
            legendY = topY + sizes.legendSize * 5.0

            // Calculate horizontal positions
            pos = 5.0
            pos += inRange(0.0..<settings.width, settings.dim.reserveLeft)
            pos += (!settings.yTitle.isEmpty) ? sizes.axesSize * 1.25 : 0.0
            yTitleX = pos
            // Give some extra space for minus sign
            pos += (settings.dim.yTick < 0) ? 0.0 : sizes.labelSize * (dataLeft < 0.0 ? 3.5 : 4.0)
            yTickX = pos
            pos += settings.css.strokeWidth
            leftX = pos

            // legends are on the right
            pos = settings.width
            pos -= inRange(0.0..<pos, settings.dim.reserveRight)
            if !settings.legends {
                legendX = pos
            } else {
                let newpos = pos - 5.5 * sizes.legendSize
                if (newpos - leftX) >= 0.8 * settings.width {
                    pos = newpos
                    legendX = pos
                } else {
                    print("Plottable area is too small, legends suppressed.", to: &standardError)
                    legendX = pos + pos
                }
            }
            // Allow for some space for tick labels
            pos -= 2.0 * sizes.labelSize
            rightX = pos
        }
    }
}

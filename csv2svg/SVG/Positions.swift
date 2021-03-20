//
//  SVG/Positions.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-10.
//

import Foundation

extension SVG {

    /// Various layout positions

    struct Positions {
        // Vertical positions
        let bottomY: Double
        let legendY: Double
        let subTitleY: Double
        let titleY: Double
        let xTicksY: Double
        let xTitleY: Double

        // Horizontal positions
        let leftX: Double
        let legendX: Double
        let rightX: Double
        let yTickX: Double
        let yTitleX: Double

        init(_ settings: Settings, dataLeft: Double) {
            legendY = settings.legendSize * 5.0
            // Calculate vertical positions
            var pos = Double(settings.height) - settings.baseFontSize
            subTitleY = pos
            if settings.subTitle != "" || settings.subTitleHeader >= 0 { pos -= settings.subTitleSize * 1.25 }
            titleY = pos
            if settings.title != "" { pos -= settings.titleSize * 1.25 }
            xTitleY = pos
            if settings.xTitle != "" { pos -= settings.axesSize * 1.25 }
            xTicksY = pos
            if settings.xTick >= 0 { pos -= settings.labelSize * 1.25 }
            bottomY = pos

            // Calculate horizontal positions
            pos = 5
            if settings.yTitle != "" { pos += settings.axesSize * 1.25 }
            yTitleX = pos
            // Give some extra space for minus sign
            if settings.yTick >= 0 { pos += settings.labelSize * (dataLeft < 0.0 ? 3.5 : 4.0) }
            yTickX = pos
            pos += Double(settings.strokeWidth)
            leftX = pos

            // legends are on the right
            pos = Double(settings.width)
            if !settings.legends {
                legendX = pos
            } else {
                pos -= 5.5 * settings.legendSize
                if (pos - leftX) >= 0.8 * Double(settings.width) {
                    legendX = pos
                } else {
                    print("Plottable area is too small, legends suppressed.", to: &standardError)
                    pos += 5.5 * settings.legendSize
                    legendX = pos + pos
                }
            }
            pos -= 2.0 * settings.labelSize
            rightX = pos
        }
    }
}

//
//  SvgPositions.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-10.
//

import Foundation

extension SVG {
    struct Positions {
        // Vertical positions
        let bottomY: Double
        let legendY: Double
        let titleY: Double
        let xTicksY: Double
        let xTitleY: Double

        // Horizontal positions
        let leftX: Double
        let yTickX: Double
        let yTitleX: Double

        init(_ settings: Settings, dataLeft: Double) {
            // Calculate vertical positions
            var pos = Double(settings.height - 5)
            titleY = pos
            if settings.title != "" { pos -= settings.titleSize * 1.25 }
            legendY = pos
            pos -= settings.legendSize * 1.25
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
        }
    }
}

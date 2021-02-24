//
//  SvgSides.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-24.
//

import Foundation

extension SVG {
    static func sidesFromColumns(_ csv: CSV, _ settings: Settings)
    -> (top: Double, bottom: Double, left: Double, right: Double) {
        let index = settings.index - 1
        var top: Double
        var bottom: Double
        var left: Double
        var right: Double

        if settings.xMax != nil && settings.xMin != nil {
            left = settings.xMin!
            right = settings.xMax!
        } else {
            var min: Double
            var max: Double
            
            if index < 0 {
                min = 0.0
                max = Double(csv.data.count)
            } else {
                (min, max) = csv.columnMinMax(index)
            }

            left = settings.xMin ?? min
            right = settings.xMax ?? max
        }

        if settings.yMax != nil && settings.yMin != nil {
            bottom = settings.yMin!
            top = settings.yMax!
        } else {
            var min: Double = Double.greatestFiniteMagnitude
            var max: Double = -Double.greatestFiniteMagnitude

            for i in settings.headerColumns..<csv.data.count {
                if i != index {
                    (min, max) = csv.columnMinMax(i, min: min, max: max)
                }
            }

            bottom = settings.yMin ?? min
            top = settings.yMax ?? max
        }

        return (top: top, bottom: bottom, left: left, right: right)
    }
}

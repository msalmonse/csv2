//
//  SvgSides.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-24.
//

import Foundation

extension SVG {
    static func sidesFromColumns(_ csv: CSV, _ settings: Settings) -> Plane {
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
                // if min and max don't include 0 then include 0 if one is close
                if min > 0 && max > 0 {
                    if min < max/20.0 { min = 0.0 }
                } else if min < 0 && max < 0 {
                    if max < min/20.0 { max = 0.0 }
                }
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
            // if min and max don't include 0 then include 0 if one is close
            if min > 0 && max > 0 {
                if min < max/20.0 { min = 0.0 }
            } else if min < 0 && max < 0 {
                if max < min/20.0 { max = 0.0 }
            }

            bottom = settings.yMin ?? min
            top = settings.yMax ?? max
        }

        return Plane(top: top, bottom: bottom, left: left, right: right)
    }
}

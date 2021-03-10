//
//  SVG/Sides.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-24.
//

import Foundation

extension SVG {

    /// Adjust values to give a bit more room for shapes
    /// - Parameters:
    ///   - value: original value
    ///   - by: how much to move it
    /// - Returns: adjusted value

    static private func fudge(_ value: Double, by: Double) -> Double {
        if abs(value/by) < 10.0 { return value }
        if value > 0 { return value + by }
        return value - by
    }

    /// Calculate the left and right sides of the data
    /// - Parameters:
    ///   - csv: csv values
    ///   - settings: settings
    /// - Returns: the left and right sides

    static func lrFromData(_ csv: CSV, _ settings: Settings) -> (l: Double, r: Double) {
        let index = settings.index - 1
        let xMaxSet = settings.xMax > Defaults.maxDefault
        let xMinSet = settings.xMin < Defaults.minDefault
        var left: Double
        var right: Double

        if  xMaxSet && xMinSet {
            left = settings.xMin
            right = settings.xMax
        } else {
            var min: Double
            var max: Double

            if index < 0 {
                min = 0.0
                max = Double(settings.inColumns ? csv.colCt : csv.rowCt)
            } else {
                (min, max) = csv.minMax(settings.inColumns, index, from: settings.headers)
                // if min and max don't include 0 then include 0 if one is close
                if min > 0 && max > 0 {
                    if min < max/20.0 { min = 0.0 }
                } else if min < 0 && max < 0 {
                    if max < min/20.0 { max = 0.0 }
                }
            }

            left = xMinSet ? settings.xMin : fudge(min, by: -0.1)
            right = xMaxSet ? settings.xMax : fudge(max, by: 0.1)
        }

        return (l: left, r: right)
    }

    /// Calculate the top and bottom values of the data
    /// - Parameters:
    ///   - csv: csv values
    ///   - settings: settings
    /// - Returns: the top and bottom sides

    static func tbFromData(_ csv: CSV, _ settings: Settings) -> (t: Double, b: Double) {
        let index = settings.index - 1
        let yMaxSet = settings.yMax > Defaults.maxDefault
        let yMinSet = settings.yMin < Defaults.minDefault
        let count = settings.inColumns ? csv.colCt : csv.rowCt
        var top: Double
        var bottom: Double

        if yMaxSet && yMinSet {
            bottom = settings.yMin
            top = settings.yMax
        } else {
            var min: Double = Double.greatestFiniteMagnitude
            var max: Double = -Double.greatestFiniteMagnitude

            for i in settings.headers..<count where i != index {
                (min, max) =
                    csv.minMax(settings.inColumns, i, from: settings.headers, min: min, max: max)
            }
            // if min and max don't include 0 then include 0 if one is close
            if min > 0 && max > 0 {
                if min < max/20.0 { min = 0.0 }
            } else if min < 0 && max < 0 {
                if max < min/20.0 { max = 0.0 }
            }

            bottom = yMinSet ? settings.yMin : fudge(min, by: -0.1)
            top = yMaxSet ? settings.yMax : fudge(max, by: 0.1)
        }

        return (t: top, b: bottom)
    }

    static func sidesFromData(_ csv: CSV, _ settings: Settings) -> Plane {
        let (left, right) = lrFromData(csv, settings)
        let (top, bottom) = tbFromData(csv, settings)

        return Plane(top: top, bottom: bottom, left: left, right: right)
    }
}

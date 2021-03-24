//
//  SVG/Sides.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-24.
//

import Foundation

extension SVG {

    /// Calculate the left and right sides of the data
    /// - Parameters:
    ///   - csv: csv values
    ///   - settings: settings
    /// - Returns: the left and right sides

    static func lrFromData(_ csv: CSV, _ settings: Settings) -> (l: Double, r: Double) {
        let count = settings.inColumns ? csv.colCt : csv.rowCt
        let index = settings.index
        let xMaxSet = settings.xMax > Defaults.maxDefault
        let xMinSet = settings.xMin < Defaults.minDefault
        var left: Double
        var right: Double

        if  xMaxSet && xMinSet {
            left = settings.xMin
            right = settings.xMax
        } else if count == 0 {
            left = 0.0
            right = 0.0
        } else {
            var min: Double
            var max: Double

            if index < 0 {
                min = 0.0
                max = Double(count)
            } else {
                (min, max) = csv.minMax(settings.inColumns, index, from: settings.headers)
                // if min and max don't include 0 then include 0 if one is close
                if min > 0 && max > 0 {
                    if min < max/20.0 { min = settings.logx ? 1.0 : 0.0 }
                } else if min < 0 && max < 0 {
                    if max < min/20.0 { max = 0.0 }
                }
            }

            left = xMinSet ? settings.xMin : min
            right = xMaxSet ? settings.xMax : max
        }

        return (l: left, r: right)
    }

    /// Calculate the top and bottom values of the data
    /// - Parameters:
    ///   - csv: csv values
    ///   - settings: settings
    /// - Returns: the top and bottom sides

    static func tbFromData(_ csv: CSV, _ settings: Settings) -> (t: Double, b: Double) {
        let index = settings.index
        let yMaxSet = settings.yMax > Defaults.maxDefault
        let yMinSet = settings.yMin < Defaults.minDefault
        let count = settings.inColumns ? csv.colCt : csv.rowCt
        var top: Double
        var bottom: Double

        if yMaxSet && yMinSet {
            bottom = settings.yMin
            top = settings.yMax
        } else if count == 0 {
            top = 0.0
            bottom = 0.0
        } else {
            var min: Double = Double.greatestFiniteMagnitude
            var max: Double = -Double.greatestFiniteMagnitude

            for i in settings.headers..<count where i != index && settings.included(i) {
                (min, max) =
                    csv.minMax(settings.inColumns, i, from: settings.headers, min: min, max: max)
            }
            // if min and max don't include 0 then include 0 if one is close
            if min > 0 && max > 0 {
                if min < max/20.0 { min = settings.logy ? 1.0 : 0.0 }
            } else if min < 0 && max < 0 {
                if max < min/20.0 { max = 0.0 }
            }

            bottom = yMinSet ? settings.yMin : min
            top = yMaxSet ? settings.yMax : max
        }

        return (t: top, b: bottom)
    }

    static func sidesFromData(_ csv: CSV, _ settings: Settings) -> Plane {
        let (left, right) = lrFromData(csv, settings)
        let (top, bottom) = tbFromData(csv, settings)

        return Plane(top: top, bottom: bottom, left: left, right: right)
    }
}

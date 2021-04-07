//
//  SVG/Sides.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-24.
//

import Foundation

struct Sides {

    /// Calculate the left and right sides of the data
    /// - Parameters:
    ///   - csv: csv values
    ///   - settings: settings
    /// - Returns: the left and right sides

    static func lrFromData(_ csv: CSV, _ settings: Settings) -> (l: Double, r: Double) {
        let count = settings.inRows ? csv.colCt : csv.rowCt
        let index = settings.csv.index
        let xMaxSet = settings.dim.xMax > Defaults.maxDefault
        let xMinSet = settings.dim.xMin < Defaults.minDefault
        var left: Double
        var right: Double

        if  xMaxSet && xMinSet {
            left = settings.dim.xMin
            right = settings.dim.xMax
        } else if count == 0 {
            left = 0.0
            right = 0.0
        } else {
            var min: Double
            var max: Double

            if index < 0 {
                min = 0.0
                max = Double(count - 1)
            } else {
                (min, max) = csv.minMax(settings.inColumns, index, from: settings.headers)
                // if min and max don't include 0 then include 0 if one is close
                if min > 0 && max > 0 && !settings.plotter.logx {
                    if min < max/20.0 { min = 0.0 }
                } else if min < 0 && max < 0 && !settings.plotter.logx {
                    if max < min/20.0 { max = 0.0 }
                }
            }

            left = xMinSet ? settings.dim.xMin : min
            right = xMaxSet ? settings.dim.xMax : max
        }

        return (l: left, r: right)
    }

    /// Calculate the top and bottom values of the data
    /// - Parameters:
    ///   - csv: csv values
    ///   - settings: settings
    /// - Returns: the top and bottom sides

    static func tbFromData(_ csv: CSV, _ settings: Settings) -> (t: Double, b: Double) {
        let index = settings.csv.index
        let yMaxSet = settings.dim.yMax > Defaults.maxDefault
        let yMinSet = settings.dim.yMin < Defaults.minDefault
        let count = settings.inColumns ? csv.colCt : csv.rowCt
        var top: Double
        var bottom: Double

        if yMaxSet && yMinSet {
            bottom = settings.dim.yMin
            top = settings.dim.yMax
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
            if min > 0 && max > 0 && !settings.plotter.logy {
                if min < max/20.0 { min = 0.0 }
            } else if min < 0 && max < 0 && !settings.plotter.logy {
                if max < min/20.0 { max = 0.0 }
            }

            bottom = yMinSet ? settings.dim.yMin : min
            top = yMaxSet ? settings.dim.yMax : max
        }

        return (t: top, b: bottom)
    }

    static func fromData(_ csv: CSV, _ settings: Settings) -> Plane {
        let (left, right) = lrFromData(csv, settings)
        let (top, bottom) = tbFromData(csv, settings)

        return Plane(top: top, bottom: bottom, left: left, right: right)
    }
}

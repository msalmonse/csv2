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
        let count = settings.boolValue(.rowGrouping) ? csv.colCt : csv.rowCt
        let index = settings.intValue(.index)
        let xMaxSet = settings.doubleValue(.xMax) > Defaults.maxDefault
        let xMinSet = settings.doubleValue(.xMin) < Defaults.minDefault
        var left: Double
        var right: Double

        if  xMaxSet && xMinSet {
            left = settings.doubleValue(.xMin)
            right = settings.doubleValue(.xMax)
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
                let inColumns = !settings.boolValue(.rowGrouping)
                let headers = settings.intValue(inColumns ? .headerColumns : .headerRows)
                (min, max) = csv.minMax(inColumns, index, from: headers)
                // if min and max don't include 0 then include 0 if one is close
                if min > 0 && max > 0 && !settings.boolValue(.logx) {
                    if min < max/20.0 { min = 0.0 }
                } else if min < 0 && max < 0 && !settings.boolValue(.logx) {
                    if max < min/20.0 { max = 0.0 }
                }
            }

            left = xMinSet ? settings.doubleValue(.xMin) : min
            right = xMaxSet ? settings.doubleValue(.xMax) : max
        }

        return (l: left, r: right)
    }

    /// Calculate the top and bottom values of the data
    /// - Parameters:
    ///   - csv: csv values
    ///   - settings: settings
    /// - Returns: the top and bottom sides

    static func tbFromData(_ csv: CSV, _ settings: Settings) -> (t: Double, b: Double) {
        let index = settings.intValue(.index)
        let yMaxSet = settings.doubleValue(.yMax) > Defaults.maxDefault
        let yMinSet = settings.doubleValue(.yMin) < Defaults.minDefault
        let count = settings.boolValue(.rowGrouping) ? csv.rowCt : csv.colCt
        var top: Double
        var bottom: Double

        if yMaxSet && yMinSet {
            bottom = settings.doubleValue(.yMin)
            top = settings.doubleValue(.yMax)
        } else if count == 0 {
            top = 0.0
            bottom = 0.0
        } else {
            var min: Double = Double.greatestFiniteMagnitude
            var max: Double = -Double.greatestFiniteMagnitude
            let included = settings.intValue(.include)

            let inRows = settings.boolValue(.rowGrouping)
            let headers = settings.intValue(inRows ? .headerRows : .headerColumns)

            for i in headers..<count where i != index && (included &== (1 << i)) {
                (min, max) =
                    csv.minMax(!inRows, i, from: headers, min: min, max: max)
            }
            // if min and max don't include 0 then include 0 if one is close
            if min > 0 && max > 0 && !settings.boolValue(.logy) {
                if min < max/20.0 { min = 0.0 }
            } else if min < 0 && max < 0 && !settings.boolValue(.logy) {
                if max < min/20.0 { max = 0.0 }
            }

            bottom = yMinSet ? settings.doubleValue(.yMin) : min
            top = yMaxSet ? settings.doubleValue(.yMax) : max
        }

        return (t: top, b: bottom)
    }

    static func fromData(_ csv: CSV, _ settings: Settings) -> Plane {
        let (left, right) = lrFromData(csv, settings)
        let (top, bottom) = tbFromData(csv, settings)

        return Plane(top: top, bottom: bottom, left: left, right: right)
    }
}

//
//  Defaults.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-08.
//

import Foundation

// App defaults

struct Defaults {
    // Setable defaults
    static var baseFontSize = 10.0
    static var headers = 0
    static var height = 600
    static var index = 0
    static let maxDefault = -Double.greatestFiniteMagnitude
    static let minDefault = Double.greatestFiniteMagnitude
    static var rowGrouping = false
    static var strokeWidth = 2
    static var title = ""
    static var width = 800
    static var xMax = maxDefault
    static var xMin = minDefault
    static var yMax = maxDefault
    static var yMin = minDefault
}

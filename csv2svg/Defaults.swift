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
    static var black = false
    static var headers = 0
    static var height = 600
    static var index = 0
    static let maxDefault = -Double.infinity
    static let minDefault = Double.infinity
    static var rowGrouping = false
    static var scattered = 0
    static var strokeWidth = 2
    static var title = ""
    static var width = 800
    static var xMax = maxDefault
    static var xMin = minDefault
    static var yMax = maxDefault
    static var yMin = minDefault
}

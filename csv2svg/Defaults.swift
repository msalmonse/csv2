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
    static var backgroundColour = ""
    static var baseFontSize = 10.0
    static var black = false
    static var bold = false
    static var colours: [String] = []
    static var dashedLines = 0
    static var dashes: [String] = []
    static var dataPointDistance = 5.0 * strokeWidth
    static var fontFamily: String = ""
    static var headers = 0
    static var height = 600
    static var include = -1
    static var index = 0
    static var italic = false
    static var legends = true
    static var logx = false
    static var logy = false
    static let maxDefault = -Double.infinity
    static let minDefault = Double.infinity
    static var nameHeader = 1
    static var names: [String] = []
    static var opacity = 1.0
    static var rowGrouping = false
    static var scattered = 0
    static var shapes: [String] = []
    static var showDataPoints = 0
    static var sortx = false
    static var smooth = 0.0
    static var strokeWidth = 2.0
    static var subTitle = ""
    static var subTitleHeader = 0
    static var title = ""
    static var width = 800
    static var xMax = maxDefault
    static var xMin = minDefault
    static var xTick = 0.0
    static var yMax = maxDefault
    static var yMin = minDefault
    static var yTick = 0.0
}

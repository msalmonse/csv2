//
//  SettingsDefaults.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-08.
//

import Foundation

extension Settings {
    struct Defaults {
        // Setable defaults
        static var fontSize = 10.0
        static var headers = 0
        static var height = 500
        static var index = 0
        static let maxDefault = -Double.greatestFiniteMagnitude
        static let minDefault = Double.greatestFiniteMagnitude
        static var rowGrouping = false
        static var strokeWidth = 2
        static var title = ""
        static var width = 500
        static var xMax = maxDefault
        static var xMin = minDefault
        static var yMax = maxDefault
        static var yMin = minDefault
    }
}

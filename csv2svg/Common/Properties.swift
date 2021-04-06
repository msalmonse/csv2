//
//  Properties.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-16.
//

import Foundation

struct Properties {
    var bezier: Double = 0.0
    var colour: String?
    var cssClass: String?
    var dash: String?
    var name: String?
    var dashed = false
    var included = true
    var pointed = false
    var scattered = false
    var shape: Shape?
    var strokeWidth = 2.0
}

struct PropertiesList {
    var plots: [Properties]
    var axes = Properties()
    var legend = Properties()
    var subTitle = Properties()
    var ticks = Properties()
    var title = Properties()
}

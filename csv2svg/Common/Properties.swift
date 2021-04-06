//
//  Properties.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-16.
//

import Foundation

enum StringProperties { case colour, dash, fill, fontFamily }
enum DoubleProperties { case bezier, fontSize, strokewidth }

struct Properties {
    var bezier: Double = 0.0
    var colour: String?
    var cssClass: String?
    var dash: String?
    var fill: String?
    var fontFamily: String?
    var fontSize = 0.0
    var name: String?
    var dashed = false
    var included = true
    var pointed = false
    var scattered = false
    var shape: Shape?
    var strokeWidth = 0.0

    static var defaultProperties = Properties()

    func cascade(_ key: StringProperties) -> String? {
        switch key {
        case .colour: return colour ?? Self.defaultProperties.colour
        case .dash: return dash ?? Self.defaultProperties.dash
        case .fill: return fill ?? Self.defaultProperties.fill ?? cascade(.colour)
        case .fontFamily: return fontFamily ?? Self.defaultProperties.fontFamily
        }
    }

    func cascade(_ key: DoubleProperties) -> Double {
        switch key {
        case .bezier: return bezier > 0.0 ? bezier : Self.defaultProperties.bezier
        case .fontSize: return fontSize > 0.0 ? fontSize : Self.defaultProperties.fontSize
        case .strokewidth: return strokeWidth > 0.0 ? strokeWidth : Self.defaultProperties.strokeWidth
        }
    }
}

struct PropertiesList {
    var plots: [Properties]
    var axes = Properties()
    var grid = Properties()
    var label = Properties()
    var legend = Properties()
    var subTitle = Properties()
    var ticks = Properties()
    var title = Properties()

    init(count ct: Int, sizes: FontSizes, settings: Settings) {
        plots = Array(repeating: Properties(), count: ct)

        Properties.defaultProperties.bezier = settings.plot.bezier
        Properties.defaultProperties.colour = "black"
        Properties.defaultProperties.fontFamily = settings.css.fontFamily
        Properties.defaultProperties.strokeWidth = settings.css.strokeWidth

        grid.colour = "silver"
        grid.strokeWidth = settings.css.strokeWidth/2.0

        label.fontSize = sizes.labelSize
        legend.fontSize = sizes.legendSize
        subTitle.fontSize = sizes.subTitleSize
        ticks.fontSize = sizes.axesSize
        title.fontSize = sizes.titleSize
    }
}

//
//  Properties.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-16.
//

import Foundation

enum StringProperties {
    case colour, dash, fill, fontFamily, fontStyle, fontWeight, strokeLineCap, textAlign
    var path: KeyPath<Properties,String?> {
        switch self {
        case .colour: return \.colour
        case .dash: return \.dash
        case .fill: return \.fill
        case .fontFamily: return \.fontFamily
        case .fontStyle: return \.fontStyle
        case .fontWeight: return \.fontWeight
        case .strokeLineCap: return \.strokeLineCap
        case .textAlign: return \.textAlign
        }
    }
}
enum DoubleProperties {
    case bezier, fontSize, strokeWidth
    var path: KeyPath<Properties,Double> {
        switch self {
        case .bezier: return \.bezier
        case .fontSize: return \.fontSize
        case .strokeWidth: return \.strokeWidth
        }
    }
}

struct Properties {
    var bezier: Double = 0.0
    var colour: String?
    var cssClass: String?
    var dash: String?
    var fill: String?
    var fontFamily: String?
    var fontSize = 0.0
    var fontStyle: String?
    var fontWeight: String?
    var name: String?
    var dashed = false
    var included = true
    var pointed = false
    var scattered = false
    var shape: Shape?
    var strokeLineCap: String?
    var strokeWidth = 0.0
    var textAlign: String?

    static fileprivate(set) var defaultProperties = Properties()

    func cascade(_ key: StringProperties) -> String? {
        switch key {
        case .fill: return fill ?? Self.defaultProperties.fill ?? cascade(.colour)
        default:
            return self[keyPath: key.path] ?? Self.defaultProperties[keyPath: key.path]
        }
    }

    func cascade(_ key: DoubleProperties) -> Double {
        let val = self[keyPath: key.path]
        return val > 0.0 ? val : Self.defaultProperties[keyPath: key.path]
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

    init(count ct: Int, settings: Settings) {
        let sizes = FontSizes(size: settings.dim.baseFontSize)
        plots = Array(repeating: Properties(), count: ct)

        Properties.defaultProperties.bezier = settings.plot.bezier
        Properties.defaultProperties.colour = "black"
        Properties.defaultProperties.fontFamily = settings.css.fontFamily
        Properties.defaultProperties.strokeLineCap = "round"
        Properties.defaultProperties.strokeWidth = settings.css.strokeWidth
        Properties.defaultProperties.textAlign = "middle"

        grid.colour = "silver"
        grid.strokeWidth = settings.css.strokeWidth/2.0

        label.fontSize = sizes.labelSize
        legend.fontSize = sizes.legendSize
        subTitle.fontSize = sizes.subTitleSize
        ticks.fontSize = sizes.axesSize
        title.fontSize = sizes.titleSize
    }
}

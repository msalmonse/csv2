//
//  Properties.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-16.
//

import Foundation

enum StringProperties {
    case colour, cssClass, dash, fill, fontColour, fontFamily, strokeLineCap, textAlign
    var path: KeyPath<Properties,String?> {
        switch self {
        case .colour: return \.colour
        case .cssClass: return \.cssClass
        case .dash: return \.dash
        case .fill: return \.fill
        case .fontColour: return \.fontColour
        case .fontFamily: return \.fontFamily
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
    var bold = false
    var colour: String?
    var cssClass: String?
    var dash: String?
    var fill: String?
    var fontFamily: String?
    var fontSize = 0.0
    var fontColour: String?
    var name: String?
    var dashed = false
    var included = true
    var italic = false
    var pointed = false
    var scattered = false
    var shape: Shape?
    var shapeWidth: Double { return strokeWidth * 1.75 }
    var strokeLineCap: String?
    var strokeWidth = 0.0
    // textAlign is a string with "horizontal align, rotation, vertical align"
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
        return (val > 0.0) ? val : Self.defaultProperties[keyPath:key.path]
    }
}

struct PropertiesList {
    var plots: [Properties]
    var axes = Properties()
    var legend = Properties()
    var legendHeadline = Properties()
    var subTitle = Properties()
    var title = Properties()
    var xLabel = Properties()
    var xTitle = Properties()
    var yLabel = Properties()
    var yTitle = Properties()

    init(count ct: Int, settings: Settings) {
        let sizes = FontSizes(size: settings.dim.baseFontSize)
        plots = Array(repeating: Properties(), count: ct)

        Properties.defaultProperties.bezier = settings.plot.bezier
        Properties.defaultProperties.colour = "black"
        Properties.defaultProperties.fill = "none"
        Properties.defaultProperties.fontColour = "black"
        Properties.defaultProperties.fontFamily = settings.css.fontFamily
        Properties.defaultProperties.strokeLineCap = "round"
        Properties.defaultProperties.strokeWidth = settings.css.strokeWidth
        Properties.defaultProperties.textAlign = "middle,0,baseline"

        axes.cssClass = "axes"
        legend.fontSize = sizes.legendSize
        legend.cssClass = "legend"
        legendHeadline.fontSize = sizes.legendSize * 1.25
        legendHeadline.bold = true
        legendHeadline.cssClass = "legend headline"
        subTitle.fontSize = sizes.subTitleSize
        subTitle.cssClass = "subtitle"
        title.fontSize = sizes.titleSize
        title.cssClass = "title"
        xLabel.fontSize = sizes.labelSize
        xLabel.cssClass = "xlabel"
        xLabel.colour = "silver"
        xTitle.fontSize = sizes.axesSize
        xTitle.cssClass = "xtitle"
        yLabel.fontSize = sizes.labelSize
        yLabel.colour = "silver"
        yLabel.cssClass = "ylabel"
        yLabel.textAlign = "end,0,baseline"
        yTitle.fontSize = sizes.axesSize
        yTitle.cssClass = "ytitle"
        yTitle.textAlign = "middle,90,baseline"
    }
}

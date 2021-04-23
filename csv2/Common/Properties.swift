//
//  Properties.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-16.
//

import Foundation

enum StringProperties {
    case colour, cssClass, dash, fill, fontColour, fontFamily, strokeLineCap, textAlign, textBaseline
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
        case .textBaseline: return \.textBaseline
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
    var bar = -1
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
    var included = false
    var italic = false
    var pointed = false
    var scattered = false
    var shape: Shape?
    var shapeWidth: Double { return strokeWidth * 1.75 }
    var strokeLineCap: String?
    var strokeWidth = 0.0
    var textAlign: String?
    var textBaseline: String?
    var transform: Transform?

    static var defaultProperties = Properties()

    static func from(settings: Settings) -> Properties {
        var props = Properties()
        props.bezier = settings.plot.bezier
        props.bold = settings.css.bold
        props.fontFamily = settings.css.fontFamily
        props.italic = settings.css.italic

        return props
    }

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

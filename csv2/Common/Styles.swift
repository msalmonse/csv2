//
//  Properties.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-16.
//

import Foundation

struct Styles {
    var bar = -1
    var bezier: Double = 0.0
    var colour: String?
    var cssClass: String?
    var dash: String?
    var fill: String?
    var fontFamily: String?
    var fontSize = 0.0
    var fontColour: String?
    var name: String?
    var options = PlotOptions()
    var shape: Shape?
    var shapeWidth: Double { strokeWidth * 1.75 }
    var strokeLineCap: String?
    var strokeWidth = 0.0
    var textAlign: String?
    var textBaseline: String?
    var transform: Transform?

    static func from(settings: Settings) -> Styles {
        var styles = Styles()
        styles.bezier = settings.plot.bezier
        styles.dash = ""
        styles.options[.bold] = settings.css.bold
        styles.fontFamily = settings.css.fontFamily
        styles.options[.italic] = settings.css.italic
        styles.strokeLineCap = "round"
        styles.strokeWidth = settings.css.strokeWidth
        styles.textAlign = "middle"
        styles.textBaseline = "alphabetic"

        return styles
    }
}

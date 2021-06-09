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
    var shapeWidth = 0.0
    var strokeLineCap: String?
    var strokeWidth = 0.0
    var textAlign: String?
    var textBaseline: String?
    var transform: Transform?

    /// Shortcut function to set many common values
    /// - Parameter settings: chart settings
    /// - Returns: new, patially filled Styles

    static func from(settings: Settings) -> Styles {
        var styles = Styles()
        styles.bezier = settings.doubleValue(.bezier)
        styles.dash = ""
        styles.options[.bold] = settings.boolValue(.bold)
        styles.fontFamily = settings.stringValue(.fontFamily)
        styles.options[.italic] = settings.boolValue(.italic)
        styles.shapeWidth = settings.shapeWidth
        styles.strokeLineCap = "round"
        styles.strokeWidth = settings.strokeWidth
        styles.textAlign = "middle"
        styles.textBaseline = "alphabetic"

        return styles
    }

    /// Modify the instance
    /// - Parameters:
    ///   - key: the property to modify
    ///   - value: the new value
    /// - Returns: modified copy of the instance

    func with<T>(_ key: WritableKeyPath<Self,T>, of value: T) -> Self {
        var copy = self
        copy[keyPath: key] = value
        return copy
    }
}

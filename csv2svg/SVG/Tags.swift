//
//  Tags.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-04-07.
//

import Foundation

extension SVG {

    /// Generate a <rect>
    /// - Parameters:
    ///   - x: x position
    ///   - y: y position
    ///   - w: width
    ///   - h: height
    ///   - extra: extra options for <rect.>
    ///   - rx: radius
    ///   - precision: precission for x, y, w and h
    /// - Returns: a <rect> string

    func rectTag(
        x: Double, y: Double,
        width w: Double, height h: Double,
        extra: String = "",
        rx: Double = 0.0,
        precision p: Int = 1
    ) -> String {
        return """
            <rect \(xy(x,y, p)) \(wh(w,h, p)) rx="\(rx.f(p))" \(extra) />
            """
    }

    /// Generate a <text> string
    /// - Parameters:
    ///   - x: x position
    ///   - y: y position
    ///   - text: text to display
    ///   - cssClass: text tag class
    ///   - extra: any extra options for <text>
    /// - Returns: <text> string

    func textTag(
        x: Double, y: Double,
        text: String,
        cssClass: String,
        extra: String = ""
    ) -> String {
        return "<text \(xy(x,y)) class=\"\(cssClass)\" \(extra)>\(text)</text>"
    }

    /// Generate width and height string
    /// - Parameters:
    ///   - w: width value
    ///   - h: height value
    ///   - precission: precission in string
    /// - Returns: width and height string

    func wh(_ w: Double, _ h: Double, _ precision: Int = 2) -> String {
        return """
            width="\(w.f(precision))" height="\(h.f(precision))"
            """
    }

    /// Generate x and y string
    /// - Parameters:
    ///   - x: x value
    ///   - y: y value
    ///   - precission: precission in string
    /// - Returns: x and y string

    func xy(_ x: Double, _ y: Double, _ precision: Int = 2) -> String {
        return """
            x="\(x.f(precision))" y="\(y.f(precision))"
            """
    }
}

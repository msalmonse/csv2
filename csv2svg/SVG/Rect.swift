//
//  Rect.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-22.
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
}

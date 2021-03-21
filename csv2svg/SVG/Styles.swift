//
//  Styles.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-21.
//

import Foundation

extension SVG {
    /// Create a dict ot <text> styles
    /// - Parameter settings: Settings object
    /// - Returns: styles dictionary

    static func styleDict(_ settings: Settings) -> [String: Style] {
        let result: [String: Style] = [
            "legends": Style([
                "font-size": "\(settings.legendSize.f(1))px",
                "font-weight": "bold"
            ]),
            "subTitle": Style([
                "text-anchor": "middle",
                "font-size": "\(settings.subTitleSize.f(1))px"
            ]),
            "title": Style([
                "text-anchor": "middle",
                "font-size": "\(settings.titleSize.f(1))px"
            ]),
            "xLabel": Style([
                "text-anchor": "middle",
                "font-size": "\(settings.labelSize.f(1))px"
            ]),
            "xTitle": Style([
                "text-anchor": "middle",
                "font-size": "\(settings.axesSize.f(1))px"
            ]),
            "yLabel": Style([
                "dominant-baseline": "middle",
                "text-anchor": "end",
                "font-size": "\(settings.labelSize.f(1))px"
            ]),
            "yTitle": Style([
                "text-anchor": "middle",
                "writing-mode": "tb",
                "font-size": "\(settings.axesSize.f(1))px"
            ]),
        ]

        return result
    }
}

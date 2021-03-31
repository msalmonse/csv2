//
//  SVGsettings.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-30.
//

import Foundation

extension Settings {

    /// SVG related settings

    struct SVG {
        // Include plot info in svg
        let legends: Bool

        // Lag axes?
        let logx: Bool
        let logy: Bool

        let logoHeight: Double
        let logoURL: String
        let logoWidth: Double

        let svgInclude: String

        // svg sub-title title, x axis title and y axis title
        let subTitle: String
        let title: String
        let xTitle: String
        let yTitle: String
    }

    /// Create SVG object from JSON
    /// - Parameter container: JSON container
    /// - Returns: SVG object

    static func jsonSVG(from container: KeyedDecodingContainer<CodingKeys>?) -> SVG {
        return SVG(
            legends: keyedBoolValue(from: container, forKey: .legends),
            logx: keyedBoolValue(from: container, forKey: .logx),
            logy: keyedBoolValue(from: container, forKey: .logy),
            logoHeight: keyedDoubleValue(from: container, forKey: .logoHeight),
            logoURL: keyedStringValue(from: container, forKey: .logoURL),
            logoWidth: keyedDoubleValue(from: container, forKey: .logoHeight),
            svgInclude: keyedStringValue(from: container, forKey: .svgInclude),
            subTitle: keyedStringValue(from: container, forKey: .subTitle),
            title: keyedStringValue(from: container, forKey: .title),
            xTitle: keyedStringValue(from: container, forKey: .xTitle),
            yTitle: keyedStringValue(from: container, forKey: .yTitle)
        )
    }
}

//
//  Foreground.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-22.
//

import Foundation

extension Settings {

    // foreground colours

    struct ForegroundColours {
        let axes: String
        let draft: String
        let legends: String
        let legendsBox: String
        let pieLabel: String
        let pieLegend: String
        let subTitle: String
        let title: String
        let xLabel: String
        let xTags: String
        let xTitle: String
        let yLabel: String
        let yTitle: String
    }

    /// Create new Dimensions struct from JSON
    /// - Parameters
    ///   - container: JSON container
    ///   - defaults: defaults for properties
    /// - Returns: new Dimensions object

    static func jsonForegroundColours(
        from container: KeyedDecodingContainer<CodingKeys>?, defaults: Defaults
    ) -> ForegroundColours {
        let fg = defaults.stringValue(.foregroundColour)
        let text = defaults.stringValue(.textcolour)
        let pieText = optionalKeyedStringValue(from: container, forKey: .pieLegend) ?? text

        return ForegroundColours(
            axes: optionalKeyedStringValue(from: container, forKey: .axes) ?? fg,
            draft: optionalKeyedStringValue(from: container, forKey: .draft) ?? fg,
            legends: optionalKeyedStringValue(from: container, forKey: .legends) ?? text,
            legendsBox: optionalKeyedStringValue(from: container, forKey: .legendsBox) ?? fg,
            pieLabel: optionalKeyedStringValue(from: container, forKey: .pieLabel) ??
                RGBAu8(pieText, or: .black).clamped(opacity: 0.75).cssRGBA,
            pieLegend: pieText,
            subTitle: optionalKeyedStringValue(from: container, forKey: .subTitle) ?? text,
            title: optionalKeyedStringValue(from: container, forKey: .title) ?? text,
            xLabel: optionalKeyedStringValue(from: container, forKey: .xLabel) ?? text,
            xTags: optionalKeyedStringValue(from: container, forKey: .xTags) ?? text,
            xTitle: optionalKeyedStringValue(from: container, forKey: .xTitle) ?? text,
            yLabel: optionalKeyedStringValue(from: container, forKey: .yLabel) ?? text,
            yTitle: optionalKeyedStringValue(from: container, forKey: .yTitle) ?? text
        )
    }

}

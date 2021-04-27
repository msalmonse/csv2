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
        let legends: String
        let legendsBox: String
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
        let fg = defaults.foregroundColour
        let text = defaults.textColour

        return ForegroundColours(
            axes: optionalKeyedStringValue(from: container, forKey: .axes, defaults: nil) ?? fg,
            legends: optionalKeyedStringValue(from: container, forKey: .legends, defaults: nil) ?? text,
            legendsBox: optionalKeyedStringValue(from: container, forKey: .legendsBox, defaults: nil) ?? fg,
            pieLegend: optionalKeyedStringValue(from: container, forKey: .pieLegend, defaults: nil) ?? text,
            subTitle: optionalKeyedStringValue(from: container, forKey: .subTitle, defaults: nil) ?? text,
            title: optionalKeyedStringValue(from: container, forKey: .title, defaults: nil) ?? text,
            xLabel: optionalKeyedStringValue(from: container, forKey: .xLabel, defaults: nil) ?? text,
            xTags: optionalKeyedStringValue(from: container, forKey: .xTags, defaults: nil) ?? text,
            xTitle: optionalKeyedStringValue(from: container, forKey: .xTitle, defaults: nil) ?? text,
            yLabel: optionalKeyedStringValue(from: container, forKey: .yLabel, defaults: nil) ?? text,
            yTitle: optionalKeyedStringValue(from: container, forKey: .yTitle, defaults: nil) ?? text
        )
    }

}

//
//  CSSsettings.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-30.
//

import Foundation

extension Settings {

    /// CSS related settings

    struct CSS {
        // Background colour
        let backgroundColour: String

        // Include :hover css for paths
        let hover: Bool

        // opacity for plots
        let opacity: Double

        // font related stuff
        let bold: Bool
        let fontFamily: String
        let italic: Bool

        // Path stroke width
        let strokeWidth: Double

        // include stuff
        let extras: [String]
        let id: String
        let include: String
    }

    /// Create a new css struct from JSON
    /// - Parameter container: JSON container
    /// - Returns: css object

    static func jsonCSS(from container: KeyedDecodingContainer<CodingKeys>?, defaults: Defaults) -> CSS {
        return CSS(
            backgroundColour:
                keyedStringValue(from: container, forKey: .backgroundColour, defaults: defaults),
            hover: keyedBoolValue(from: container, forKey: .hover, defaults: defaults),
            opacity: keyedDoubleValue(from: container, forKey: .opacity, defaults: defaults, in: 0.0...1.0),
            bold: keyedBoolValue(from: container, forKey: .bold, defaults: defaults),
            fontFamily: keyedStringValue(from: container, forKey: .fontFamily, defaults: defaults),
            italic: keyedBoolValue(from: container, forKey: .italic, defaults: defaults),
            strokeWidth:
                keyedDoubleValue(from: container, forKey: .strokeWidth, defaults: defaults, in: 0.0...100.0),
            extras: keyedStringArray(from: container, forKey: .cssExtras, defaults: defaults),
            id: keyedStringValue(from: container, forKey: .cssID, defaults: defaults),
            include: keyedStringValue(from: container, forKey: .cssInclude, defaults: defaults)
        )
    }
}

//
//  CSSsettings.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-30.
//

import Foundation

extension Settings {
    struct CSS {
        // Background colour
        let backgroundColour: String

        // opacity for plots
        let opacity: Double

        // font related stuff
        let bold: Bool
        let fontFamily: String
        let italic: Bool

        // include stuff
        let extras: [String]
        let id: String
        let include: String
    }

    /// Create a new css struct from JSON
    /// - Parameter container: JSON container
    /// - Returns: css object

    static func newCSS(from container: KeyedDecodingContainer<CodingKeys>?) -> CSS {
        return CSS(
            backgroundColour: keyedStringValue(from: container, forKey: .backgroundColour),
            opacity: keyedDoubleValue(from: container, forKey: .opacity),
            bold: keyedBoolValue(from: container, forKey: .bold),
            fontFamily: keyedStringValue(from: container, forKey: .fontFamily),
            italic: keyedBoolValue(from: container, forKey: .italic),
            extras: keyedStringArray(from: container, forKey: .cssExtras),
            id: keyedStringValue(from: container, forKey: .cssID),
            include: keyedStringValue(from: container, forKey: .cssInclude)
        )
    }
}

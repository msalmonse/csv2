//
//  Usage.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-25.
//

import Foundation
import OptGetter

/// Place holder for usage values

struct UsageLeftRight {
    static var leftMargin = 2
    static var leftUsage = 25
    static var indent = 4
    static var rightMargin = 65

    static let leftMin = 0
    static let rightMax = 100

    static func usage(textOnly: Bool = false) -> Usage {
        return Usage(tagLeft: indent, textLeft: textOnly ? leftMargin : leftUsage, textRight: rightMargin)
    }

    /// Set the indent
    /// - Parameter indent: new indent

    static func setIndent(_ indent: Int) {
        guard (leftMargin...leftUsage) ~= indent else { return }
        Self.indent = indent
    }

    /// Move the left margin
    /// - Parameter left: new left margin

    static func setLeft(_ left: Int) {
        guard (leftMin...leftUsage) ~= indent else { return }
        leftMargin = max(0, left)
    }

    /// Set the right margin
    /// - Parameter right: new right margin

    static func setRight(_ right: Int) {
        guard (leftMargin...rightMax) ~= indent else { return }
        rightMargin = right
    }

    /// Set the usage left margin
    /// - Parameter left: new usage left margin

    static func setUsage(_ left: Int) {
        guard (indent...rightMargin) ~= indent else { return }
        leftUsage = left
    }
}

/// Options usage
/// - Parameter opts: options for usage
/// - Returns: usage string

func optUsage(_ opts: OptsToGet) -> String {
    return UsageLeftRight.usage().optUsage(opts, longOnly: true)
}

/// Positional argument usage
/// - Parameter opts: positional arguments for usage
/// - Returns: usage string

func positionalUsage(_ opts: OptsToGet) -> String {
    return UsageLeftRight.usage().positionalUsage(opts)
}

/// Commands usage
/// - Parameter cmds: commands for usage
/// - Returns: usage string

func cmdUsage(_ cmds: CmdsToGet) -> String {
    return UsageLeftRight.usage().cmdUsage(cmds)
}

/// Wrap text
/// - Parameter texts: text to wrap
/// - Returns: wrapped text

func paragraphWrap(_ texts: [String]) -> String {
    return UsageLeftRight.usage(textOnly: true).paragraphWrap(texts)
}

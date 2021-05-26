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
    static var indent = 4
    static var usageLeft = 25
    static var rightMargin = 65

    /// Set the indent
    /// - Parameter indent: new indent

    static func setIndent(_ indent: Int) {
        Self.indent = indent
    }

    /// Move the left margins keeping the offset the same
    /// - Parameter left: new left margin

    static func setLeft(_ left: Int) {
        let change = leftMargin - left
        leftMargin = left
        indent -= change
        usageLeft -= change
    }

    /// Set the right margin
    /// - Parameter right: new right margin

    static func setRight(_ right: Int) {
        rightMargin = right
    }

    /// Set the usage left margin
    /// - Parameter left: new usage left margin

    static func setUsage(_ left: Int) {
        usageLeft = left
    }
}

/// Options usage
/// - Parameter opts: options for usage
/// - Returns: usage string

func optUsage(_ opts: OptsToGet) -> String {
    return OptGetter.usage(
        opts, longOnly: true,
        indent: UsageLeftRight.indent,
        left: UsageLeftRight.usageLeft,
        right: UsageLeftRight.rightMargin
    )
}

/// Positional argument usage
/// - Parameter opts: positional arguments for usage
/// - Returns: usage string

func positionalUsage(_ opts: OptsToGet) -> String {
    return OptGetter.positionalUsage(
        opts,
        indent: UsageLeftRight.indent,
        left: UsageLeftRight.usageLeft,
        right: UsageLeftRight.rightMargin
    )
}

/// Commands usage
/// - Parameter cmds: commands for usage
/// - Returns: usage string

func cmdUsage(_ cmds: CmdsToGet) -> String {
    return OptGetter.cmdUsage(
        cmds,
        indent: UsageLeftRight.indent,
        left: UsageLeftRight.usageLeft,
        right: UsageLeftRight.rightMargin
    )
}

/// Wrap text
/// - Parameter texts: text to wrap
/// - Returns: wrapped text

func paragraphWrap(_ texts: [String]) -> String {
    return OptGetter.paragraphWrap(
        texts,
        left: UsageLeftRight.leftMargin,
        right: UsageLeftRight.rightMargin
    )
}

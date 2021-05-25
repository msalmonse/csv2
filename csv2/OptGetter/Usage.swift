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
    static var optIndent = 4
    static var optLeft = 25
    static var rightMargin = 65
}

/// Options usage
/// - Parameter opts: options for usage
/// - Returns: usage string

func optUsage(_ opts: OptsToGet) -> String {
    return OptGetter.usage(
        opts, longOnly: true,
        indent: UsageLeftRight.optIndent,
        left: UsageLeftRight.optLeft,
        right: UsageLeftRight.rightMargin
    )
}

/// Positional argument usage
/// - Parameter opts: positional arguments for usage
/// - Returns: usage string

func positionalUsage(_ opts: OptsToGet) -> String {
    return OptGetter.positionalUsage(
        opts,
        indent: UsageLeftRight.optIndent,
        left: UsageLeftRight.optLeft,
        right: UsageLeftRight.rightMargin
    )
}

/// Commands usage
/// - Parameter cmds: commands for usage
/// - Returns: usage string

func cmdUsage(_ cmds: CmdsToGet) -> String {
    return OptGetter.cmdUsage(
        cmds,
        indent: UsageLeftRight.optIndent,
        left: UsageLeftRight.optLeft,
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

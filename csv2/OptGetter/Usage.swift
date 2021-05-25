//
//  Usage.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-25.
//

import Foundation
import OptGetter

struct UsageLeftRight {
    static var leftMargin = 2
    static var optIndent = 4
    static var optLeft = 25
    static var rightMargin = 55
}

func optUsage(_ opts: OptsToGet) -> String {
    return OptGetter.usage(
        opts, longOnly: true,
        indent: UsageLeftRight.optIndent,
        left: UsageLeftRight.optLeft,
        right: UsageLeftRight.rightMargin
    )
}

func positionalUsage(_ opts: OptsToGet) -> String {
    return OptGetter.positionalUsage(
        opts,
        indent: UsageLeftRight.optIndent,
        left: UsageLeftRight.optLeft,
        right: UsageLeftRight.rightMargin
    )
}

func cmdUsage(_ cmds: CmdsToGet) -> String {
    return OptGetter.cmdUsage(
        cmds,
        indent: UsageLeftRight.optIndent,
        left: UsageLeftRight.optLeft,
        right: UsageLeftRight.rightMargin
    )
}

func paragraphWrap(_ text: [String]) -> String {
    return OptGetter.paragraphWrap(
        text,
        left: UsageLeftRight.leftMargin,
        right: UsageLeftRight.rightMargin
    )
}

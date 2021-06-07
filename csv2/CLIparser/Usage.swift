//
//  Usage.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-25.
//

import Foundation
import CLIparser

/// Type of usage

enum UsageStyle { case normal, textOnly, textWithIndent }

/// Place holder for usage values

struct UsageLeftRight {
    static var leftMargin = 2
    static var leftUsage = 20
    static var indent = 4
    static var rightMargin = 70

    static let leftMin = 0
    static let rightMax = 100

    static func usage(_ style: UsageStyle = .normal) -> Usage {
        switch style {
        case .normal: return Usage(tagLeft: indent, textLeft: leftUsage, textRight: rightMargin)
        case .textOnly: return Usage(tagLeft: indent, textLeft: leftMargin, textRight: rightMargin)
        case .textWithIndent: return Usage(tagLeft: indent, textLeft: indent, textRight: rightMargin)
        }
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
        guard (leftMin...leftUsage) ~= left else { return }
        leftMargin = max(0, left)
    }

    /// Set the right margin
    /// - Parameter right: new right margin

    static func setRight(_ right: Int) {
        guard (leftMargin...rightMax) ~= right else { return }
        rightMargin = right
    }

    /// Set the usage left margin
    /// - Parameter left: new usage left margin

    static func setUsage(_ left: Int) {
        guard (indent...rightMargin) ~= left else { return }
        leftUsage = left
    }

    /// move evrything to the left when writing a markdown usage

    static func setMarkDown() {
        let undent = leftMargin
        leftMargin = 0
        leftUsage -= undent
        indent -= undent
        rightMargin -= undent
    }
}

/// Options usage
/// - Parameter opts: options for usage
/// - Returns: usage string

func optUsage(_ opts: OptsToGet) -> String {
    return UsageLeftRight.usage().optUsage(opts, options: [.longOnly])
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
    return UsageLeftRight.usage(.textOnly).paragraphWrap(texts)
}

/// Wrap text
/// - Parameter texts: text to wrap
/// - Returns: indented wrapped text

func indentedParagraphWrap(_ texts: [String]) -> String {
    return UsageLeftRight.usage(.textWithIndent).paragraphWrap(texts)
}

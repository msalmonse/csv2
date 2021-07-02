//
//  PlotOptions.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-29.
//

import Foundation

/// Collection of options for a plot

struct PlotOptions: OptionSet, CustomStringConvertible, CustomDebugStringConvertible {
    var debugDescription: String {
        return "0x\(rawValue.x0(3)) = \(description)"
    }

    static var allNames: [(PlotOptions, String)] = [
        (.bold,      "bold"),
        (.dashed,    "dashed"),
        (.filled,    "filled"),
        (.included,  "included"),
        (.italic,    "italic"),
        (.pointed,   "pointed"),
        (.scattered, "scattered"),
        (.stacked,   "stacked"),
        (.stroked,   "stroked")
    ]

    var description: String {
        var opts: [String] = []
        for (opt, name) in Self.allNames {
            if self.contains(opt) { opts.append(name) }
        }
        return "[" + opts.joined(separator: ",") + "]"
    }

    let rawValue: Int

    static let bold = PlotOptions(rawValue: 1 << 1)
    static let dashed = PlotOptions(rawValue: 1 << 2)
    static let filled = PlotOptions(rawValue: 1 << 3)
    static let included = PlotOptions(rawValue: 1 << 4)
    static let italic = PlotOptions(rawValue: 1 << 5)
    static let pointed = PlotOptions(rawValue: 1 << 6)
    static let scattered = PlotOptions(rawValue: 1 << 7)
    static let stacked = PlotOptions(rawValue: 1 << 8)
    static let stroked = PlotOptions(rawValue: 1 << 9)
}

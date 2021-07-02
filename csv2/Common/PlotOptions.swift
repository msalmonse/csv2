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
        (.bared,     "bared"),
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

    private func nextBit() -> PlotOptions {
        return PlotOptions(rawValue: rawValue << 1)
    }

    static let bared = PlotOptions(rawValue: 1 << 0)
    static let bold = PlotOptions.bared.nextBit()
    static let dashed = PlotOptions.bold.nextBit()
    static let filled = PlotOptions.dashed.nextBit()
    static let included = PlotOptions.filled.nextBit()
    static let italic = PlotOptions.included.nextBit()
    static let pointed = PlotOptions.italic.nextBit()
    static let scattered = PlotOptions.pointed.nextBit()
    static let stacked = PlotOptions.scattered.nextBit()
    static let stroked = PlotOptions.stacked.nextBit()

    // Which plot types are filled
    static let willFill = PlotOptions([.bared, .filled, .stacked])
    var isFilled: Bool { !isDisjoint(with: Self.willFill) }

    // Which plot types can be smoothed
    static let noSmoothing = PlotOptions([.bared, .scattered, .stacked])
    var canSmooth: Bool { isDisjoint(with: Self.noSmoothing) }

    // Which plot types can have negative values
    static let noNegitives = PlotOptions([.stacked])
    var negativesOK: Bool { isDisjoint(with: Self.noNegitives) }
}

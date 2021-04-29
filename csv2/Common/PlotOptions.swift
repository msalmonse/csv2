//
//  PlotOptions.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-29.
//

import Foundation

struct PlotOptions: OptionSet {
    let rawValue: Int

    static let bold = PlotOptions(rawValue: 1 << 1)
    static let dashed = PlotOptions(rawValue: 1 << 2)
    static let filled = PlotOptions(rawValue: 1 << 3)
    static let included = PlotOptions(rawValue: 1 << 4)
    static let italic = PlotOptions(rawValue: 1 << 5)
    static let pointed = PlotOptions(rawValue: 1 << 6)
    static let scattered = PlotOptions(rawValue: 1 << 7)

    // Convenience functions

    var isBold: Bool {
        get { self.contains(.bold) }
        set { if newValue { self.insert(.bold) } else { self.remove(.bold) } }
        }
    var isDashed: Bool {
        get { self.contains(.dashed) }
        set { if newValue { self.insert(.dashed) } else { self.remove(.dashed) } }
        }
    var isFilled: Bool {
        get { self.contains(.filled) }
        set { if newValue { self.insert(.filled) } else { self.remove(.filled) } }
        }
    var isIncluded: Bool {
        get { self.contains(.included) }
        set { if newValue { self.insert(.included) } else { self.remove(.bold) } }
        }
    var isItalic: Bool {
        get { self.contains(.italic) }
        set { if newValue { self.insert(.italic) } else { self.remove(.italic) } }
        }
    var isPointed: Bool {
        get { self.contains(.pointed) }
        set { if newValue { self.insert(.pointed) } else { self.remove(.pointed) } }
        }
    var isScattered: Bool {
        get { self.contains(.scattered) }
        set { if newValue { self.insert(.scattered) } else { self.remove(.scattered) } }
        }

    /// Insert an element in a PlotOptions
    /// - Parameters:
    ///   - left: Plotoptions
    ///   - right: element
    static func += (left: inout PlotOptions, right: PlotOptions) {
        left.insert(right)
    }

    /// Remove an element from a PlotOptions
    /// - Parameters:
    ///   - left: Plotoptions
    ///   - right: element
    static func -= (left: inout PlotOptions, right: PlotOptions) {
        left.remove(right)
    }
}

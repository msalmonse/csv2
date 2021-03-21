//
//  Style.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-21.
//

import Foundation

extension SVG {
    struct Style: CustomStringConvertible {
        var description: String { "style=\"" + optsDescription() + "\"" }

        var opts: [String: String?]

        init(_ opts: [String: String?]) {
            self.opts = opts
        }

        subscript(_ key: String) -> String? {
            get { return opts[key] ?? nil }
            set { opts[key] = newValue }
        }

        subscript(_ keys: [String]) -> String? {
            get { return nil }
            set {
                for key in keys {
                    opts[key] = newValue
                }
            }
        }

        func optsDescription() -> String {
            return
                opts.filter { $1 != nil }.map { "\($0): \($1!)"}.joined(separator: ";")
        }
    }
}

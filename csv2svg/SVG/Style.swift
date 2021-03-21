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

        /// Generate a semi-colon separated string of the style opts
        /// - Returns: style opts description

        func optsDescription() -> String {
            var result: [String] = []

            for key in opts.keys.sorted() where opts[key] != nil && opts[key]! != nil {
                result.append("\(key): \(opts[key]!!)")
            }
            return result.joined(separator: ";")
        }
    }
}

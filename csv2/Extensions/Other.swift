//
//  Extensions.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-11.
//

import Foundation

extension String {
    /// Just a little sugar
    var hasContent: Bool { !self.isEmpty }
}

extension Array {
    /// Just a little sugar
    var hasEntries: Bool { !self.isEmpty }

    func hasIndex(_ i: Int) -> Bool { self.indices.contains(i) }
}

extension Data {
    /// append for Strings
    /// - Parameter str: String to append

    mutating func append(_ str: String) {
        self.append(str.data(using: .utf8) ?? Data())
    }
}

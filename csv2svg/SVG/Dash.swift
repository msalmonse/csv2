//
//  Dash.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-17.
//

import Foundation

extension SVG {
    class Dash {
        static private var next = -1
        static private let dashList = [
            "10 15",
            "5 15 2",
            "15",
            "15 5 5",
            "5 10 15",
            "25"
        ]

        /// Get the dash in the sequence
        /// - Returns: next dash

        static func nextDash() -> String {
            next += 1
            if next >= dashList.count { next = 0 }
            return dashList[ next ]
        }

        /// Reset the dash sequence

        static func reset() {
            next = -1
        }
    }
}

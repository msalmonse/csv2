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
            [ 1.0, 1.0, 2.0, 1.0 ],
            [ 2.5 ],
            [ 3.0, 1.0, 2.0, 1.0 ],
            [ 3.5, 1.5 ],
            [ 1.0 ]
        ]

        /// Get the dash in the sequence
        /// - Returns: next dash

        static func nextDash(_ w: Double) -> String {
            let mult = w * 0.01
            next += 1
            if next >= dashList.count { next = 0 }
            return dashList[ next ].map { ($0 * mult).f(0) }.joined(separator:  " ")
        }

        /// Reset the dash sequence

        static func reset() {
            next = -1
        }
    }
}

//
//  SVG/TransScale.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-28.
//

import Foundation

extension SVG {
    /// translate and scale a point

    struct TransScale {
        private let xMult: Double
        private let xOffset: Double
        private let yMult: Double
        private let yOffset: Double

        init(from: Plane, to: Plane) {
            // a*max + b == right
            // a*min + b == left
            // a*(max - min) == right - left
            // similaly for top and bottom

            xMult = (to.right - to.left)/(from.right - from.left)
            xOffset = to.left - xMult * from.left

            yMult = (to.top - to.bottom)/(from.top - from.bottom)
            yOffset = to.bottom - yMult * from.bottom
        }

        /// Calculate the position on the svg plane from the data plane
        /// - Parameters
        ///     - x: x value
        ///     - y: y value
        /// - Returns: y position

        func pos(x: Double, y: Double) -> Point {
            return Point(x: xpos(x), y: ypos(y))
        }

        /// Calculate the x position on the svg plane from the data plane
        /// - Parameter x: x value
        /// - Returns: x position

        func xpos(_ x: Double) -> Double {
            return x * xMult + xOffset
        }

        /// Calculate the y position on the svg plane from the data plane
        /// - Parameter y: y value
        /// - Returns: y position

        func ypos(_ y: Double) -> Double {
            return y * yMult + yOffset
        }
    }
}

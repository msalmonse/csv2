//
//  SVG/Plane.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-01.
//

import Foundation

extension SVG {

    /// A point on the svg plane

    struct Point {
        let x: Double
        let y: Double
    }

    /// The edges of the plane

    struct Plane {
        let top: Double
        let bottom: Double
        let left: Double
        let right: Double

        /// Horizontal midpoint
        var hMid: Double { (left + right)/2.0 }

        /// Vertical midpoint
        var vMid: Double { (top + bottom)/2.0 }

        /// height i.e. top - bottom
        var height: Double { top > bottom ? top - bottom : bottom - top }

        /// width i.e. right - left
        var width: Double { left > right ? left - right : right - left }

        /// Check for value between left and right
        /// - Parameter x: value to check
        /// - Returns: value lies in plane

        func inHoriz(_ x: Double) -> Bool {
            return (left < right) ? (x >= left && x <= right) : (x >= right && x <= left)
        }

        /// Check for value between top and bottom
        /// - Parameter y: value to check
        /// - Returns: value lies in plane

        func inVert(_ y: Double) -> Bool {
            return (bottom < top) ? (y >= bottom && y <= top) : (y >= top && y <= bottom)
        }

        /// Check for value between left and right
        /// - Parameter x: value to check
        /// - Parameter y: value to check
        /// - Returns: value lies in plane

        func inPlane(_ x: Double, _ y: Double) -> Bool {
            return inHoriz(x) && inVert(y)
        }

    }
}

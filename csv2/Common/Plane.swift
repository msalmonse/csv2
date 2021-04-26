//
//  SVG/Plane.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-01.
//

import Foundation

/// The edges of the plane

struct Plane {
    let top: Double
    let bottom: Double
    let left: Double
    let right: Double
    // Horizontal and vertical adjustments to cater for floating point comparisons
    private let hε: Double
    private let vε: Double

    /// Initializer for Plane
    /// - Parameters:
    ///   - top: top edge of plane
    ///   - bottom: bottom edge of plane
    ///   - left: left  edgeof plane
    ///   - right: right edge of plane
    ///   - ε: fuziness of edge

    init(top: Double, bottom: Double, left: Double, right: Double, ε: Double = 1e-6) {
        self.top = top
        self.bottom = bottom
        self.left = left
        self.right = right
        hε = abs(right - left) * ε
        vε = abs(top - bottom) * ε
    }

    /// Initializer for Plane
    /// - Parameters:
    ///   - left: left  edgeof plane
    ///   - top: top edge of plane
    ///   - height: height of plane
    ///   - width: width of plane
    ///   - ε: fuziness of edge

    init(left: Double, top: Double, height: Double, width: Double, ε: Double = 1e-6) {
        self.init(top: top, bottom: top + height, left: left, right: left + width)
    }

    /// Horizontal midpoint
    var hMid: Double { (left + right)/2.0 }

    /// Vertical midpoint
    var vMid: Double { (top + bottom)/2.0 }

    /// Midpoint
    var mid: Point { Point(x: hMid, y: vMid) }

    /// height i.e. top - bottom
    var height: Double { top > bottom ? top - bottom : bottom - top }

    /// width i.e. right - left
    var width: Double { left > right ? left - right : right - left }

    /// Check for value between left and right
    /// - Parameter x: value to check
    /// - Returns: value lies in plane

    func inHoriz(_ x: Double) -> Bool {
        return (left < right) ? (x + hε >= left && x - hε <= right) : (x + hε >= right && x - hε <= left)
    }

    /// Check for value between top and bottom
    /// - Parameter y: value to check
    /// - Returns: value lies in plane

    func inVert(_ y: Double) -> Bool {
        return (bottom < top) ? (y + vε >= bottom && y - vε <= top) : (y + vε >= top && y - vε <= bottom)
    }

    /// Check for value between left and right
    /// - Parameter x: value to check
    /// - Parameter y: value to check
    /// - Returns: value lies in plane

    func inPlane(_ x: Double, _ y: Double) -> Bool {
        return inHoriz(x) && inVert(y)
    }

}

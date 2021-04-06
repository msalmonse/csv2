//
//  SVG/Plane.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-01.
//

import Foundation

/// A point on the  plane

struct Point: Equatable {
    let x: Double
    let y: Double

    /// Calculate the distance between two points
    /// - Parameter other: another point
    /// - Returns: distance betwwen points

    func distance(_ other: Point) -> Double {
        let xDiff = x - other.x
        let yDiff = y - other.y
        return sqrt(xDiff * xDiff + yDiff * yDiff)
    }

    /// Are 2 points close to each other
    /// - Parameters:
    ///   - other: another point
    ///   - limit: limit for closeness
    /// - Returns: are they close

    func close(_ other: Point, limit: Double) -> Bool {
        return distance(other) < limit
    }

    // very distant point
    static var inf: Point { return Point(x: Double.infinity, y: Double.infinity) }

    /// Calculate a point part way between two points
    /// - Parameters:
    ///   - other: the other point
    ///   - part: what part of the way
    /// - Returns: A new point at the right offset

    func partWay(_ other: Point, part: Double) -> Point {
        let xδ = (x - other.x) * part
        let yδ = (y - other.y) * part
        return Point(x: x - xδ, y: y - yδ)
    }
}

/// The edges of the plane

struct Plane {
    let top: Double
    let bottom: Double
    let left: Double
    let right: Double
    // Horizontal and vertical adjustments to cater for floating point comparisons
    private let hε: Double
    private let vε: Double

    init(top: Double, bottom: Double, left: Double, right: Double, ε: Double = 1e-6) {
        self.top = top
        self.bottom = bottom
        self.left = left
        self.right = right
        hε = abs(right - left) * ε
        vε = abs(top - bottom) * ε
    }

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

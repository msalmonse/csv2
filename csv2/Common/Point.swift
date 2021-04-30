//
//  Point.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-25.
//

import Foundation

/// A point on the  plane

struct Point: Equatable {
    let x: Double
    let y: Double

    /// Convert to CGPoint

    var cgpoint: CGPoint { return CGPoint(x: x, y: y) }

    /// Format a Point in fixed point format
    /// - Parameters:
    ///   - precision: the number of digits after the point
    ///   - separatedBy: the seperator between x and y
    /// - Returns: Formatted string

    func f(_ precision: Int, separatedBy: String = ",") -> String {
        return "\(x.f(precision))\(separatedBy)\(y.f(precision))"
    }

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

    /// Unary - function, used in tests
    /// - Parameter pt: original point
    /// - Returns: negative point

    static prefix func - (pt: Point) -> Point {
        return Point(x: -pt.x, y: -pt.y)
    }

    /// Add a vector to a point
    /// - Parameters:
    ///   - left: point
    ///   - right: vector
    /// - Returns: new point

    static func + (left: Point, right: Vector) -> Point {
        return Point(x: left.x + right.dx, y: left.y + right.dy)
    }

    /// Subtract a point from a point
    /// - Parameters:
    ///   - left: point
    ///   - right: other point
    /// - Returns: Vector between points

    static func - (left: Point, right: Point) -> Vector {
        return Vector(dx: left.x - right.x, dy: left.y - right.y)
    }
}

//
//  Transform.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-08.
//

import Foundation

struct Transform: Equatable {
    /// the transform struct is a 3x3 matrix arranged as:
    /// a c e
    /// b d f
    /// 0 0 1
    /// Thus in a matrix, a is 1,1; b is 2,1; c is 1,2; d is 2,2; e is 1,3 and; f is 2.3

    let a: Double
    let b: Double
    let c: Double
    let d: Double
    let e: Double
    let f: Double

    /// A comma separated list of a...f

    var csv: String { return self.list() }

    /// The identity matrix

    static var identity: Transform { Transform(a: 1.0, b: 0.0, c: 0.0, d: 1.0, e: 0.0, f: 0.0) }

    /// Generate a list of a...f
    /// - Parameter sep: separator
    /// - Returns: a list of the transform values

    func list(separator sep: String = ",") -> String {
        return [a, b, c, d, e, f].map { $0.f(2) }.joined(separator: sep)
    }

    /// An empty matrix

    static var null: Transform { return Transform(a: 0.0, b: 0.0, c: 0.0, d: 0.0, e: 0.0, f: 0.0) }

    /// Create rotation transform
    /// - Parameters:
    ///   - sin: sin of angle to rotate by
    ///   - cos: cos of angle
    /// - Returns: rotate transform

    static func rotate(sin: Double, cos: Double) -> Transform {
        return Transform(a: cos, b: -sin, c: sin, d: cos, e: 0.0, f: 0.0)
    }

    /// Rotate around a point
    /// - Parameters:
    ///   - x: x position
    ///   - y: y position
    ///   - sin: sin of angle to rotate by
    ///   - cos: cos of angle
    /// - Returns: Translate rotate and translate points

    static func rotateAround(x: Double, y: Double, sin: Double, cos: Double) -> Transform {
        return Transform.translate(dx: x, dy: y)
            * Transform.rotate(sin: sin, cos: cos)
            * Transform.translate(dx: -x, dy: -y)
    }

    /// Rotate around a point
    /// - Parameters:
    ///   - centre: point to rotate around
    ///   - sin: sin of angle to rotate by
    ///   - cos: cos of angle
    /// - Returns: Translate, rotate and translate transform

    static func rotateAround(centre: Point, sin: Double, cos: Double) -> Transform {
        return Self.rotateAround(x: centre.x, y: centre.y, sin: sin, cos: cos)
    }

    /// Create translate matrix
    /// - Parameters:
    ///   - dx: x change
    ///   - dy: y change
    /// - Returns: translate transform

    static func translate(dx: Double, dy: Double) -> Transform {
        return Transform(a: 1.0, b: 0.0, c: 0.0, d: 1.0, e: dx, f: dy)
    }

    /// Create a translate matrix using a point
    /// - Parameter d: translate point
    /// - Returns: translate transform

    static func translate(d: Point) -> Transform { return Self.translate(dx: d.x, dy: d.y) }
}

extension Transform {

    /// Multiply two transforms
    /// - Parameters:
    ///   - l: left transform
    ///   - r: right transform
    /// - Returns: product transform

    static func * (l: Transform, r: Transform) -> Transform {
        let a = l.a * r.a + l.c * r.b + l.e * 0.0
        let c = l.a * r.c + l.c * r.d + l.e * 0.0
        let e = l.a * r.e + l.c * r.f + l.e * 1.0
        let b = l.b * r.a + l.d * r.b + l.f * 0.0
        let d = l.b * r.c + l.d * r.d + l.f * 0.0
        let f = l.b * r.e + l.d * r.f + l.f * 1.0

        return Transform(a: a, b: b, c: c, d: d, e: e, f: f)
    }

    /// Transform a point
    ///  A point is presumed to have a third value that is always 1
    /// - Parameters:
    ///   - l: transform
    ///   - r: point
    /// - Returns: transformed point

    static func * (l: Transform, r: Point) -> Point {
        let x = l.a * r.x + l.c * r.y + l.e * 1.0
        let y = l.b * r.x + l.d * r.y + l.f * 1.0
        return Point(x: x, y: y)
    }
}

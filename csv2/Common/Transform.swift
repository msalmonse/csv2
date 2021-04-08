//
//  Transform.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-08.
//

import Foundation

struct Transform {
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

    static func rotate(sin: Double, cos: Double) -> Transform {
        return Transform(a: cos, b: -sin, c: sin, d: cos, e: 0.0, f: 0.0)
    }

    static func translate(x: Double, y: Double) -> Transform {
        return Transform(a: 0.0, b: 0.0, c: 0.0, d: 0.0, e: x, f: y)
    }
}

extension Transform {
    static func * (l: Transform, r: Transform) -> Transform {
        let a = l.a * r.a + l.c * r.b + l.e * 0.0
        let c = l.a * r.c + l.c * r.d + l.e * 0.0
        let e = l.a * r.e + l.c * r.f + l.e * 1.0
        let b = l.b * r.a + l.d * r.b + l.f * 0.0
        let d = l.b * r.c + l.d * r.d + l.f * 0.0
        let f = l.b * r.e + l.d * r.f + l.f * 1.0

        return Transform(a: a, b: b, c: c, d: d, e: e, f: f)
    }
}

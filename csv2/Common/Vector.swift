//
//  Vector.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-25.
//

import Foundation

/// The difference between two points

struct Vector {
    let dx: Double
    let dy: Double

    /// Simple init() of vactor
    /// - Parameters:
    ///   - dx: x diff
    ///   - dy: y diff

    init(dx: Double, dy: Double) { self.dx = dx; self.dy = dy }

    /// init() using a length and angle
    /// - Parameters:
    ///   - length: length of vector
    ///   - angle: angle of vector

    init(length: Double, angle: Double) {
        let dx = length * cos(angle)
        let dy = -length * sin(angle)
        self.init(dx: dx, dy: dy)
    }

    /// Convert to CGVector

    var cgvector: CGVector { CGVector(dx: dx, dy: dy) }

    /// Format a Vector in fixed point format
    /// - Parameters:
    ///   - precision: the number of digits after the point
    ///   - separatedBy: the seperator between x and y
    /// - Returns: Formatted string

    func f(_ precision: Int, separatedBy: String = ",") -> String {
        return "\(dx.f(precision))\(separatedBy)\(dy.f(precision))"
    }
}

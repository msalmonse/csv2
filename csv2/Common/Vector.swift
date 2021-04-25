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
        let dx = length * sin(angle)
        let dy = length * cos(angle)
        self.init(dx: dx, dy: dy)
    }
}

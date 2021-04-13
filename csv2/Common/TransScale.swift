//
//  TransScale.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-28.
//

import Foundation

/// translate and scale a point

struct TransScale {
    private let xMult: Double
    private let xOffset: Double
    private let yMult: Double
    private let yOffset: Double
    private let logx: Bool
    private let logy: Bool

    /// Initialize a TranScale object, translate and scale points between equivlent planes
    /// - Parameters:
    ///   - from: from plane
    ///   - to: to plane
    ///   - logx: logarithmic abscissa
    ///   - logy: logarithmic ordinate

    init(from: Plane, to: Plane, logx: Bool = false, logy: Bool = false) {
        // a*max + b == right
        // a*min + b == left
        // a*(max - min) == right - left
        // similaly for top and bottom

        self.logx = logx
        self.logy = logy

        if logx {
            xMult = (to.right - to.left)/log10(from.right/from.left)
            xOffset = to.left - xMult * log10(from.left)
        } else {
            xMult = (to.right - to.left)/(from.right - from.left)
            xOffset = to.left - xMult * from.left
        }

        if logy {
            yMult = (to.top - to.bottom)/log10(from.top/from.bottom)
            yOffset = to.bottom - yMult * log10(from.bottom)
        } else {
            yMult = (to.top - to.bottom)/(from.top - from.bottom)
            yOffset = to.bottom - yMult * from.bottom
        }
    }

    /// Calculate the position on the svg plane from the data plane
    /// - Parameters
    ///     - pt: x and y values
    /// - Returns: x, y point

    func pos(_ pt: Point) -> Point {
        return Point(x: xpos(pt.x), y: ypos(pt.y))
    }

    /// Calculate the position on the svg plane from the data plane
    /// - Parameters
    ///     - x: x value
    ///     - y: y value
    /// - Returns: x, y point

    func pos(x: Double, y: Double) -> Point {
        return Point(x: xpos(x), y: ypos(y))
    }

    /// Calculate the x position on the svg plane from the data plane
    /// - Parameter x: x value
    /// - Returns: x position

    func xpos(_ x: Double) -> Double {
        return (logx ? log10(x) : x) * xMult + xOffset
    }

    /// Calculate the y position on the svg plane from the data plane
    /// - Parameter y: y value
    /// - Returns: y position

    func ypos(_ y: Double) -> Double {
        return (logy ? log10(y) : y) * yMult + yOffset
    }
}

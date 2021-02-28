//
//  SvgTransScale.swift
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

        /// Calculate to x position on the svg plane from the input plane
        /// - Parameter x: x value
        /// - Returns: x position
        func xpos(_ x: Double) -> Double {
            return x * xMult + xOffset
        }

        /// Calculate to y position on the svg plane from the input plane
        /// - Parameter y: y value
        /// - Returns: y position
        func ypos(_ y: Double) -> Double {
            return y * yMult + yOffset
        }
    }
}

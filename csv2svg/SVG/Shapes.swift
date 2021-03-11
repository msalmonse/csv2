//
//  Shapes.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-11.
//

import Foundation

extension SVG {

    /// The shapes that can be used on a scatter plot

    enum Shape {
        case circle, diamond, square, star

        static private var next = -1

        /// Convert an abstract shape to a PathCommand
        /// - Parameter w: the size of the path
        /// - Returns: a PathCommand to draw the shape

        func pathCommand(w: Double) -> PathCommand {
            switch self {
            case .circle: return PathCommand.circle(r: w)
            case .diamond: return PathCommand.diamond(w: w)
            case .square: return PathCommand.square(w: w)
            case .star: return PathCommand.star(w: w)
            }
        }

        static let namedShapes = [
            "circle":   Self.circle,
            "diamond":  Self.diamond,
            "square":   Self.square,
            "star":     Self.star
        ]

        static let numberedShapes = [
            Self.circle, Self.diamond, Self.square, Self.star
        ]

        static func lookup(_ name: String) -> Shape? {
            return namedShapes[ name ]
        }

        static func nextShape() -> Shape {
            next += 1
            if next >= numberedShapes.count { next = 0 }
            return numberedShapes[ next ]
        }
    }

}

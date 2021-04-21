//
//  Shapes.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-11.
//

import Foundation

/// The shapes that can be used on a scatter plot or when showing data points

enum Shape {
    case
        blade,
        circle,
        circleStar,
        cross,
        diamond,
        shuriken,
        square,
        star,
        triangle

    static private var next = -1

    /// Convert an abstract shape to a PathCommand
    /// - Parameter w: the size of the path
    /// - Returns: a PathCommand to draw the shape

    func pathComponent(w: Double) -> PathComponent {
        switch self {
        case .blade: return PathComponent.blade(w: w)
        case .circle: return PathComponent.circle(r: w)
        case .circleStar: return PathComponent.circleStar(w: w)
        case .cross: return PathComponent.cross(w: w)
        case .diamond: return PathComponent.diamond(w: w)
        case .shuriken: return PathComponent.shuriken(w: w)
        case .square: return PathComponent.square(w: w)
        case .star: return PathComponent.star(w: w)
        case .triangle: return PathComponent.triangle(w: w)
        }
    }

    /// Lookup table for shapes
    static let namedShapes = [
        "blade":        Self.blade,
        "circle":       Self.circle,
        "circleStar":   Self.circleStar,
        "cross":        Self.cross,
        "diamond":      Self.diamond,
        "shuriken":     Self.shuriken,
        "square":       Self.square,
        "star":         Self.star,
        "triangle":     Self.triangle
    ]

    /// Sequential table for shapes
    static let numberedShapes = [
        Self.blade,
        Self.circle,
        Self.cross,
        Self.diamond,
        Self.shuriken,
        Self.square,
        Self.star,
        Self.triangle
    ]

    static func lookup(_ name: String) -> Shape? {
        return namedShapes[ name ]
    }

    static func nextShape() -> Shape {
        next += 1
        if next >= numberedShapes.count { next = 0 }
        return numberedShapes[ next ]
    }

    static func allNames() -> String {
        return namedShapes.keys.sorted().joined(separator: " ")
    }
}

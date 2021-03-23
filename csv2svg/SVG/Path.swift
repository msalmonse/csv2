//
//  SVG/Path.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-22.
//

import Foundation

extension SVG {

    /// path commands

    /// Enum describing the arc type

    enum ArcType {
        case
            longIn,      // longest path, towards the centre
            longOut,     // longest path away from the centre
            shortIn,     // shortest path towards centre
            shortOut     // shortest path away from centre

        var largeSweep: String {
            switch self {
            case .longIn: return "1,1"
            case .longOut: return "1,0"
            case .shortIn: return "0,1"
            case .shortOut: return "0,0"
            }
        }
    }

    /// Enum describing the ways a path can be drawn

    enum PathCommand {
        case
            arc(rx: Double, ry: Double, rot: Double, type: ArcType, dx: Double, dy: Double),
                                                        // Draw an arc
            blade(w: Double),                           // Draw a blade of width 2 * w
            circle(r: Double),                          // Draw a circle of radius r
            diamond(w: Double),                         // a diamond of width 2 * w
            moveBy(dx: Double, dy: Double),             // Move by dx and dy
            moveTo(x: Double, y: Double),               // Move absolute to x,y
            horizBy(dx: Double),                        // Draw line horizontally by dx
            horizTo(x: Double),                         // Draw line horizontally to x
            lineBy(dx: Double, dy: Double),             // Draw line by dx,dy
            lineTo(x: Double, y: Double),               // Draw line to x,y
            shuriken(w: Double),                        // Draw shuriken
            square(w: Double),                          // Draw a square with sides 2 * w
            star(w: Double),                            // Draw a star of width 2 * w
            triangle(w: Double),                        // Draw a triangle of width 2 * w
            vertBy(dy: Double),                         // Draw line vertically by dy
            vertTo(y: Double)                           // Draw line vertically to y

        /// Convert a command into a path string
        /// - Returns: path string

        func command() -> String {
            switch self {
            case .arc(let rx, let ry, let rot, let type, let dx, let dy):
                return "a \(rx.f(1)),\(ry.f(1)),\(rot.f(1)),\(type.largeSweep),\(dx.f(1)),\(dy.f(1))"
            case .blade(let w): return drawBlade(w: w)
            case .circle(let r): return drawCircle(r: r)
            case .diamond(let w): return drawDiamond(w: w)
            case .moveBy(let dx, let dy): return "m \(dx.f(1)),\(dy.f(1))"
            case .moveTo(let x, let y): return "M \(x.f(1)),\(y.f(1))"
            case .horizBy(let dx): return "h \(dx.f(1))"
            case .horizTo(let x): return "H \(x.f(1))"
            case .lineBy(let dx, let dy): return "l \(dx.f(1)),\(dy.f(1))"
            case .lineTo(let x, let y): return "L \(x.f(1)),\(y.f(1))"
            case .shuriken(let w): return drawShuriken(w: w)
            case .square(let w): return drawSquare(w: w)
            case .star(let w): return drawStar(w: w)
            case .triangle(let w): return drawTriangle(w: w)
            case .vertBy(let dy): return "v \(dy.f(1))"
            case .vertTo(let y): return "V \(y.f(1))"
            }
        }
    }

    /// plot a path from a list of points
    /// - Parameters:
    ///   - points: a list of the points or shapes on path
    ///   - properties: plot properties
    ///   - width: setting for stroke-width, (default 1)
    ///   - linecap: setting for stroke-linecap (default "round")
    /// - Returns: a path element

    static func path(
        _ points: [PathCommand],
        _ props: PathProperties,
        width: Double = 1.0,
        linecap: String = "round"
    ) -> String {
        // a path needs 2 points
        guard points.count >= 2 else { return "" }

        var style = Style([
            "stroke": props.colour ?? Colours.nextColour(),
            "fill": "none",
            "stroke-width": width.f(1),
            "stroke-linecap": linecap
        ])

        if props.dashed {
            style["stroke-dasharray"] = props.dash ?? Dashes.nextDash(800.0)
            style["stroke-linecap"] = "butt"
        }

        var result = [ "<path d=\"" ]
        result.append(contentsOf: points.map { $0.command() })
        result.append("\" \(style) />")

        return result.joined(separator: " ")
    }

}

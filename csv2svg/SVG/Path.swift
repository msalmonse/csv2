//
//  SVG/Path.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-22.
//

import Foundation

extension SVG {

    /// path commands

    /// Enum describing the ways a path can be drawn

    enum PathCommand {
        case
            arc(rx: Double, ry: Double, rot: Double, large: Bool, sweep: Bool, dx: Double, dy: Double),
                                                        // Draw an arc
            circle(r: Double),                          // Draw a circle of radius r
            cross(w: Double),                           // Draw a cross of width 2 * w
            diamond(w: Double),                         // a diamond of width 2 * w
            moveBy(dx: Double, dy: Double),             // Move by dx and dy
            moveTo(x: Double, y: Double),               // Move absolute to x,y
            horizBy(dx: Double),                        // Draw line horizontally by dx
            horizTo(x: Double),                         // Draw line horizontally to x
            lineBy(dx: Double, dy: Double),             // Draw line by dx,dy
            lineTo(x: Double, y: Double),               // Draw line to x,y
            square(w: Double),                          // Draw a square with sides 2 * w
            vertBy(dy: Double),                         // Draw line vertically by dy
            vertTo(y: Double)                           // Draw line vertically to y

        /// Convert a command into a path string
        /// - Returns: path string

        func command() -> String {
            switch self {
            case .arc(let rx, let ry, let rot, let large, let sweep, let dx, let dy):
                return String(
                    format: "a %.1f,%.1f,%.1f,%d,%d,%.1f,%.1f",
                    rx, ry, rot, large ? 1 : 0, sweep ? 1 : 0, dx, dy
                )
            case .circle(let r): return drawCircle(r: r)
            case .cross(let w): return drawCross(w: w)
            case .diamond(let w): return drawDiamond(w: w)
            case .moveBy(let dx, let dy): return String(format: "m %.1f,%.1f", dx, dy)
            case .moveTo(let x, let y): return String(format: "M %.1f,%.1f", x, y)
            case .horizBy(let dx): return String(format: "h %0.1f", dx)
            case .horizTo(let x): return String(format: "H %0.1f", x)
            case .lineBy(let dx, let dy): return String(format: "l %.1f,%.1f", dx, dy)
            case .lineTo(let x, let y): return String(format: "L %.1f,%.1f", x, y)
            case .square(let w): return SVG.drawSquare(w: w)
            case .vertBy(let dy): return String(format: "v %0.1f", dy)
            case .vertTo(let y): return String(format: "V %0.1f", y)
            }
        }
    }

    private static func drawCircle(r: Double) -> String {
        return [
            PathCommand.moveBy(dx: 0, dy: -r),
            .arc(rx: r, ry: r, rot: 0, large: true, sweep: true, dx: 0.0, dy: 2 * r),
            .arc(rx: r, ry: r, rot: 0, large: true, sweep: true, dx: 0.0, dy: -2 * r),
            .moveBy(dx: 0, dy: r)
        ].map { $0.command()}.joined(separator: " ")
    }

    private static func drawCross(w: Double) -> String {
        let half = w/2.0
        return [
            PathCommand.moveBy(dx: -half, dy: -half),
            .vertBy(dy: -half), .horizBy(dx: w), .vertBy(dy: half),     // top
            .horizBy(dx: half), .vertBy(dy: w), .horizBy(dx: -half),    // right
            .vertBy(dy: half), .horizBy(dx: -w), .vertBy(dy: -half),    // bottom
            .horizBy(dx: -half), .vertBy(dy: -w), .horizBy(dx: half),   // left
            .moveBy(dx: half, dy: half)
        ].map { $0.command()}.joined(separator: " ")
    }

    private static func drawDiamond(w: Double) -> String {
        return [
            PathCommand.moveBy(dx: -w, dy: 0.0),
            .lineBy(dx: w, dy: -w),
            .lineBy(dx: w, dy: w),
            .lineBy(dx: -w, dy: w),
            .lineBy(dx: -w, dy: -w),
            .moveBy(dx: w, dy: 0.0)
        ].map { $0.command()}.joined(separator: " ")
    }

    private static func drawSquare(w: Double) -> String {
        let w2 = w * 2.0
        return [
            PathCommand.moveBy(dx: -w, dy: -w),
            .horizBy(dx: w2),
            .vertBy(dy: w2),
            .horizBy(dx: -w2),
            .vertBy(dy: -w2),
            .moveBy(dx: w, dy: w)
        ].map { $0.command()}.joined(separator: " ")

    }

    /// The shapes that can be used on a scatter plot

    enum ScatterShape {
        case circle, cross, diamond, square

        /// Convert an abstract shape to a PathCommand
        /// - Parameter w: the size of the path
        /// - Returns: a PathCommand to draw the shape

        func pathCommand(w: Double) -> PathCommand {
            switch self {
            case .circle: return PathCommand.circle(r: w)
            case .cross: return PathCommand.cross(w: w)
            case .diamond: return PathCommand.diamond(w: w)
            case .square: return PathCommand.square(w: w)
            }
        }
    }

    /// plot a path from a list of points
    /// - Parameters:
    ///   - points: a list of the points on path
    ///   - stroke: contents of the stroke paramater of the path
    ///   - width: setting for stroke-width, (default 1)
    ///   - linecap: setting for stroke-linecap (default "round")
    /// - Returns: a path element

    static func svgPath(
        _ points: [PathCommand],
        stroke: String? = nil,
        width: Int = 1,
        linecap: String = "round"
    ) -> String {
        let strokeColour = stroke ?? Colours.nextColour()
        let style = [
            "stroke: \(strokeColour)",
            "fill: none",
            "stroke-width: \(width)",
            "stroke-linecap: \(linecap)"
        ].joined(separator: "; ")

        // a path needs 2 points
        guard points.count >= 2 else { return "" }

        var result = [ "<path d=\"" ]

        result.append(contentsOf: points.map { $0.command() })
        result.append("\" style=\"\(style)\" />")

        return result.joined(separator: " ")
    }

}

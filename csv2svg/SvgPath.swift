//
//  SvgPath.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-22.
//

import Foundation

extension SVG {

    /// path commands

    enum PathCommand {
        case
            arc(rx: Double, ry: Double, rot: Double, large: Bool, sweep: Bool, dx: Double, dy: Double),
                                                    // Draw an arc
            circle(r: Double),                      // Draw a circle of radius r
            moveBy(dx: Double, dy: Double),         // Move by dx and dy
            moveTo(x: Double, y: Double),           // Move absolute to x,y
            horizTo(x: Double),                     // Draw line horizontally to x
            lineTo(x: Double, y: Double),           // Draw line to x,y
            vertTo(y: Double)                       // Draw line vertically to y

        func command() -> String {
            switch self {
            case .arc(let rx, let ry, let rot, let large, let sweep, let dx, let dy):
                return String(
                    format: "a %.1f,%.1f,%.1f,%d,%d,%.1f,%.1f",
                    rx, ry, rot, large ? 1 : 0, sweep ? 1 : 0, dx, dy
                )
            case .circle(let r):
                return [
                    Self.moveBy(dx: 0, dy: -r),
                    Self.arc(rx: r, ry: r, rot: 0, large: true, sweep: true, dx: 0.0, dy: 2 * r),
                    Self.arc(rx: r, ry: r, rot: 0, large: true, sweep: true, dx: 0.0, dy: -2 * r),
                    Self.moveBy(dx: 0, dy: r)
                ].map { $0.command()}.joined(separator: " ")
            case .moveBy(let dx, let dy): return String(format: "m %.1f,%.1f", dx, dy)
            case .moveTo(let x, let y): return String(format: "M %.1f,%.1f", x, y)
            case .horizTo(let x): return String(format: "H %0.1f", x)
            case .lineTo(let x, let y): return String(format: "L %.1f,%.1f", x, y)
            case .vertTo(let y): return String(format: "V %0.1f", y)
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

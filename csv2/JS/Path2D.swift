//
//  Path2D.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-09.
//

import Foundation

extension JS {
    /// Plot a path using Path2D
    /// - Parameters:
    ///   - points: list of path commands
    ///   - props: path properties
    /// - Returns: JavaScript string

    func plotPath(_ points: [PathCommand], props: Properties) -> String {
        var result: [String] = [""]

        let colour = props.cascade(.colour) ?? "black"
        if colour != ctx.strokeStyle {
            ctx.strokeStyle = colour
            result.append("ctx.strokeStyle = '\(colour)'")
        }

        let strokeWidth = props.cascade(.strokeWidth)
        if strokeWidth > 0.0 && strokeWidth != ctx.lineWidth {
            ctx.lineWidth = strokeWidth
            result.append("ctx.lineWidth = \(strokeWidth.f(1))")
        }

        let strokeLineCap = props.cascade(.strokeLineCap) ?? "round"
        if strokeLineCap != ctx.lineCap {
            ctx.lineCap = strokeLineCap
            result.append("ctx.lineCap = '\(strokeLineCap)'")
        }

        let path = points.map { $0.command() }.joined(separator: " ")
        result.append("p = new Path2D('\(path)'); ctx.stroke(p)")

        return result.joined(separator: "\n    ")
    }
}

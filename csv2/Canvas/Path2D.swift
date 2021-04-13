//
//  Path2D.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-09.
//

import Foundation

extension Canvas {
    /// Plot a path using Path2D
    /// - Parameters:
    ///   - points: list of path commands
    ///   - props: path properties
    /// - Returns: JavaScript string

    func plotPath(_ points: [PathCommand], props: Properties, fill: Bool) -> String {
        var result: [String] = [""]
        let op = fill ? "fill" : "stroke"

        ctx.sync(props, &result)

        let path = points.map { $0.command() }.joined(separator: " ")
        result.append("p = new Path2D('\(path)'); ctx.\(op)(p)")

        return result.joined(separator: "\n    ")
    }
}

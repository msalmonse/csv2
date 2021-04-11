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

    func plotPath(_ points: [PathCommand], props: Properties, fill: Bool) -> String {
        var result: [String] = [""]
        let op = fill ? "fill" : "stroke"

        ctx.sync(props, &result)

        let path = points.map { $0.command() }.joined(separator: " ")
        result.append("p = new Path2D('\(path)'); ctx.\(op)(p)")

        return result.joined(separator: "\n    ")
    }

    /// Draw a path and fill it
    /// - Parameters:
    ///   - points: list of path commands
    ///   - props: path properties
    /// - Returns: JavaScript string

    func plotFilledPath(_ points: [PathCommand], props: Properties) -> String {
        return plotPath(points, props: props, fill: true)
    }

    /// Draw a path and stroke it
    /// - Parameters:
    ///   - points: list of path commands
    ///   - props: path properties
    /// - Returns: JavaScript string

    func plotStrokedPath(_ points: [PathCommand], props: Properties) -> String {
        return plotPath(points, props: props, fill: false)
    }
}

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

        ctx.sync(props, &result)

        let path = points.map { $0.command() }.joined(separator: " ")
        result.append("p = new Path2D('\(path)'); ctx.stroke(p)")

        return result.joined(separator: "\n    ")
    }
}

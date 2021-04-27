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
    ///   - components: list of path commands
    ///   - styles: path properties
    /// - Returns: JavaScript string

    func plotPath(_ path: Path, styles: Styles, fill: Bool) {
        var result: [String] = [""]
        let op = fill ? "fill" : "stroke"

        ctx.sync(styles, &result)

        let pathText = path.path
        result.append("p = new Path2D('\(pathText)'); ctx.\(op)(p)")

        data.append(result.joined(separator: "\n    "))
    }
}

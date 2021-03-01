//
//  SvgAxes.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-01.
//

import Foundation

extension SVG {

    /// Draw axes
    /// - Parameter ts: scaling and tranlating object
    /// - Returns: paths with axes
    
    func svgAxes(_ ts: TransScale) -> String {
        let path: [PathCommand] = [
            .moveTo(x: plotEdges.left, y: ts.ypos(0.0)),
            .horizTo(x: plotEdges.right),
            .moveTo(x: ts.xpos(0), y: plotEdges.bottom),
            .vertTo(y: plotEdges.top)
        ]
        return Self.svgPath(path, stroke: "Black")
    }
}

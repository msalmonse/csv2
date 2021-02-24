//
//  SvgPath.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-22.
//

import Foundation

extension SVG {
    
    /// A point on the svg plane
    
    struct point {
        let x: Double
        let y: Double
    }

    /// plot a path from a list of points
    /// - Parameters:
    ///   - points: a list of the points on path
    ///   - stroke: contents of the stroke paramater of the path
    /// - Returns: a path element

    static func svgPath(_ points: [point], stroke: String? = nil) -> String {
        func pathPoint(_ ml: String, _ p: point) -> String {
            return String(format: " %@ %.1f,%.1f", ml, p.x, p.y)
        }
        
        // a path needs 2 points
        guard points.count >= 2 else { return "" }

        var result = "<path d=\""

        result += pathPoint("M", points[0])
        for i in 1..<points.count {
            result += pathPoint("L", points[i])
        }
        result += "\" "

        result += "/>"

        return result
    }

}

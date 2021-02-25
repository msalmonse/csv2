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
        case moveTo(x: Double, y: Double), lineTo(x: Double, y:Double)
        
        func command() -> String {
            switch self {
            case .moveTo(let x, let y): return String(format: "M %.1f,%.1f", x, y)
            case .lineTo(let x, let y): return String(format: "L %.1f,%.1f", x, y)
            }
        }
    }

    /// plot a path from a list of points
    /// - Parameters:
    ///   - points: a list of the points on path
    ///   - stroke: contents of the stroke paramater of the path
    /// - Returns: a path element

    static func svgPath(_ points: [PathCommand], stroke: String? = nil) -> String {

        // a path needs 2 points
        guard points.count >= 2 else { return "" }

        var result = [ "<path d=\"" ]

        result.append(contentsOf: points.map{ $0.command() })
        result.append("\"")

        result.append("/>")

        return result.joined(separator: " ")
    }

}

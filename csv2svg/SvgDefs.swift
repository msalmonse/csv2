//
//  SvgDefs.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-28.
//

import Foundation

extension SVG {
    func svgDefs() -> [String] {
        let h = String(format: "%.1f", plotEdges.bottom - plotEdges.top)
        let w = String(format: "%.1f", plotEdges.right - plotEdges.left)
        let x = String(format: "%.1f", plotEdges.left)
        let y = String(format: "%.1f", plotEdges.top)
        var result = ["<defs>"]
        result.append("<clipPath id=\"plotable\">")
        result.append("<rect x=\"\(x)\" y=\"\(y)\" width=\"\(w)\" height=\"\(h)\" />")
        result.append("</clipPath>")
        result.append("</defs>")
        
        return result
    }
}

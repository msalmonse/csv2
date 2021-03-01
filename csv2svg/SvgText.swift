//
//  SvgText.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-28.
//

import Foundation

extension SVG {

    /// Add title to the svg
    /// - Returns: String to display title
    
    func svgTitle() -> String {
        let x = settings.width/2
        let y = settings.height - 5
        let t = settings.title 
        return """
            <text x="\(x)" y="\(y)" style="text-anchor: middle; font-size: 25px">\(t)</text>
            """
    }

    func svgLegends(_ x: Double, _ y: Double, size: Int = 13) -> String {
        let iMax = settings.inColumns ? csv.colCt : csv.rowCt
        var legends = [
            "<text x=\"\(x)\" y=\"\(y)\" style=\"text-anchor: middle; font-size: \(size)px\">"
        ]
        
        for i in 0..<iMax {
            if i != index {
                let text = names[i]
                let colour = colours[i]
                legends.append("<tspan dx=\"\(size)px\" fill=\"\(colour)\">\(text)</tspan>")
            }
        }
        legends.append("</text>")
        
        return legends.joined()
    }
}

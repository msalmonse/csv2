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
}

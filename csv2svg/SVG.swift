//
//  SVG.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-18.
//

import Foundation

class SVG {
    let csv: CSV
    let settings: Settings
    
    // Row or column to use for x values
    let index: Int
    
    // The four sides of the plane
    let top: Double
    let bottom: Double
    let left: Double
    let right: Double

    // Tags
    let xmlTag = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>"
    var svgTag: String {
        get {
            return String(
                format: "<svg width=\"%d\" height=\"%d\" xmlns=\"http://www.w3.org/2000/svg\">",
                settings.width, settings.height
            )
        }
    }
    let svgTagEnd = "</svg>"

    init(_ csv: CSV, _ settings: Settings) {
        self.csv = csv
        self.settings = settings
        
        self.index = settings.index - 1
        
        (top, bottom, left, right) = SVG.sidesFromColumns(csv, settings)
    }

    func svgLineGroup() -> [String] {
        return [ "<g >", "</g>" ]
    }
    
    func gen() -> [String] {
        var result: [String] = [ xmlTag, svgTag ]
        result.append(contentsOf: svgLineGroup())
        result.append(svgTagEnd)
        
        return result
    }
}

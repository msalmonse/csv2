//
//  SVG.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-18.
//

import Foundation

class SVG {

    /// A point on the svg plane
    
    struct Point {
        let x: Double
        let y: Double
    }
    
    /// The edges of the plane
    
    struct Plane {
        let top: Double
        let bottom: Double
        let left: Double
        let right: Double
    }

    let csv: CSV
    let settings: Settings
    
    // Row or column to use for x values
    let index: Int
    
    // The four sides of the plane
    let edges: Plane

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
        
        edges = SVG.sidesFromColumns(csv, settings)
    }

    func svgLineGroup(_ ts: TransScale) -> [String] {
        var result = [ "<g>"]
        result.append(contentsOf: columnPlot(ts))
        result.append("</g>")
        
        return result
    }
    
    func gen() -> [String] {
        let ts = TransScale(
            from: edges,
            to: Plane(top: 100, bottom: Double(settings.height),
                      left: 100, right: Double(settings.width)
            )
        )

        var result: [String] = [ xmlTag, svgTag ]
        result.append(contentsOf: svgLineGroup(ts))
        result.append(svgTagEnd)
        
        return result
    }
}

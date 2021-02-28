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
    
    // The four sides of the data plane
    let dataEdges: Plane
    // and the plot plane
    let plotEdges: Plane

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
        
        dataEdges = SVG.sidesFromColumns(csv, settings)
        plotEdges = Plane(
            top: 10, bottom: Double(settings.height - (settings.title == "" ? 100 : 130)),
            left: 100, right: Double(settings.width)
        )
    }
    
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

    func svgLineGroup(_ ts: TransScale) -> [String] {
        var result = [ "<g clip-path=\"url(#plotable)\" >"]
        result.append(svgAxes(ts))
        result.append(contentsOf: columnPlot(ts))
        result.append("</g>")
        
        return result
    }
    
    func gen() -> [String] {
        let ts = TransScale(from: dataEdges, to: plotEdges)

        var result: [String] = [ xmlTag, svgTag ]
        result.append(contentsOf: svgDefs())
        result.append(contentsOf: svgLineGroup(ts))
        if settings.title != "" { result.append(svgTitle()) }
        result.append(svgTagEnd)
        
        return result
    }
}

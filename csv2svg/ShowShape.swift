//
//  ShowShape.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-12.
//

import Foundation

func showShape(shape: String, stroke: String) -> String {
    let wh = (Defaults.strokeWidth * 6).f(0)
    let settings = try? Settings.load(settingsJson(wh))
    let csv = CSV("")
    let svg = SVG(csv, settings!)
    return svg.shapeGen(name: shape, stroke: stroke).joined(separator: "\n")
}

fileprivate func settingsJson(_ wh: String) -> String {
    return """
        {
            "height": \(wh),
            "width": \(wh)
        }
        """
}

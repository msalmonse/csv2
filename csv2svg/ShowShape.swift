//
//  ShowShape.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-12.
//

import Foundation

func showShape(shape: String) -> String {
    let settings = try? Settings.load(settingsJson)
    let csv = CSV("")
    let svg = SVG(csv, settings!)
    return svg.shapeGen(name: shape).joined(separator: "\n")
}

fileprivate let settingsJson = """
{
    "height": 50,
    "strokeWidth": 10,
    "width": 50
}
"""

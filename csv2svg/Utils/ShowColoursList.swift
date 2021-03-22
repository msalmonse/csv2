//
//  ShowColoursList.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-22.
//

import Foundation

/// Generate a shape SVG
/// - Parameters:
/// - Returns: shape SVG

func showColoursList() -> String {
    let settings = try? Settings.load(settingsJson)
    let csv = CSV("")
    let svg = SVG(csv, settings!)
    return svg.coloursListGen().joined(separator: "\n")
}

private let settingsJson = """
{
    "legends": false
}
"""

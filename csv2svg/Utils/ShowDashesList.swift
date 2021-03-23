//
//  ShowDashesList.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-23.
//

import Foundation

/// Generate a dashes list SVG
/// - Parameters:
/// - Returns: dashes list SVG

func showDashesList() -> String {
    let size = 2.5 * Defaults.baseFontSize
    let count = Defaults.colours.count + SVG.Colours.count
    let height = Double(count + 3)  * size
    let width = Defaults.baseFontSize * 20.0

    let settings = try? Settings.load(settingsJson(width, height))
    let csv = CSV("")
    let svg = SVG(csv, settings!)
    return svg.dashesListGen(size).joined(separator: "\n")
}

private func settingsJson(_ w: Double, _ h: Double) -> String {
    return """
        {
            "height": \(h.f(0)),
            "legends": false,
            "width": \(w.f(0))
        }
        """
}

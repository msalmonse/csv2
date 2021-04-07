//
//  ShowColoursList.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-22.
//

import Foundation

/// Generate a colours list SVG
/// - Parameters:
/// - Returns: colours list SVG

func showColoursList(_ defaults: Defaults) -> [String] {
    let size = 2.5 * defaults.baseFontSize
    let count = defaults.colours.count + Colours.count
    let height = Double(count + 3)  * size
    let width = defaults.baseFontSize * 20.0

    let settings = try? Settings.load(settingsJson(width, height))
    let csv = CSV("")
    let svg = SVG(settings!)
    let plot = Plot(csv, settings!, svg)
    return plot.coloursListGen(size, defaults)
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

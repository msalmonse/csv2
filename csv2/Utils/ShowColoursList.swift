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

func showColoursList(_ defaults: Defaults, namesList: Bool, with: PlotterType, to outName: String?) {
    let size = 2.5 * defaults.baseFontSize
    let colours = namesList ? ColourTranslate.all : defaults.colours + Colours.all
    let count = colours.count
    let height = Double(count + 3)  * size
    let width = defaults.baseFontSize * 30.0

    let settings = try? Settings.load(settingsJson(width, height))
    let csv = CSV("")
    let plotter = with.plotter(settings: settings!)
    let plot = Plot(csv, settings!, plotter)
    plot.coloursListGen(size, colours)
    output(plotter, to: outName)
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

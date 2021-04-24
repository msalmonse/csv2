//
//  ShowColoursList.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-22.
//

import Foundation

/// Generate colours list
/// - Parameters:
///   - defaults: image defaults
///   - namesList: generate a list of all know names?
///   - with: plotter type
///   - outName: output sink

func showColoursList(
    _ defaults: Defaults,
    namesList: Bool,
    with: PlotterType,
    to outName: String?
) {
    let rowHeight = 2.5 * defaults.baseFontSize
    let colours = namesList ? ColourTranslate.all : defaults.colours + Colours.all
    let count = Double(colours.count)
    let columnWidth = defaults.baseFontSize * 30.0

    // Calculate the number of rows to maintain a 4:3 ratio
    var rows = ceil(sqrt((3 * columnWidth * count)/(4 * rowHeight)))
    if rows > count/2.0 { rows = count }
    let cols = ceil(count/rows)

    let height =  (rows + 3) * rowHeight
    let width = (cols + 0.1) * columnWidth
    let settings = try? Settings.load(settingsJson(width, height))

    trySpecialCases(settings)

    let csv = CSV("")
    let plotter = with.plotter(settings: settings!)
    let plot = Plot(csv, settings!, plotter)
    plot.coloursListGen(rowHeight, colours, Int(rows), columnWidth)
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

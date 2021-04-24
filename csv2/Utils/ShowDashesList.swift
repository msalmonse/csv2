//
//  ShowDashesList.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-23.
//

import Foundation

/// Generate a dashes list SVG
/// - Parameters:

func showDashesList(
    _ defaults: Defaults,
    with: PlotterType,
    to outName: String?,
    _ canvasTag: Bool
) {
    let size = 2.0 * defaults.baseFontSize
    let count = defaults.dashes.count + Dashes.count
    let height = Double(count + 2) * size
    let width = defaults.baseFontSize * 20.0

    let settings = try? Settings.load(settingsJson(width, height))

    if canvasTag {
        print(Canvas.canvasTag(settings!))
        exit(0)
    }

    let csv = CSV("")
    let plotter = with.plotter(settings: settings!)
    let plot = Plot(csv, settings!, plotter)
    plot.dashesListGen(size, defaults)
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

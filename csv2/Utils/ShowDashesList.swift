//
//  ShowDashesList.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-23.
//

import Foundation

/// Generate a list of dashes
/// - Parameters:
///   - defaults: image defaults
///   - with: plotter type
///   - outName: output sink

func showDashesList(
    _ defaults: Defaults,
    with: CommandType,
    to outName: String?
) {
    let size = 2.0 * defaults.doubleValue(.baseFontSize)
    let count = defaults.stringArray(.dashes).count + Dashes.count
    let height = Double(count + 2) * size
    let width = defaults.doubleValue(.baseFontSize) * 20.0

    let settings = try? Settings.load(settingsJson(width, height))

    trySpecialCases(settings)

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

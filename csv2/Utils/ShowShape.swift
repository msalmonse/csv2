//
//  ShowShape.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-12.
//

import Foundation

/// Generate a shape SVG
/// - Parameters:
///   - shape: shape name
///   - stroke: stroke colour
/// - Returns: shape SVG

func showShape(
    shape: String,
    defaults: Defaults,
    with: PlotterType,
    to outName: String?,
    _ canvasTag: Bool
) {
    let colour = defaults.colours.first ?? "black"
    let wh = (defaults.strokeWidth * 6).f(0)

    let settings = try? Settings.load(settingsJson(wh))

    if canvasTag {
        print(Canvas.canvasTag(settings!))
        exit(0)
    }

    let csv = CSV("")
    let plotter = with.plotter(settings: settings!)
    let plot = Plot(csv, settings!, plotter)
    plot.shapeGen(name: shape, colour: colour)
    output(plotter, to: outName)
}

/// JSON text for display a shape
/// - Parameter wh: width and height
/// - Returns: JSON text

fileprivate func settingsJson(_ wh: String) -> String {
    return """
        {
            "height": \(wh),
            "legends": false,
            "width": \(wh),
            "xTick": -1,
            "yTick": -1
        }
        """
}

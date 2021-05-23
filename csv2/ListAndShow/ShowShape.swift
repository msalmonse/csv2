//
//  ShowShape.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-12.
//

import Foundation

/// Generate a shape image
/// - Parameters:
///   - shape: shape name
///   - defaults: image defaults
///   - with: plotter type
///   - outName: output sink

func showShape(
    shape: String,
    defaults: Defaults,
    with: MainCommandType,
    to outName: String?
) {
    let colour = defaults.stringArray(.colours).first ?? "black"
    let wh = (defaults.doubleValue(.strokeWidth) * 6).f(0)

    let settings = try? Settings.load(settingsJson(wh))

    let csv = CSV("")
    let plotter = with.plotter(settings: settings!)
    let plot = Plot(csv, settings!, plotter)
    plot.shapeGen(name: shape, colour: colour)
    output(plotter, to: outName)
}

/// JSON text for displaying a shape
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

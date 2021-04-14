//
//  PlotSettings.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-30.
//

import Foundation

extension Settings {
    /// Plot related settings

    struct Plot {
        // bar diagrams
        let bared: Int
        // offset between bars
        let barOffset: Double
        // width of bars
        let barWidth: Double
        // Use dashed lines
        let dashedLines: Int
        // Which plots to include
        let include: Int
        // Plots to show as scattered
        let scatterPlots: Int
        // show data points
        let showDataPoints: Int
        // distance between points
        let dataPointDistance: Double
        // Shapes to use for datapoints and scatter plots
        let shapes: [String]

        // Dash patterns
        let dashes: [String]

        // Plot classes
        let cssClasses: [String]

        // Path colours
        let colours: [String]

        // Path names
        let names: [String]

        // Force unassigned colours to black
        let black: Bool

        // use bezier curves to draw curves
        let bezier: Double

        // Smooth plots, 0.0 means no smoothing
        let smooth: Double

        // sort the x values before plotting
        let sortx: Bool
    }

    /// Create a new Plot from JSON
    /// - Parameter container: JSON container
    /// - Returns: Plot object

    static func jsonPlot(from container: KeyedDecodingContainer<CodingKeys>?, _ defaults: Defaults) -> Plot {
        return Plot(
            bared: keyedIntValue(from: container, forKey: .bared, defaults: defaults),
            barOffset: keyedDoubleValue(from: container, forKey: .barOffset, defaults: defaults),
            barWidth: keyedDoubleValue(from: container, forKey: .barWidth, defaults: defaults),
            dashedLines: keyedIntValue(from: container, forKey: .dashedLines, defaults: defaults),
            include: keyedIntValue(from: container, forKey: .include, defaults: defaults),
            scatterPlots: keyedIntValue(from: container, forKey: .scatterPlots, defaults: defaults),
            showDataPoints: keyedIntValue(from: container, forKey: .showDataPoints, defaults: defaults),
            dataPointDistance: keyedDoubleValue(from: container, forKey: .dataPointDistance, defaults: defaults),
            shapes: keyedStringArray(from: container, forKey: .shapes, defaults: defaults),
            dashes: keyedStringArray(from: container, forKey: .dashes, defaults: defaults),
            cssClasses: keyedStringArray(from: container, forKey: .cssClasses, defaults: defaults),
            colours: keyedStringArray(from: container, forKey: .colours, defaults: defaults),
            names: keyedStringArray(from: container, forKey: .names, defaults: defaults),
            black: keyedBoolValue(from: container, forKey: .black, defaults: defaults),
            bezier:
                keyedDoubleValue(from: container, forKey: .bezier, defaults: defaults, in: Defaults.bezierBounds),
            smooth:
                keyedDoubleValue(from: container, forKey: .smooth, defaults: defaults, in: Defaults.smoothBounds),
            sortx: keyedBoolValue(from: container, forKey: .sortx, defaults: defaults)
        )
    }
}

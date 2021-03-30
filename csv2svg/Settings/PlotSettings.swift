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

        // Smooth plots, 0.0 means no smoothing
        let smooth: Double

        // sort the x values before plotting
        let sortx: Bool
    }

    /// Create a new Plot from JSON
    /// - Parameter container: JSON container
    /// - Returns: Plot object

    static func jsonPlot(from container: KeyedDecodingContainer<CodingKeys>?) -> Plot {
        return Plot(
            dashedLines: keyedIntValue(from: container, forKey: .dashedLines),
            include: keyedIntValue(from: container, forKey: .include),
            scatterPlots: keyedIntValue(from: container, forKey: .scatterPlots),
            showDataPoints: keyedIntValue(from: container, forKey: .scatterPlots),
            dataPointDistance: keyedDoubleValue(from: container, forKey: .showDataPoints),
            shapes: keyedStringArray(from: container, forKey: .shapes),
            dashes: keyedStringArray(from: container, forKey: .dashes),
            cssClasses: keyedStringArray(from: container, forKey: .cssClasses),
            colours: keyedStringArray(from: container, forKey: .colours),
            names: keyedStringArray(from: container, forKey: .names),
            black: keyedBoolValue(from: container, forKey: .black),
            smooth: keyedDoubleValue(from: container, forKey: .smooth),
            sortx: keyedBoolValue(from: container, forKey: .sortx)
        )
    }
}

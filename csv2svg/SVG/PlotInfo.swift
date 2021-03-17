//
//  SVG/PlotInfo.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-10.
//

import Foundation

extension SVG {

    /// Generate a list of colours for the plots
    /// - Parameters:
    ///   - settings: settings for plot
    ///   - ct: number of plots
    /// - Returns: list of colours

    static func plotColours(
        _ settings: Settings,
        _ ct: Int,
        _ props: inout [PathProperties]
        ) {
        for i in 0..<ct {
            if i < settings.colours.count && settings.colours[i] != "" {
                props[i].colour = settings.colours[i]
            } else if settings.black {
                props[i].colour = "black"
            } else {
                props[i].colour = Colours.nextColour()
            }
        }
    }

    /// Generate a list of dashes for the plots
    /// - Parameters:
    ///   - settings: settings for plot
    ///   - ct: number of plots
    ///   - width: the plottable width
    /// - Returns: list of dashes

    static func plotDashes(
        _ settings: Settings,
        _ ct: Int,
        _ width: Double,
        _ props: inout [PathProperties]
        ) {
        for i in 0..<ct {
            if i < settings.dashes.count && settings.dashes[i] != "" {
                props[i].dash = settings.dashes[i]
            } else if props[i].dashed {
                props[i].dash = Dash.nextDash(width)
            }
        }
    }

    /// Generate a list of names for the plots
    /// - Parameters:
    ///   - settings: settings for plot
    ///   - ct: number of plots

    static func plotNames(
        _ settings: Settings,
        _ csv: CSV, _ ct: Int,
        _ props: inout [PathProperties]
    ) {
        for i in 0..<ct {
            if i < settings.names.count && settings.names[i] != "" {
                props[i].name = settings.names[i]
            } else if settings.headers > 0 {
                props[i].name = SVG.headerText(i, csv: csv, inColumns: settings.inColumns)
            } else {
                props[i].name = SVG.headerText(i, csv: nil, inColumns: settings.inColumns)
            }
        }
    }

    /// Generate a list of names for the plots
    /// - Parameters:
    ///   - settings: settings for plot
    ///   - ct: number of plots
    ///   - index: the row or column with the index
    /// - Returns: list of names

    static func plotShapes(
        _ settings: Settings,
        _ ct: Int, index: Int,
        _ props: inout [PathProperties]
        ) {
        for i in 0..<ct {
            // Don't attach a shape if we aren't a scatter plot or a plot with data points or are index
            if (props[i].scattered || props[i].pointed) && i != settings.index - 1 {
                if i < settings.shapes.count && settings.shapes[i] != "" {
                    props[i].shape = Shape.lookup(settings.shapes[i]) ?? Shape.nextShape()
                } else {
                    props[i].shape = Shape.nextShape()
                }
            }
        }
    }

    /// Calculate the flags for a plot
    /// - Parameters:
    ///   - settings: settings
    ///   - ct: number of plots
    ///   - props: properties list
    static func plotFlags(
        _ settings: Settings,
        _ ct: Int,
        _ props: inout [PathProperties]
    ) {
        for i in 0..<ct {
            let mask = 1 << i
            props[i].dashed = (settings.dashedLines & mask) == mask
            props[i].pointed = (settings.showDataPoints & mask) == mask
            props[i].scattered = (settings.scatterPlots & mask) == mask
        }
    }
}

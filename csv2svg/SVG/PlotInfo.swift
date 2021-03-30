//
//  SVG/PlotInfo.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-10.
//

import Foundation

extension SVG {

    /// Generate a list of classes for the plots
    /// - Parameters:
    ///   - settings: settings for plot
    ///   - ct: number of plots
    /// - Returns: list of colours

    static func plotClasses(
        _ settings: Settings,
        _ ct: Int,
        _ props: inout [PathProperties]
        ) {
        for i in 0..<ct {
            if i < settings.plot.cssClasses.count && !settings.plot.cssClasses[i].isEmpty {
                props[i].cssClass = settings.plot.cssClasses[i]
            } else {
                props[i].cssClass = "plot\((i + 1).d0(2))"
            }
        }
    }

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
            if i < settings.plot.colours.count && !settings.plot.colours[i].isEmpty {
                props[i].colour = settings.plot.colours[i]
            } else if settings.plot.black {
                props[i].colour = "black"
            } else if props[i].included {
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
            if i < settings.plot.dashes.count && !settings.plot.dashes[i].isEmpty {
                props[i].dash = settings.plot.dashes[i]
            } else if props[i].dashed && props[i].included {
                props[i].dash = Dashes.nextDash(width)
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
            if i < settings.plot.names.count && !settings.plot.names[i].isEmpty {
                props[i].name = settings.plot.names[i]
            } else if settings.headers > 0 && settings.nameHeader >= 0 {
                props[i].name =
                    SVG.headerText(i, csv: csv, inColumns: settings.inColumns, header: settings.nameHeader)
            } else {
                props[i].name =
                    SVG.headerText(i, csv: nil, inColumns: settings.inColumns, header: settings.nameHeader)
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
            if (props[i].scattered || props[i].pointed) && props[i].included && i != settings.index {
                if i < settings.plot.shapes.count && !settings.plot.shapes[i].isEmpty {
                    props[i].shape = Shape.lookup(settings.plot.shapes[i]) ?? Shape.nextShape()
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
        for i in 0..<min(ct, Int.bitWidth) {
            let mask = 1 << i
            props[i].dashed = settings.plot.dashedLines &== mask
            props[i].included = settings.plot.include &== mask
            props[i].pointed = settings.plot.showDataPoints &== mask
            props[i].scattered = settings.plot.scatterPlots &== mask
        }
    }
}

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
        _ props: inout [Properties]
        ) {
        for i in 0..<ct {
            if settings.plot.cssClasses.hasIndex(i) && settings.plot.cssClasses[i].hasContent {
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
        _ props: inout [Properties]
        ) {
        for i in 0..<ct {
            if i < settings.plot.colours.count && settings.plot.colours[i].hasContent {
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
        _ props: inout [Properties]
        ) {
        for i in 0..<ct {
            if settings.plot.dashes.hasIndex(i) && !settings.plot.dashes[i].isEmpty {
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
        _ props: inout [Properties]
    ) {
        for i in 0..<ct {
            if settings.plot.names.hasIndex(i) && settings.plot.names[i].hasContent {
                props[i].name = settings.plot.names[i]
            } else if settings.headers > 0 && settings.csv.nameHeader >= 0 {
                props[i].name =
                    SVG.headerText(i, csv: csv, inColumns: settings.inColumns, header: settings.csv.nameHeader)
            } else {
                props[i].name =
                    SVG.headerText(i, csv: nil, inColumns: settings.inColumns, header: settings.csv.nameHeader)
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
        _ props: inout [Properties]
        ) {
        for i in 0..<ct {
            // Don't attach a shape if we aren't a scatter plot or a plot with data points or are index
            if (props[i].scattered || props[i].pointed) && props[i].included && i != settings.csv.index {
                if settings.plot.shapes.hasIndex(i) && settings.plot.shapes[i].hasContent {
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
        _ props: inout [Properties]
    ) {
        for i in 0..<min(ct, Int.bitWidth) {
            let mask = 1 << i
            props[i].dashed = settings.plot.dashedLines &== mask
            props[i].included = settings.plot.include &== mask
            props[i].pointed = settings.plot.showDataPoints &== mask
            props[i].scattered = settings.plot.scatterPlots &== mask
        }
        // Not really a flag
        for i in props.indices { props[i].bezier = settings.plot.bezier }
    }
}

//
//  SVG/PlotInfo.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-10.
//

import Foundation

/// Generate a list of classes for the plots
/// - Parameters:
///   - settings: settings for plot
///   - first: first row or column with plot data
///   - ct: number of plots
///   - styles: properties to load

func plotClasses(
    _ settings: Settings,
    _ first: Int,
    _ ct: Int,
    _ styles: inout [Styles]
    ) {
    for i in styles.indices {
        if settings.plot.cssClasses.hasIndex(i) && settings.plot.cssClasses[i].hasContent {
            styles[i].cssClass = settings.plot.cssClasses[i]
        } else {
            styles[i].cssClass = "plot\((i + 1).d0(2))"
        }
    }
}

/// Generate a list of colours for the plots
/// - Parameters:
///   - settings: settings for plot
///   - first: first row or column with plot data
///   - ct: number of plots
///   - styles: properties to load

func plotColours(
    _ settings: Settings,
    _ first: Int,
    _ ct: Int,
    _ styles: inout [Styles]
    ) {
    for i in first..<ct {
        if i < settings.plot.colours.count && settings.plot.colours[i].hasContent {
            styles[i].colour = settings.plot.colours[i]
        } else if settings.plot.black {
            styles[i].colour = "black"
        } else if styles[i].included {
            styles[i].colour = Colours.nextColour()
        }
        styles[i].fontColour = styles[i].colour
        styles[i].fill = styles[i].colour
    }
}

/// Generate a list of dashes for the plots
/// - Parameters:
///   - settings: settings for plot
///   - first: first row or column with plot data
///   - ct: number of plots
///   - width: the plottable width
///   - styles: properties to load

func plotDashes(
    _ settings: Settings,
    _ first: Int,
    _ ct: Int,
    _ width: Double,
    _ styles: inout [Styles]
    ) {
    for i in first..<ct {
        if settings.plot.dashes.hasIndex(i) && !settings.plot.dashes[i].isEmpty {
            styles[i].dash = settings.plot.dashes[i].replacingOccurrences(of: " ", with: ",")
        } else if styles[i].dashed && styles[i].included {
            styles[i].dash = Dashes.nextDash(width)
        }
    }
}

/// Generate a list of names for the plots
/// - Parameters:
///   - settings: settings for plot
///   - csv: potential source of names
///   - first: first row or column with plot data
///   - ct: number of plots
///   - styles: properties to load

func plotNames(
    _ settings: Settings,
    _ csv: CSV,
    _ first: Int,
    _ ct: Int,
    _ styles: inout [Styles]
) {
    for i in first..<ct {
        if settings.plot.names.hasIndex(i) && settings.plot.names[i].hasContent {
            styles[i].name = settings.plot.names[i]
        } else if settings.headers > 0 && settings.csv.nameHeader >= 0 {
            styles[i].name =
                csv.headerText(i, inColumns: settings.inColumns, header: settings.csv.nameHeader)
        } else {
            styles[i].name =
                csv.headerText(i, inColumns: settings.inColumns, header: settings.csv.nameHeader)
        }
    }
}

/// Generate a list of names for the plots
/// - Parameters:
///   - settings: settings for plot
///   - first: first row or column with plot data
///   - ct: number of plots
///   - index: the row or column with the index
///   - styles: properties to load

func plotShapes(
    _ settings: Settings,
    _ first: Int,
    _ ct: Int,
    index: Int,
    _ styles: inout [Styles]
    ) {
    for i in first..<ct {
        // Don't attach a shape if we aren't a scatter plot or a plot with data points or are index
        if (styles[i].scattered || styles[i].pointed) && styles[i].included && i != settings.csv.index {
            if settings.plot.shapes.hasIndex(i) && settings.plot.shapes[i].hasContent {
                styles[i].shape = Shape.lookup(settings.plot.shapes[i]) ?? Shape.nextShape()
            } else {
                styles[i].shape = Shape.nextShape()
            }
        }
    }
}

/// Calculate the flags for a plot
/// - Parameters:
///   - settings: settings
///   - first: first row or column with plot data
///   - ct: number of plots
///   - styles: properties list

func plotFlags(
    _ settings: Settings,
    _ first: Int,
    _ ct: Int,
    _ styles: inout [Styles]
) {
    for i in first..<min(ct, Int.bitWidth) {
        let mask = 1 << i
        styles[i].dashed = settings.plot.dashedLines &== mask
        styles[i].included = settings.plot.include &== mask
        styles[i].pointed = settings.plot.showDataPoints &== mask
        styles[i].scattered = settings.plot.scatterPlots &== mask
        if settings.plot.bared &== mask { styles[i].bar = Bar.next }
    }
}

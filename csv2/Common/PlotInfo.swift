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
///   - props: properties to load

func plotClasses(
    _ settings: Settings,
    _ first: Int,
    _ ct: Int,
    _ props: inout [Properties]
    ) {
    for i in first..<ct {
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
///   - first: first row or column with plot data
///   - ct: number of plots
///   - props: properties to load

func plotColours(
    _ settings: Settings,
    _ first: Int,
    _ ct: Int,
    _ props: inout [Properties]
    ) {
    for i in first..<ct {
        if i < settings.plot.colours.count && settings.plot.colours[i].hasContent {
            props[i].colour = settings.plot.colours[i]
        } else if settings.plot.black {
            props[i].colour = "black"
        } else if props[i].included {
            props[i].colour = Colours.nextColour()
        }
        props[i].fontColour = props[i].colour
        props[i].fill = props[i].colour
    }
}

/// Generate a list of dashes for the plots
/// - Parameters:
///   - settings: settings for plot
///   - first: first row or column with plot data
///   - ct: number of plots
///   - width: the plottable width
///   - props: properties to load

func plotDashes(
    _ settings: Settings,
    _ first: Int,
    _ ct: Int,
    _ width: Double,
    _ props: inout [Properties]
    ) {
    for i in first..<ct {
        if settings.plot.dashes.hasIndex(i) && !settings.plot.dashes[i].isEmpty {
            props[i].dash = settings.plot.dashes[i].replacingOccurrences(of: " ", with: ",")
        } else if props[i].dashed && props[i].included {
            props[i].dash = Dashes.nextDash(width)
        }
    }
}

/// Generate a list of names for the plots
/// - Parameters:
///   - settings: settings for plot
///   - csv: potential source of names
///   - first: first row or column with plot data
///   - ct: number of plots
///   - props: properties to load

func plotNames(
    _ settings: Settings,
    _ csv: CSV,
    _ first: Int,
    _ ct: Int,
    _ props: inout [Properties]
) {
    for i in first..<ct {
        if settings.plot.names.hasIndex(i) && settings.plot.names[i].hasContent {
            props[i].name = settings.plot.names[i]
        } else if settings.headers > 0 && settings.csv.nameHeader >= 0 {
            props[i].name =
                csv.headerText(i, inColumns: settings.inColumns, header: settings.csv.nameHeader)
        } else {
            props[i].name =
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
///   - props: properties to load

func plotShapes(
    _ settings: Settings,
    _ first: Int,
    _ ct: Int,
    index: Int,
    _ props: inout [Properties]
    ) {
    for i in first..<ct {
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
///   - first: first row or column with plot data
///   - ct: number of plots
///   - props: properties list

func plotFlags(
    _ settings: Settings,
    _ first: Int,
    _ ct: Int,
    _ props: inout [Properties]
) {
    for i in first..<min(ct, Int.bitWidth) {
        let mask = 1 << i
        props[i].dashed = settings.plot.dashedLines &== mask
        props[i].included = settings.plot.include &== mask
        props[i].pointed = settings.plot.showDataPoints &== mask
        props[i].scattered = settings.plot.scatterPlots &== mask
        if settings.plot.bared &== mask { props[i].bar = Bar.next }
    }

    // Not really flags
    for i in props.indices {
        props[i].bold = settings.css.bold
        props[i].bezier = settings.plot.bezier
        props[i].fontFamily = settings.css.fontFamily
        props[i].italic = settings.css.italic
    }
}

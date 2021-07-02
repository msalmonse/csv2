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
    let cssClasses = settings.stringArray(.cssClasses, in: .svg)
    for i in styles.indices {
        if cssClasses.hasIndex(i) && cssClasses[i].hasContent {
            styles[i].cssClass = cssClasses[i]
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
    let colours = settings.colourArray(.colours) ?? []
    let black = settings.boolValue(.black)
    for i in first..<ct {
        if colours.hasIndex(i) {
            styles[i].colour = colours[i]
        } else if black {
            styles[i].colour = .black
        } else if styles[i].options[.included] {
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
    let dashes = settings.stringArray(.dashes)
    for i in first..<ct {
        if dashes.hasIndex(i) && !dashes[i].isEmpty {
            styles[i].dash = dashes[i].replacingOccurrences(of: " ", with: ",")
        } else if styles[i].options.isAll(of: [.dashed, .included]) {
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
    let inRows = settings.boolValue(.rowGrouping)
    let nameHeader = settings.intValue(.nameHeader)
    let nameInRows = settings.chartType.nameInRows()
    let names = settings.stringArray(.names)
    let headers = settings.intValue(nameInRows ? .headerRows : .headerColumns)

    // Row or column name
    func rcName(_ num: Int) -> String {

        let rc = inRows ? "Row" : "Column"
        return "\(rc) \(num.d(1))"
    }

    for i in first..<ct {
        if names.hasIndex(i) && names[i].hasContent {
            styles[i].name = names[i]
        } else if headers > 0 && nameHeader >= 0 {
            styles[i].name = nameInRows
                ? csv.columnHeader(i, header: nameHeader) ?? rcName(i + 1)
                : csv.rowHeader(i, header: nameHeader) ?? rcName(i + 1)
        } else {
            styles[i].name = rcName(i + 1)
        }
    }
}

/// Generate a list of shapes for the plots
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
    let shapes = settings.stringArray(.shapes)
    // Hop over not included and index plots
    for i in first..<ct where i != index || !styles[i].options[.included] {
        // Only attach a shape if we are a scatter plot or a plot with data points
        if styles[i].options.isAny(of: [.scattered, .pointed]) {
            if shapes.hasIndex(i) && shapes[i].hasContent {
                styles[i].shape = Shape.lookup(shapes[i]) ?? Shape.nextShape()
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
    _ styles: inout [Styles],
    _ stackBar: inout Int
) {
    let bared = settings.bitmapValue(.bared)
    let dashedLines = settings.bitmapValue(.dashedLines)
    let filled = settings.bitmapValue(.filled)
    let include = settings.bitmapValue(.include)
    let pointed = settings.bitmapValue(.showDataPoints)
    let scattered = settings.bitmapValue(.scatterPlots)
    let stacked = settings.bitmapValue(.stackedPlots)

    if stacked != BitMap.none {
        stackBar = Bar.next
    }

    for i in first..<min(ct, Int.bitWidth) {
        styles[i].options[.dashed] = dashedLines[i]
        styles[i].options[.filled] = filled[i]
        styles[i].options[.included] = include[i]
        styles[i].options[.pointed] = pointed[i]
        styles[i].options[.scattered] = scattered[i]
        styles[i].options[.stacked] = stacked[i]
        if bared[i] { styles[i].bar = Bar.next }
    }
}

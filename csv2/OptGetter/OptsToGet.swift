//
//  OptsToGet.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-19.
//

import Foundation
import OptGetter

extension Options {
    static internal let canvasOpts: OptsToGet = [
        OptToGet(.canvas, 1...1, usage: "Canvas name", argTag: "<name>")
    ]

    static internal let svgOpts: OptsToGet = [
        OptToGet(.css, 1...1, usage: "Include file for css styling", argTag: "<file>"),
        OptToGet(.cssid, 1...1, usage: "CSS id for SVG", argTag: "<name>"),
        OptToGet(.hover, usage: "Don't add CSS code to emphasize hovered plots"),
        OptToGet(.svg, 1...1, usage: "Include file for svg elements", argTag: "<file>")
    ]

    static internal let commonOpts: OptsToGet = [
        OptToGet(.bared, 1...1, options: [.includeMinus], usage: "Plots to show as bars", argTag: "<bitmap¹>"),
        OptToGet(.baroffset, 1...1, usage: "Bar offset (-1 to calculate)", argTag: "<offset>"),
        OptToGet(.barwidth, 1...1, usage: "Bar width (-1 to calculate)"),
        OptToGet(.bg, 1...1, usage: "Background colour", argTag: "<colour>"),
        OptToGet(.bezier, 1...1, usage: "Bézier curve smoothing, 0 means none", argTag: "<n>"),
        OptToGet(.black, usage: "Set undefined colours to black"),
        OptToGet(.bold, usage: "Set font-weight to bold"),
        OptToGet(.colours, 1...255, options: [.multi], usage: "Colours to use for plots", argTag: "<colour>..."),
        OptToGet(.dashed, 1...1, options: [.includeMinus], usage: "Plots with dashed lines", argTag: "<bitmap¹>"),
        OptToGet(.dashes, 1...255, usage: "List of plot dash patterns to use", argTag: "<n,n...>..."),
        OptToGet(.debug, short: "d", 1...1, usage: "Add debug info", argTag: "<bitmap¹>"),
        OptToGet(.distance, 1...1, usage: "Minimum distance between data points", argTag: "<n>"),
        OptToGet(.draft, 0...1, usage: "Mark the chart as a draft, argument sets the text", argTag: "[text]"),
        OptToGet(.filled, 1...1, options: [.includeMinus], usage: "Plots to show filled", argTag: "<bitmap¹>"),
        OptToGet(.font, 1...1, usage: "Font family", argTag: "<font name>"),
        OptToGet(.fg, 1...1, usage: "Foreground colour for non-text items", argTag: "<colour>"),
        OptToGet(.headers, 1...1, usage: "Header rows or columns", argTag: "<n>"),
        OptToGet(.height, 1...1, usage: "Chart height", argTag: "<n>"),
        OptToGet(.index, 1...1, usage: "Index row or column", argTag: "<n>"),
        OptToGet(.italic, usage: "Use an italic font"),
        OptToGet(
            .include, 1...1, options: [.includeMinus],
            usage: "Plots to include, default all", argTag: "<bitmap¹>"
        ),
        OptToGet(.logo, 1...1, usage: "Image URL for top right corner", argTag: "<url>"),
        OptToGet(.logx, usage: "Set abcissa to log"),
        OptToGet(.logy, usage: "Set ordinate to log"),
        OptToGet(.nameheader, 1...1, usage: "Plot name row or column", argTag: "<n>"),
        OptToGet(.names, 1...255, usage: "List of plot names", argTag: "<name>..."),
        OptToGet(.bounds, usage: "Don't check options for bounds"),
        OptToGet(.comment, usage: "Don't add csv2 comment to plot"),
        OptToGet(.legends, usage: "Don't include plot names, colours, dashes and shapes"),
        OptToGet(.opacity, 1...1, usage: "Opacity for plots"),
        OptToGet(.pie, usage: "Generate a pie chart"),
        OptToGet(
            .random, 1...3, options: [.includeMinus],
            usage: "Generate a random SVG with: #plots [max value [min value]]", argTag: "<n [n [n]]>"
        ),
        OptToGet(
            .reserve, 1...4,
            usage: "Reserved space on the left [top [right [bottom]]]", argTag: "<n [n [n [n]]]>"
        ),
        OptToGet(.rows, usage: "Group data by rows"),
        OptToGet(
            .scattered, 1...1, options: [.includeMinus],
            usage: "Plots to show as scatter plots", argTag: "<bitmap¹>"
        ),
        OptToGet(.semi, usage: "Use semicolons to seperate columns"),
        OptToGet(.shapes, 1...255, usage: "List of shapes to use", argTag: "<shape>..."),
        OptToGet(
            .showpoints, 1...1, options: [.includeMinus],
            usage: "Data plots with points", argTag: "<bitmap¹>"
        ),
        OptToGet(.size, 1...1, usage: "Base font size", argTag: "<n>"),
        OptToGet(.smooth, 1...1, usage: "EMA smoothing, 0 means none", argTag: "<n>"),
        OptToGet(.sortx, usage: "Sort points by the x values before plotting"),
        OptToGet(.stroke, 1...1, usage: "Stroke width", argTag: "<n>"),
        OptToGet(.subheader, 1...1, usage: "Sub-title row or column source", argTag: "<n>"),
        OptToGet(.subtitle, 1...1, usage: "Sub-title", argTag: "<text>"),
        OptToGet(.textcolour, 1...1, usage: "Foreground text colour", argTag: "<colour>"),
        OptToGet(.title, 1...1, usage: "Chart title", argTag: "<text>"),
        OptToGet(.tsv, usage: "Use tabs to seperate columns"),
        OptToGet(.verbose, usage: "Add extra information"),
        OptToGet(.width, 1...1, usage: "Chart width", argTag: "<n>"),
        OptToGet(.xmax, 1...1, usage: "Abscissa maximum", argTag: "<n>"),
        OptToGet(.xmin, 1...1, usage: "Abscissa minimum", argTag: "<n>"),
        OptToGet(.xtags, 1...1, usage: "Row or column with abscissa tags", argTag: "<n>"),
        OptToGet(.xtick, 1...1, usage: "Distance between abcissa ticks", argTag: "<n>"),
        OptToGet(.ymax, 1...1, usage: "Ordinate maximum", argTag: "<n>"),
        OptToGet(.ymin, 1...1, usage: "Ordinate minimum", argTag: "<n>"),
        OptToGet(.ytick, 1...1, usage: "Distance between ordinate ticks", argTag: "<n>"),
        OptToGet(long: "help", options: [.hidden], tag: Key.help),
        OptToGet(long: "?", options: [.hidden], tag: Key.help)
    ]

    static internal let positionalOpts: OptsToGet = [
        OptToGet(usage: "CSV data file name or - for stdin", argTag: "<csv file>"),
        OptToGet(usage: "JSON settings file name", argTag: "<json file>"),
        OptToGet(usage: "Output file name,\nuse stdout if omitted for canvas and svg", argTag: "<output file>")
    ]
}

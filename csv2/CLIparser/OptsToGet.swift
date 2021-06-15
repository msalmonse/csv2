//
//  OptsToGet.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-19.
//

import Foundation
import CLIparser

extension Options {
    static internal let canvasOpts: OptsToGet = [
        OptToGet(
            .stringValue(key: .canvasID, name: "canvas"), .single,
            usage: "Canvas name", argTag: "<name>"
        ),
        OptToGet(
            .stringValue(key: .tagFile, name: "tag"), .single, options: [.hidden],
            usage: "File to write canvas tag to", argTag: "<file>"
        )
    ]

    static internal let helpOpts: OptsToGet = [
        OptToGet(
            .intSpecial(key: .indent, name: "indent"), .single,
            usage: "Indent for option usage", argTag: "<n>"
        ),
        OptToGet(
            .intSpecial(key: .left, name: "left"), .single,
            usage: "Left margin for help text", argTag: "<n>"
        ),
        OptToGet(.boolSpecial(key: .md, name: "md"), options: [.hidden]),
        OptToGet(
            .intSpecial(key: .right, name: "right"), .single,
            usage: "Right margin for text", argTag: "<n>"
        ),
        OptToGet(
            .intSpecial(key: .usage, name: "usage"), .single,
            usage: "Left margin for option usage", argTag: "<n>"
        )
    ]

    static internal let pdfOpts: OptsToGet = [
        OptToGet(
            .stringValue(key: .tagFile, name: "tag"), .single, options: [.hidden],
            usage: "File to write pdf object tag to", argTag: "<file>"
        )
    ]

    static internal let svgOpts: OptsToGet = [
        OptToGet(
            .stringValue(key: .cssInclude, name: "css"), .single,
            usage: "Include file for css styling", argTag: "<file>"
        ),
        OptToGet(
            .stringValue(key: .cssID, name: "cssid"), .single,
            usage: "CSS id for <SVG> tag", argTag: "<id>"
        ),
        OptToGet(
            .boolValue(key: .hover, name: "hover"), options: [.flag],
            usage: "Add CSS code to emphasize hovered plots, nohover to not add"
        ),
        OptToGet(
            .stringValue(key: .svgInclude, name: "svg"), .single,
            usage: "Include file for svg elements", argTag: "<file>"
        )
    ]

    static internal let commonOpts: OptsToGet = [
        OptToGet(
            .bitmapValue(key: .bared, name: "bared"), .onePlus, options: [.includeMinus],
            usage: "Plots to show as bars", argTag: "<bitmap¹>"
        ),
        OptToGet(
            .doubleValue(key: .barOffset, name: "baroffset"), .single,
            usage: "Bar offset (-1 to calculate)", argTag: "<offset>"
        ),
        OptToGet(
            .doubleValue(key: .barWidth, name: "barwidth"), .single,
            usage: "Bar width (-1 to calculate)"
        ),
        OptToGet(
            .colourValue(key: .backgroundColour, name: "bg"), .single,
            usage: "Background colour", argTag: "<colour>"
        ),
        OptToGet(
            .doubleValue(key: .bezier, name: "bezier"), .single,
            usage: "Bézier curve smoothing, 0 means none", argTag: "<n>"
        ),
        OptToGet(
            .boolValue(key: .black, name: "black"),
            usage: "Set undefined colours to black"
        ),
        OptToGet(
            .boolValue(key: .bold, name: "bold"),
            usage: "Set font-weight to bold"
        ),
        OptToGet(
            .boolValue(key: .bounded, name: "bounds"), options: [.flag],
            usage: "Check options for bounds, nobounds to not check"
        ),
        OptToGet(
            .stringValue(key: .chartType, name: "chart"), .single,
            usage: """
                The type of chart:
                horizontal - index values horizontal and plot values vertical,
                pie - a grid of pie chart plots or,
                vertical - a list of values, like a bar chart only vertical.
                A unique prefix is sufficient.
                """,
                argTag: "<type>"
        ),
        OptToGet(
            .colourArray(key: .colours, name: "colours"), aka: ["colors"], .onePlus, options: [.multi],
            usage: "Colours to use for plots", argTag: "<colour>..."
        ),
        OptToGet(
            .boolValue(key: .comment, name: "comment"), options: [.flag],
            usage: "Add csv2 comment to plot, nocomment to not add"
        ),
        OptToGet(
            .bitmapValue(key: .dashedLines, name: "dashed"), .onePlus, options: [.includeMinus],
            usage: "Plots with dashed lines", argTag: "<bitmap¹>"
        ),
        OptToGet(
            .stringArray(key: .dashes, name: "dashes"), .onePlus,
            usage: "List of plot dash patterns to use", argTag: "<n,n...>..."
        ),
        OptToGet(
            .intSpecial(key: .debug, name: "debug"), .single,
            usage: "Add debug info", argTag: "<bitmap¹>"
        ),
        OptToGet(
            .doubleValue(key: .dataPointDistance, name: "distance"), .single,
            usage: "Minimum distance between data points", argTag: "<n>"
        ),
        OptToGet(
            .stringSpecial(key: .draft, name: "draft"), 0...1,
            usage: "Mark the chart as a draft,\nthe optional argument sets the text", argTag: "[text]"
        ),
        OptToGet(
            .bitmapValue(key: .filled, name: "filled"), .onePlus, options: [.includeMinus],
            usage: "Plots to show filled", argTag: "<bitmap¹>"
        ),
        OptToGet(
            .stringValue(key: .fontFamily, name: "font"), .single,
            usage: "Font family", argTag: "<font name>"
        ),
        OptToGet(
            .colourValue(key: .foregroundColour, name: "fg"), .single,
            usage: "Foreground colour for non-text items", argTag: "<colour>"
        ),
        OptToGet(
            .intSpecial(key: .headers, name: "headers"), .single,
            usage: "Header rows or columns", argTag: "<n>"
        ),
        OptToGet(
            .intValue(key: .height, name: "height"), .single,
            usage: "Chart height", argTag: "<n>"
        ),
        OptToGet(
            .bitmapValue(key: .include, name: "include"), .onePlus, options: [.includeMinus],
            usage: "Plots to include, default all", argTag: "<bitmap¹>"
        ),
        OptToGet(
            .intValue(key: .index, name: "index"), .single,
            usage: "Index row or column", argTag: "<n>"
        ),
        OptToGet(
            .boolValue(key: .italic, name: "italic"),
            usage: "Use an italic font"
        ),
        OptToGet(
            .boolValue(key: .legends, name: "legends"), options: [.flag],
            usage: "Show plot names, colours, dashes and shapes, nolegends to not"
        ),
        OptToGet(
            .stringValue(key: .logoURL, name: "logo"), .single,
            usage: "Image URL for top right corner", argTag: "<url>"
        ),
        OptToGet(
            .boolValue(key: .logx, name: "logx"),
            usage: "Set abcissa to log"
        ),
        OptToGet(
            .boolValue(key: .logy, name: "logy"),
            usage: "Set ordinate to log"
        ),
        OptToGet(
            .intValue(key: .nameHeader, name: "nameheader"), .single,
            usage: "Plot name row or column", argTag: "<n>"
        ),
        OptToGet(
            .stringArray(key: .names, name: "names"), .onePlus,
            usage: "List of plot names", argTag: "<name>..."
        ),
        OptToGet(
            .doubleValue(key: .opacity, name: "opacity"), .single,
            usage: "Opacity for plots"
        ),
        OptToGet(
            .intSpecialArray(key: .random, name: "random"), 1...3, options: [.includeMinus],
            usage: "Generate a random SVG with:\n#plots [max value [min value]]", argTag: "<n [n [n]]>"
        ),
        OptToGet(
            .doubleSpecialArray(key: .reserve, name: "reserve"), 1...4,
            usage: "Reserved space on the left [top [right [bottom]]]", argTag: "<n [n [n [n]]]>"
        ),
        OptToGet(
            .boolValue(key: .rowGrouping, name: "rows"),
            usage: "Group data by rows"
        ),
        OptToGet(
            .bitmapValue(key: .scatterPlots, name: "scattered"), .onePlus, options: [.includeMinus],
            usage: "Plots to show as scatter plots", argTag: "<bitmap¹>"
        ),
        OptToGet(
            .boolSpecial(key: .semi, name: "semi"),
            usage: "Use semicolons to separate columns"
        ),
        OptToGet(
            .stringArray(key: .shapes, name: "shapes"), .onePlus,
            usage: "List of shapes to use", argTag: "<shape>..."
        ),
        OptToGet(
            .bitmapValue(key: .showDataPoints, name: "showpoints"), .onePlus, options: [.includeMinus],
            usage: "Data plots with points", argTag: "<bitmap¹>"
        ),
        OptToGet(
            .doubleValue(key: .baseFontSize, name: "size"), .single,
            usage: "Base font size", argTag: "<n>"
        ),
        OptToGet(
            .doubleValue(key: .smooth, name: "smooth"), .single,
            usage: "EMA smoothing, 0 means none", argTag: "<n>"
        ),
        OptToGet(
            .boolValue(key: .sortx, name: "sortx"),
            usage: "Sort points by the x values before plotting"
        ),
        OptToGet(
            .doubleValue(key: .strokeWidth, name: "stroke"), .single,
            usage: "Stroke width", argTag: "<n>"
        ),
        OptToGet(
            .intValue(key: .subTitleHeader, name: "subheader"), .single,
            usage: "Sub-title row or column source", argTag: "<n>"
        ),
        OptToGet(
            .stringValue(key: .subTitle, name: "subtitle"), .single,
            usage: "Sub-title", argTag: "<text>"
        ),
        OptToGet(
            .colourValue(key: .textcolour, name: "textcolour"), aka: ["textcolor"], .single,
            usage: "Foreground text colour", argTag: "<colour>"
        ),
        OptToGet(
            .stringValue(key: .title, name: "title"), .single,
            usage: "Chart title", argTag: "<text>"
        ),
        OptToGet(
            .boolSpecial(key: .tsv, name: "tsv"),
            usage: "Use tabs to seperate columns"
        ),
        OptToGet(
            .boolSpecial(key: .verbose, name: "verbose"),
            usage: "Add extra information"
        ),
        OptToGet(
            .intValue(key: .width, name: "width"), .single,
            usage: "Chart width", argTag: "<n>"
        ),
        OptToGet(
            .doubleValue(key: .xMax, name: "xmax"), .single,
            usage: "Abscissa maximum", argTag: "<n>"
        ),
        OptToGet(
            .doubleValue(key: .xMin, name: "xmin"), .single,
            usage: "Abscissa minimum", argTag: "<n>"
        ),
        OptToGet(
            .intValue(key: .xTags, name: "xtags"), .single,
            usage: "Row or column with abscissa tags", argTag: "<n>"
        ),
        OptToGet(
            .doubleValue(key: .xTick, name: "xtick"), .single,
            usage: "Distance between abcissa ticks", argTag: "<n>"
        ),
        OptToGet(
            .doubleValue(key: .yMax, name: "ymax"), .single,
            usage: "Ordinate maximum", argTag: "<n>"
        ),
        OptToGet(
            .doubleValue(key: .yMin, name: "ymin"), .single,
            usage: "Ordinate minimum", argTag: "<n>"
        ),
        OptToGet(
            .doubleValue(key: .yTick, name: "ytick"), .single,
            usage: "Distance between ordinate ticks", argTag: "<n>"
        ),
        OptToGet(.boolSpecial(key: .help, name: "help"), options: [.hidden]),
        OptToGet(.boolSpecial(key: .help, name: "?"), options: [.hidden])
    ]

    static internal let positionalOpts: OptsToGet = [
        OptToGet(usage: "CSV data file name or - for stdin", argTag: "<csv file>"),
        OptToGet(usage: "JSON settings file name", argTag: "<json file>"),
        OptToGet(usage: "Output file name,\nor stdout if omitted for canvas and svg", argTag: "<output file>")
    ]
}

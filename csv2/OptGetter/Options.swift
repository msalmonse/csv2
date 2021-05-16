//
//  Options.swift
//  csv2
//
//  Created by Michael Salmon on 2021-03-08.
//

import Foundation
import OptGetter

private let canvasOpts: [OptToGet] = [
    OptToGet(.canvas, 1...1, usage: "Canvas name", argTag: "<name>"),
    OptToGet(.canvastag, usage: "Print the canvas tag")
]

private let svgOpts: [OptToGet] = [
    OptToGet(.css, 1...1, usage: "Include file for css styling", argTag: "<file>"),
    OptToGet(.cssid, 1...1, usage: "CSS id for SVG", argTag: "<name>"),
    OptToGet(.hover, usage: "Don't add CSS code to emphasize hovered plots"),
    OptToGet(.svg, 1...1, usage: "Include file for svg elements", argTag: "<file>")
]

private let opts: [OptToGet] = [
    OptToGet(.bared, 1...1, options: [.minusOK], usage: "Plots to show as bars", argTag: "<bitmap>"),
    OptToGet(.baroffset, 1...1, usage: "Bar offset (-1 to calculate)", argTag: "<offset>"),
    OptToGet(.barwidth, 1...1, usage: "Bar width (-1 to calculate)"),
    OptToGet(.bg, 1...1, usage: "Background colour", argTag: "<colour>"),
    OptToGet(.bitmap, 1...32, usage: "Convert a list of rows or columns to a bitmap", argTag: "<n>..."),
    OptToGet(.bezier, 1...1, usage: "Bézier curve smoothing, 0 means none", argTag: "<n>"),
    OptToGet(.black, usage: "Set undefined colours to black"),
    OptToGet(.bold, usage: "Set font-weight to bold"),
    OptToGet(.colourslist, usage: "Generate an image with all the colours on it"),
    OptToGet(.colournames, usage: "Print a list of all the colour names on it"),
    OptToGet(.colournameslist, usage: "Generate an image with all the colour names on it"),
    OptToGet(.colours, 1...255, options: [.multi], usage: "Colours to use for plots", argTag: "<colour>..."),
    OptToGet(.dashed, 1...1, options: [.minusOK], usage: "Plots with dashed lines", argTag: "<bitmap>"),
    OptToGet(.dashes, 1...255, usage: "List of plot dash patterns to use", argTag: "<n,n...>..."),
    OptToGet(.dasheslist, usage: "Generate an image with all the dashes on it"),
    OptToGet(.debug, short: "d", 1...1, usage: "Add debug info", argTag: "<bitmap>"),
    OptToGet(.distance, 1...1, usage: "Minimum distance between data points", argTag: "<n>"),
    OptToGet(.filled, 1...1, options: [.minusOK], usage: "Plots to show filled", argTag: "<bitmap>"),
    OptToGet(.font, 1...1, usage: "Font family", argTag: "<font name>"),
    OptToGet(.fg, 1...1, usage: "Colour for non-text items", argTag: "<colour>"),
    OptToGet(.headers, 1...1, usage: "Header rows or columns", argTag: "<n>"),
    OptToGet(.height, 1...1, usage: "chart height", argTag: "<n>"),
    OptToGet(.index, 1...1, usage: "Index row or column", argTag: "<n>"),
    OptToGet(.italic, usage: "Use an italic font"),
    OptToGet(.include, 1...1, options: [.minusOK], usage: "Plots to include, default all", argTag: "<bitmap>"),
    OptToGet(.logo, 1...1, usage: "Image URL for top right corner", argTag: "<url>"),
    OptToGet(.logx, usage: "Set abcissa to log"),
    OptToGet(
        long: "logy", tag: Options.Key.logy,
        usage: "Set ordinate to log"
    ),
    OptToGet(
        long: "nameheader", 1...1, tag: Options.Key.nameheader,
        usage: "Plot name row or column", argTag: "<n>"
    ),
    OptToGet(
        long: "names", 1...255, tag: Options.Key.names,
        usage: "List of plot names", argTag: "<name>..."
    ),
    OptToGet(
        long: "nobounds", tag: Options.Key.bounds,
        usage: "Don't check options for bounds"
    ),
    OptToGet(
        long: "nocomment", tag: Options.Key.comment,
        usage: "Don't add csv2 comment to plot"
    ),
    OptToGet(
        long: "nolegends", tag: Options.Key.legends,
        usage: "Don't include plot names, colours, dashes and shapes"
    ),
    OptToGet(
        long: "opacity", tag: Options.Key.opacity,
        usage: "Opacity for plots"
    ),
    OptToGet(
        long: "pie", tag: Options.Key.pie,
        usage: "Generate a pie chart"
    ),
    OptToGet(
        long: "random", 1...3, options: [.minusOK], tag: Options.Key.random,
        usage: "Generate a random SVG with: #plots [max value [min value]]", argTag: "<n [n [n]]>"
    ),
    OptToGet(
        long: "reserve", 1...4, tag: Options.Key.reserve,
        usage: "Reserved space on the left [top [right [bottom]]]", argTag: "<n [n [n [n]]]>"
    ),
    OptToGet(
        long: "rows", tag: Options.Key.rows,
        usage: "Group data by rows"
    ),
    OptToGet(
        long: "scattered", 1...1, options: [.minusOK], tag: Options.Key.scattered,
        usage: "Plots to show as scatter plots", argTag: "<bitmap>"
    ),
    OptToGet(
        long: "semi", tag: Options.Key.semi,
        usage: "Use semicolons to seperate columns"
    ),
    OptToGet(
        long: "shapes", 1...255,  tag: Options.Key.shapes,
        usage: "List of shapes to use", argTag: "<shape>..."
    ),
    OptToGet(
        long: "shapenames", tag: Options.Key.shapenames,
        usage: "Print a list of shape names"
    ),
    OptToGet(
        long: "show", 1...1, tag: Options.Key.show,
        usage: "Generate a plot with just the named shape @ 6X strokewidth", argTag: "<shape>"
    ),
    OptToGet(
        long: "showpoints",  tag: Options.Key.showpoints
    )
]

struct Options {
    var svg = Defaults.global.svgInclude
    var bared = Defaults.global.bared
    var baroffset = Defaults.global.barOffset
    var barwidth = Defaults.global.barWidth
    var bg = Defaults.global.backgroundColour
    var bitmap: [Int] = []
    var bezier = Defaults.global.bezier
    var black = Defaults.global.black
    var bold = Defaults.global.bold
    var bounds = false
    var canvas = Defaults.global.canvasID
    var canvastag = false
    var colourslist = false
    var colournames = false
    var colournameslist = false
    var colours: [String] = []
    var css = Defaults.global.cssInclude
    var cssid = Defaults.global.cssID
    var dashed = Defaults.global.dashedLines
    var dashes: [String] = []
    var dasheslist = false
    var debug = 0
    var distance = Defaults.global.dataPointDistance
    var filled = Defaults.global.filled
    var font = Defaults.global.fontFamily
    var fg = Defaults.global.foregroundColour
    var headers = Defaults.global.headers
    var height = Defaults.global.height
    var hover = Defaults.global.hover
    var index = Defaults.global.index
    var italic = Defaults.global.italic
    var include = Defaults.global.include
    var logo = Defaults.global.logoURL
    var logx = Defaults.global.logx
    var logy = Defaults.global.logy
    var nameheader = Defaults.global.nameHeader
    var names: [String] = []
    var nocomment = !Defaults.global.comment
    var nolegends = !Defaults.global.legends
    var opacity = Defaults.global.opacity
    var pie = false
    var random: [Int] = []
    var reserve = [
        Defaults.global.reserveLeft,
        Defaults.global.reserveTop,
        Defaults.global.reserveRight,
        Defaults.global.reserveBottom
    ]
    var scattered = Defaults.global.scattered
    var semi = false
    var shapes: [String] = []
    var shapenames = false
    var show: String = ""

    @Option(name: .long, help: "Data plots with points")
    var showpoints = Defaults.global.showDataPoints

    @Option(name: .long, help: "Base font size")
    var size = Defaults.global.baseFontSize

    @Option(name: .long, help: "EMA smoothing, 0 means none")
    var smooth = Defaults.global.smooth

    @Flag(name: .long, help: "Sort points by the x values before plotting")
    var sortx = Defaults.global.sortx

    @Option(name: .long, help: "Stroke width")
    var stroke = Defaults.global.strokeWidth

    @Option(name: .long, help: "Sub-title row or column source")
    var subheader = Defaults.global.index

    @Option(name: .long, help: "Sub-title")
    var subtitle: String = ""

    @Option(name: .long, help: "Text colour")
    var textcolour = Defaults.global.textColour

    @Option(name: .long, help: "Title")
    var title: String = ""

    @Flag(name: .shortAndLong, help: "Use tabs to seperate columns")
    var tsv = false

    @Flag(name: .shortAndLong, help: "Add extra information")
    var verbose = false

    @Flag(name: [.customShort("V"), .long], help: "Display version and exit")
    var version = false

    @Option(name: .long, help: "SVG/Canvas width")
    var width = Defaults.global.width

    @Option(name: .long, help: "Default abscissa maximum")
    var xmax = Defaults.global.xMax

    @Option(name: .long, help: "Default abscissa minimum")
    var xmin = Defaults.global.xMin

    @Option(name: .long, help: "Tag row or column")
    var xtags = Defaults.global.xTagsHeader

    @Option(name: .long, help: "Default x tick")
    var xtick = Defaults.global.xTick

    @Option(name: .long, help: "Default ordinate maximum")
    var ymax = Defaults.global.yMax

    @Option(name: .long, help: "Default ordinate minimum")
    var ymin = Defaults.global.yMin

    @Option(name: .long, help: "Default y tick")
    var ytick = Defaults.global.yTick

    @Argument(help: "CSV file name, \"-\" means use stdin") var csvName: String?
    @Argument(help: "JSON file name") var jsonName: String?
    @Argument(help: "Output file name, default is to print to terminal") var outName: String?

    var separator: String {
        if tsv { return "\t" }
        if semi { return ";" }
        return ","
    }
}

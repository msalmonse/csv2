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

private let commonOpts: [OptToGet] = [
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
    OptToGet(.height, 1...1, usage: "Chart height", argTag: "<n>"),
    OptToGet(.index, 1...1, usage: "Index row or column", argTag: "<n>"),
    OptToGet(.italic, usage: "Use an italic font"),
    OptToGet(.include, 1...1, options: [.minusOK], usage: "Plots to include, default all", argTag: "<bitmap>"),
    OptToGet(.logo, 1...1, usage: "Image URL for top right corner", argTag: "<url>"),
    OptToGet(.logx, usage: "Set abcissa to log"),
    OptToGet(.logy, usage: "Set ordinate to log"),
    OptToGet(.nameheader, 1...1, usage: "Plot name row or column", argTag: "<n>"),
    OptToGet(.names, 1...255, usage: "List of plot names", argTag: "<name>..."),
    OptToGet(.bounds, usage: "Don't check options for bounds"),
    OptToGet(.comment, usage: "Don't add csv2 comment to plot"),
    OptToGet(.legends, usage: "Don't include plot names, colours, dashes and shapes"),
    OptToGet(.opacity, usage: "Opacity for plots"),
    OptToGet(.pie, usage: "Generate a pie chart"),
    OptToGet(
        .random, 1...3, options: [.minusOK],
        usage: "Generate a random SVG with: #plots [max value [min value]]", argTag: "<n [n [n]]>"
    ),
    OptToGet(
        .reserve, 1...4,
        usage: "Reserved space on the left [top [right [bottom]]]", argTag: "<n [n [n [n]]]>"
    ),
    OptToGet(.rows, usage: "Group data by rows"),
    OptToGet(
        .scattered, 1...1, options: [.minusOK],
        usage: "Plots to show as scatter plots", argTag: "<bitmap>"
    ),
    OptToGet(.semi, usage: "Use semicolons to seperate columns"),
    OptToGet(.shapes, 1...255, usage: "List of shapes to use", argTag: "<shape>..."),
    OptToGet(.shapenames, usage: "Print a list of shape names"),
    OptToGet(.show, 1...1, usage: "Generate a plot with the shape @ 6X strokewidth", argTag: "<shape>"),
    OptToGet(.showpoints, 1...1, options: [.minusOK], usage: "Data plots with points", argTag: "<bitmap>"),
    OptToGet(.size, 1...1, usage: "Base font size", argTag: "<n>"),
    OptToGet(.smooth, 1...1, usage: "EMA smoothing, 0 means none", argTag: "<n>"),
    OptToGet(.sortx, usage: "Sort points by the x values before plotting"),
    OptToGet(.stroke, 1...1, usage: "Stroke width", argTag: "<n>"),
    OptToGet(.subheader, 1...1, usage: "Sub-title row or column source", argTag: "<n>"),
    OptToGet(.subtitle, 1...1, usage: "Sub-title", argTag: "<text>"),
    OptToGet(.textcolour, 1...1, usage: "Text colour", argTag: "<colour>"),
    OptToGet(.title, 1...1, usage: "Chart title", argTag: "<text>"),
    OptToGet(.tsv, usage: "Use tabs to seperate columns"),
    OptToGet(.verbose, short: "v", usage: "Add extra information"),
    OptToGet(.version, short: "V", usage: "Display version and exit"),
    OptToGet(.width, 1...1, usage: "Chart width", argTag: "<n>"),
    OptToGet(.xmax, 1...1, usage: "Abscissa maximum", argTag: "<n>"),
    OptToGet(.xmin, 1...1, usage: "Abscissa minimum", argTag: "<n>"),
    OptToGet(.xtags, 1...1, usage: "Row or column with abscissa tags", argTag: "<n>"),
    OptToGet(.xtick, 1...1, usage: "Distance between abcissa ticks", argTag: "<n>"),
    OptToGet(.ymax, 1...1, usage: "Ordinate maximum", argTag: "<n>"),
    OptToGet(.ymin, 1...1, usage: "Ordinate minimum", argTag: "<n>"),
    OptToGet(.xtick, 1...1, usage: "Distance between abcissa ticks", argTag: "<n>"),
]

struct Options {
    var bared = Defaults.global.bared
    var baroffset = Defaults.global.barOffset
    var barwidth = Defaults.global.barWidth
    var bg = Defaults.global.backgroundColour
    var bitmap: [Int] = []
    var bezier = Defaults.global.bezier
    var black = Defaults.global.black
    var bold = Defaults.global.bold
    var bounds = true
    var canvas = Defaults.global.canvasID
    var canvastag = false
    var colourslist = false
    var colournames = false
    var colournameslist = false
    var colours: [String] = []
    var comment = Defaults.global.comment
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
    var legends = Defaults.global.legends
    var logo = Defaults.global.logoURL
    var logx = Defaults.global.logx
    var logy = Defaults.global.logy
    var nameheader = Defaults.global.nameHeader
    var names: [String] = []
    var opacity = Defaults.global.opacity
    var pie = false
    var random: [Int] = []
    var reserve = [
        Defaults.global.reserveLeft,
        Defaults.global.reserveTop,
        Defaults.global.reserveRight,
        Defaults.global.reserveBottom
    ]
    var rows = Defaults.global.rowGrouping
    var scattered = Defaults.global.scattered
    var semi = false
    var shapes: [String] = []
    var shapenames = false
    var show: String = ""
    var showpoints = Defaults.global.showDataPoints
    var size = Defaults.global.baseFontSize
    var smooth = Defaults.global.smooth
    var sortx = Defaults.global.sortx
    var stroke = Defaults.global.strokeWidth
    var subheader = Defaults.global.index
    var subtitle: String = ""
    var svg = Defaults.global.svgInclude
    var textcolour = Defaults.global.textColour
    var title: String = ""
    var tsv = false
    var verbose = false
    var version = false
    var width = Defaults.global.width
    var xmax = Defaults.global.xMax
    var xmin = Defaults.global.xMin
    var xtags = Defaults.global.xTagsHeader
    var xtick = Defaults.global.xTick
    var ymax = Defaults.global.yMax
    var ymin = Defaults.global.yMin
    var ytick = Defaults.global.yTick

    // Positional parameters

    var csvName: String?
    var jsonName: String?
    var outName: String?

    // Indicator for options on the command line
    var onCommandLine: Set<Settings.CodingKeys> = []

    var separator: String {
        if tsv { return "\t" }
        if semi { return ";" }
        return ","
    }

    /// Set a boolean value and tag it
    /// - Parameters:
    ///   - val: value to set
    ///   - key: key to tag

    mutating func getBool(_ val: Bool, key: Settings.CodingKeys?) -> Bool {
        if let key = key { onCommandLine.insert(key) }
        return val
    }

    /// Set a double value and tag it
    /// - Parameters:
    ///   - val: value to set
    ///   - key: key to tag
    /// - Throws: OptGetterError.illegalValue

    mutating func getDouble(_ val: ValueAt, key: Settings.CodingKeys?) throws -> Double{
        do {
            if let key = key { onCommandLine.insert(key) }
            return try OptGetter.doubleValue(val)
        } catch {
            throw error
        }
    }

    /// Set an int value and tag it
    /// - Parameters:
    ///   - val: value to set
    ///   - key: key to tag
    /// - Throws: OptGetterError.illegalValue

    mutating func getInt(_ val: ValueAt, key: Settings.CodingKeys?) throws -> Int {
        do {
            if let key = key { onCommandLine.insert(key) }
            return try OptGetter.intValue(val)
        } catch {
            throw error
        }
    }

    /// Set a string value and tag it
    /// - Parameters:
    ///   - val: value to set
    ///   - key: key to tag

    mutating func getString(_ val: ValueAt, key: Settings.CodingKeys?) -> String {
        if let key = key { onCommandLine.insert(key) }
        return OptGetter.stringValue(val)
    }


    /// Fetch options from the command line
    /// - Parameter plotter: the type of chart to fet options for
    /// - Throws:
    ///   - OptGetterError.duplicateArgument
    ///   - OptGetterError.duplicateName
    ///   - OptGetterError.illegalValue
    ///   - OptGetterError.insufficientArguments
    ///   - OptGetterError.tooManyOptions
    ///   - OptGetterError.unknownName

    mutating func getOpts(for plotter: PlotterType) throws {
        var opts = commonOpts
        switch plotter {
        case .canvas: opts += canvasOpts
        case .svg: opts += svgOpts
        default: break
        }

        do {
            let optGetter = try OptGetter(opts)
            let optsGot = try optGetter.parseArgs(args: CommandLine.arguments)
            for opt in optsGot {
                // swiftlint:disable:next force_cast
                let optTag = opt.tag as! Key
                let val0 = opt.valuesAt[0]

                switch optTag {
                case .bared: bared = try getInt(val0, key: .bared)
                case .baroffset: baroffset = try getDouble(val0, key: .barOffset)
                case .barwidth: barwidth = try getDouble(val0, key: .barWidth)
                case .bezier: bezier = try getDouble(val0, key: .bezier)
                    // case .bg:
                case .black: black = getBool(true, key: .black)
                case .bold: bold = getBool(true, key: .bold)
                case .bounds: bounds = getBool(false, key: nil)
                // case .bitmap:
                case .canvas: canvas = getString(val0, key: .canvasID)
                default: break
                }
            }
        } catch {
            throw error
        }
    }
}

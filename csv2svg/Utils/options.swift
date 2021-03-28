//
//  options.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-08.
//

import Foundation
import ArgumentParser

struct Options: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: AppInfo.name,
        abstract: "Generate an SVG using data from a CSV file and settings from a JSON file.",
        version: AppInfo.version
    )

    @Option(name: .long, help: "Background colour")
    var bg = Defaults.backgroundColour

    @Option(name: .long, parsing: .upToNextOption,
            help: "Convert a list of rows or columns to a bitmap")
    var bitmap: [Int] = []

    @Flag(name: .long, help: "Set default colour to black")
    var black = Defaults.black

    @Flag(name: .long, help: "Set default font-weight to bold")
    var bold = Defaults.bold

    @Flag(name: .long, help: "Generate an SVG with all the colours on it")
    var colourslist = false

    @Option(name: .long, parsing: .upToNextOption,
            help: "Default list of plot colours, multiple entries until the next option")
    var colours: [String] = []

    @Option(name: .long, help: "Default include file for css styling")
    var css = Defaults.cssInclude

    @Option(name: .long, help: "Default id for SVG")
    var cssid = Defaults.cssID

    @Option(name: .long, help: "Default plots to show as with dashed lines")
    var dashed = Defaults.dashedLines

    @Option(name: .long, parsing: .upToNextOption,
            help: "Default list of plot dash patterns, multiple entries until the next option")
    var dashes: [String] = []

    @Flag(name: .long, help: "Generate an SVG with all the dashes on it")
    var dasheslist = false

    @Option(name: .shortAndLong, help: "Add debug info")
    var debug = 0

    @Option(name: .long, help: "Minimum distance between data points")
    var distance = Defaults.dataPointDistance

    @Option(name: .long, help: "Default font family")
    var font = Defaults.fontFamily

    @Option(name: .long, help: "Default header rows or columns")
    var headers = Defaults.headers

    @Option(name: .long, help: "Default svg height")
    var height = Defaults.height

    @Option(name: .long, help: "Default index row or column")
    var index = Defaults.index

    @Flag(name: .long, help: "Set default colour to black")
    var italic = Defaults.italic

    @Option(name: .long, help: "Default rows or columns to include")
    var include = Defaults.include

    @Flag(name: .long, help: "Set default for abcissa to log")
    var logx = Defaults.logx

    @Flag(name: .long, help: "Set default for ordinate to log")
    var logy = Defaults.logy

    @Option(name: .long, help: "Default plot name row or column")
    var nameheader = Defaults.nameHeader

    @Option(name: .long, parsing: .upToNextOption,
            help: "Default list of plot names, multiple entries until the next option")
    var names: [String] = []

    @Flag(name: .long, help: "Don't include plot names, colours, dashes and shapes")
    var nolegends = !Defaults.legends

    @Option(name: .long, help: "Default index row or column")
    var opacity = Defaults.opacity

    @Option(name: .long, parsing: .upToNextOption,
            help: "Generate a random SVG with: #plots [max value [min value [-ve offset]]]")
    var random: [Int] = []

    @Flag(name: .long, help: "Default to grouping data by rows")
    var rows = Defaults.rowGrouping

    @Option(name: .long, help: "Default plots to show as scattered")
    var scattered = Defaults.scattered

    @Option(name: .long, parsing: .upToNextOption,
            help: "Default list of shapes, multiple entries until the next option")
    var shapes: [String] = []

    @Flag(name: .long, help: "Print a list of shape names")
    var shapenames = false

    @Option(name: .long, help: "Generate an SVG with just the named shape @ 6X strokewidth")
    var show: String = ""

    @Option(name: .long, help: "Default data plots with points")
    var showpoints = Defaults.showDataPoints

    @Option(name: .long, help: "Default font size")
    var size = Defaults.baseFontSize

    @Option(name: .long, help: "Default smoothing, 0 means none")
    var smooth = Defaults.smooth

    @Flag(name: .long, help: "Sort points by the x values before plotting")
    var sortx = Defaults.sortx

    @Option(name: .long, help: "Default stroke width")
    var stroke = Defaults.strokeWidth

    @Option(name: .long, help: "Default sub-title row or column")
    var subheader = Defaults.index

    @Option(name: .long, help: "Default sub-title")
    var subtitle: String = ""

    @Option(name: .long, help: "Default title")
    var title: String = ""

    @Flag(name: .shortAndLong, help: "Use tabs to seperate columns")
    var tsv = false

    @Flag(name: .shortAndLong, help: "Add extra information")
    var verbose = false

    @Flag(name: [.customShort("V"), .long], help: "Display version and exit")
    var version = false

    @Option(name: .long, help: "Default svg width")
    var width = Defaults.width

    @Option(name: .long, help: "Default abscissa maximum")
    var xmax = Defaults.xMax

    @Option(name: .long, help: "Default abscissa minimum")
    var xmin = Defaults.xMin

    @Option(name: .long, help: "Default x tick")
    var xtick = Defaults.xTick

    @Option(name: .long, help: "Default ordinate maximum")
    var ymax = Defaults.yMax

    @Option(name: .long, help: "Default ordinate minimum")
    var ymin = Defaults.yMin

    @Option(name: .long, help: "Default y tick")
    var ytick = Defaults.yTick

    @Argument(help: "CSV file name, \"-\" means use stdin") var csvName: String?
    @Argument(help: "JSON file name") var jsonName: String?
    @Argument(help: "SVG file name, default is to print to terminal") var svgName: String?

    /// Set Settings defaults using options from the command line

    func setDefaults() {
        // Change defaults based on command line
        Defaults.backgroundColour = bg
        Defaults.baseFontSize = size
        Defaults.black = black
        Defaults.bold = bold
        Defaults.colours = colours
        Defaults.cssID = cssid
        Defaults.cssInclude = css
        Defaults.dashedLines = dashed
        Defaults.dashes = dashes
        Defaults.dataPointDistance = distance
        Defaults.fontFamily = font
        Defaults.headers = headers
        Defaults.height = height
        Defaults.include = include
        Defaults.index = index
        Defaults.italic = italic
        Defaults.legends = !nolegends
        Defaults.logx = logx
        Defaults.logy = logy
        Defaults.nameHeader = nameheader
        Defaults.names = names
        Defaults.opacity = opacity
        Defaults.rowGrouping = rows
        Defaults.scattered = scattered
        Defaults.showDataPoints = showpoints
        Defaults.smooth = smooth
        Defaults.sortx = sortx
        Defaults.strokeWidth = stroke
        Defaults.subTitleHeader = subheader
        Defaults.subTitle = subtitle
        Defaults.title = title
        Defaults.width = width
        Defaults.xMax = xmax
        Defaults.xMin = xmin
        Defaults.yMax = ymax
        Defaults.yMin = ymin
    }
}

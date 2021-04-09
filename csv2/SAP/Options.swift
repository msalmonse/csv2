//
//  Options.swift
//  csv2
//
//  Created by Michael Salmon on 2021-03-08.
//

import Foundation
import ArgumentParser

struct Options: ParsableArguments {
    static let configuration = CommandConfiguration(
        commandName: AppInfo.name,
        abstract: "Generate an SVG using data from a CSV file and settings from a JSON file.",
        version: AppInfo.version
    )

    @Option(name: .long, help: "Background colour")
    var bg = Defaults.global.backgroundColour

    @Option(name: .long, parsing: .upToNextOption,
            help: "Convert a list of rows or columns to a bitmap")
    var bitmap: [Int] = []

    @Option(name: .long, help: "Default bezier curve, 0 means none")
    var bezier = Defaults.global.bezier

    @Flag(name: .long, help: "Set default colour to black")
    var black = Defaults.global.black

    @Flag(name: .long, help: "Set default font-weight to bold")
    var bold = Defaults.global.bold

    @Flag(name: .long, help: "Generate an SVG with all the colours on it")
    var colourslist = false

    @Option(name: .long, parsing: .upToNextOption,
            help: "Default list of plot colours, multiple entries until the next option")
    var colours: [String] = []

    @Option(name: .long, help: "Default plots to show as with dashed lines")
    var dashed = Defaults.global.dashedLines

    @Option(name: .long, parsing: .upToNextOption,
            help: "Default list of plot dash patterns, multiple entries until the next option")
    var dashes: [String] = []

    @Flag(name: .long, help: "Generate an SVG with all the dashes on it")
    var dasheslist = false

    @Option(name: .shortAndLong, help: "Add debug info")
    var debug = 0

    @Option(name: .long, help: "Minimum distance between data points")
    var distance = Defaults.global.dataPointDistance

    @Option(name: .long, help: "Default font family")
    var font = Defaults.global.fontFamily

    @Option(name: .long, help: "Default header rows or columns")
    var headers = Defaults.global.headers

    @Option(name: .long, help: "Default svg height")
    var height = Defaults.global.height

    @Option(name: .long, help: "Default index row or column")
    var index = Defaults.global.index

    @Flag(name: .long, help: "Set default colour to black")
    var italic = Defaults.global.italic

    @Option(name: .long, help: "Default rows or columns to include")
    var include = Defaults.global.include

    @Flag(name: .long, help: "Set default for abcissa to log")
    var logx = Defaults.global.logx

    @Flag(name: .long, help: "Set default for ordinate to log")
    var logy = Defaults.global.logy

    @Option(name: .long, help: "Default plot name row or column")
    var nameheader = Defaults.global.nameHeader

    @Option(name: .long, parsing: .upToNextOption,
            help: "Default list of plot names, multiple entries until the next option")
    var names: [String] = []

    @Flag(name: .long, help: "Don't check options for bounds")
    var nobounds = false

    @Flag(name: .long, help: "Don't add csv2 comment to plot")
    var nocomment = !Defaults.global.comment

    @Flag(name: .long, help: "Don't add CSS code to emphasize hovered plots")
    var nohover = !Defaults.global.hover

    @Flag(name: .long, help: "Don't include plot names, colours, dashes and shapes")
    var nolegends = !Defaults.global.legends

    @Option(name: .long, help: "Default index row or column")
    var opacity = Defaults.global.opacity

    @Option(name: .long, parsing: .upToNextOption,
            help: "Generate a random SVG with: #plots [max value [min value [-ve offset]]]")
    var random: [Int] = []

    @Option(name: .long, parsing: .upToNextOption,
            help: "Default reserved left [top [right [bottom]]]")
    var reserve = [
        Defaults.global.reserveLeft,
        Defaults.global.reserveTop,
        Defaults.global.reserveRight,
        Defaults.global.reserveBottom
    ]

    @Flag(name: .long, help: "Default to grouping data by rows")
    var rows = Defaults.global.rowGrouping

    @Option(name: .long, help: "Default plots to show as scattered")
    var scattered = Defaults.global.scattered

    @Option(name: .long, parsing: .upToNextOption,
            help: "Default list of shapes, multiple entries until the next option")
    var shapes: [String] = []

    @Flag(name: .long, help: "Print a list of shape names")
    var shapenames = false

    @Option(name: .long, help: "Generate an SVG with just the named shape @ 6X strokewidth")
    var show: String = ""

    @Option(name: .long, help: "Default data plots with points")
    var showpoints = Defaults.global.showDataPoints

    @Option(name: .long, help: "Default font size")
    var size = Defaults.global.baseFontSize

    @Option(name: .long, help: "Default smoothing, 0 means none")
    var smooth = Defaults.global.smooth

    @Flag(name: .long, help: "Sort points by the x values before plotting")
    var sortx = Defaults.global.sortx

    @Option(name: .long, help: "Default stroke width")
    var stroke = Defaults.global.strokeWidth

    @Option(name: .long, help: "Default sub-title row or column")
    var subheader = Defaults.global.index

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
    var width = Defaults.global.width

    @Option(name: .long, help: "Default abscissa maximum")
    var xmax = Defaults.global.xMax

    @Option(name: .long, help: "Default abscissa minimum")
    var xmin = Defaults.global.xMin

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

    func defaults(for cmd: CSVplotterCommand) -> Defaults {
        return Defaults(
            backgroundColour: bg,
            baseFontSize: size,
            bezier: bezier,
            black: black,
            bold: bold,
            bounded: !nobounds,
            canvas: cmd.ownOptions(key: .canvas, default: Defaults.global.canvas),
            colours: colours,
            comment: !nocomment,
            cssClasses: [],
            cssExtras: [],
            cssID: cmd.ownOptions(key: .cssid, default: Defaults.global.cssID),
            cssInclude: cmd.ownOptions(key: .css, default: Defaults.global.cssInclude),
            dashedLines: dashed,
            dashes: dashes,
            dataPointDistance: distance,
            fontFamily: font,
            headers: headers,
            height: height,
            hover: !nohover,
            include: include,
            index: index,
            italic: italic,
            legends: !nolegends,
            logoHeight: Defaults.global.logoHeight,
            logoURL: cmd.ownOptions(key: .logo, default: Defaults.global.logoURL),
            logoWidth: Defaults.global.logoWidth,
            logx: logx,
            logy: logy,
            nameHeader: nameheader,
            names: names,
            opacity: opacity,
            reserveBottom: reserve.hasIndex(0) ? reserve[0] : 0.0,
            reserveLeft: reserve.hasIndex(3) ? reserve[3] : 0.0,
            reserveRight: reserve.hasIndex(2) ? reserve[2] : 0.0,
            reserveTop: reserve.hasIndex(1) ? reserve[1] : 0.0,
            rowGrouping: rows,
            scattered: scattered,
            shapes: shapes,
            showDataPoints: showpoints,
            sortx: sortx,
            smooth: smooth,
            strokeWidth: stroke,
            subTitle: subtitle,
            subTitleHeader: subheader,
            svgInclude: cmd.ownOptions(key: .svg, default: Defaults.global.svgInclude),
            title: title,
            width: width,
            xMax: xmax,
            xMin: xmin,
            xTick: xtick,
            yMax: ymax,
            yMin: ymin,
            yTick: ytick
        )
    }
}

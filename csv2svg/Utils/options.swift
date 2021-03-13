//
//  options.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-08.
//

import Foundation
import ArgumentParser

struct Options: ParsableCommand {
    @Option(name: .long, help: "Background colour")
    var bg = Defaults.backgroundColour

    @Flag(name: .long, help: "Set default colour to black")
    var black = Defaults.black

    @Option(name: .long, help: "Default colour")
    var colour = "black"

    @Option(name: .shortAndLong, help: "Add debug info")
    var debug = 0

    @Option(name: .long, help: "Default header rows or columns")
    var headers = Defaults.headers

    @Option(name: .long, help: "Default svg height")
    var height = Defaults.height

    @Option(name: .long, help: "Default index row or column")
    var index = Defaults.index

    @Flag(name: .long, help: "Default to grouping data by rows")
    var rows = Defaults.rowGrouping

    @Option(name: .long, help: "Default plots to show as scattered")
    var scattered = Defaults.scattered

    @Flag(name: .long, help: "Print a list of shape names")
    var shapes = false

    @Option(name: .long, help: "Generate an SVG with just the named shape")
    var show: String = ""

    @Option(name: .long, help: "Default font size")
    var size = Defaults.baseFontSize

    @Option(name: .long, help: "Default stroke width")
    var stroke = Defaults.strokeWidth

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

    @Option(name: .long, help: "Default ordinate maximum")
    var ymax = Defaults.yMax

    @Option(name: .long, help: "Default ordinate minimum")
    var ymin = Defaults.yMin

    @Argument(help: "CSV file name, \"-\" means use stdin") var csvName: String?
    @Argument(help: "JSON file name") var jsonName: String?
}

/// Set Settings defaults using options from the command line
/// - Parameter options: Options object

func setDefaultsFromOptions(_ options: Options) {
    // Change defaults based on command line
    Defaults.backgroundColour = options.bg
    Defaults.baseFontSize = options.size
    Defaults.black = options.black
    Defaults.headers = options.headers
    Defaults.height = options.height
    Defaults.index = options.index
    Defaults.rowGrouping = options.rows
    Defaults.scattered = options.scattered
    Defaults.strokeWidth = options.stroke
    Defaults.width = options.width
    Defaults.xMax = options.xmax
    Defaults.xMin = options.xmin
    Defaults.yMax = options.ymax
    Defaults.yMin = options.ymin
}

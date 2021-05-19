//
//  Options.swift
//  csv2
//
//  Created by Michael Salmon on 2021-03-08.
//

import Foundation
import OptGetter

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

    /// Fetch options from the command line
    /// - Parameter plotter: the type of chart to fet options for
    /// - Throws:
    ///   - OptGetterError.duplicateArgument
    ///   - OptGetterError.duplicateName
    ///   - OptGetterError.illegalValue
    ///   - OptGetterError.insufficientArguments
    ///   - OptGetterError.tooManyOptions
    ///   - OptGetterError.unknownName

    mutating func getOpts(for command: CommandType, _ args: [String] = CommandLine.arguments) throws {
        var opts = Self.commonOpts
        switch command {
        case .canvas: opts += Self.canvasOpts
        case .svg: opts += Self.svgOpts
        default: break
        }

        do {
            let optGetter = try OptGetter(opts, longOnly: true)
            let optsGot = try optGetter.parseArgs(args: args, command.optStart)
            for opt in optsGot {
                try getOpt(opt: opt)
            }
            switch optGetter.remainingValuesAt.count {
            case 3...:
                outName = getString(optGetter.remainingValuesAt[2], key: nil)
                fallthrough
            case 2:
                jsonName = getString(optGetter.remainingValuesAt[1], key: nil)
                fallthrough
            case 1:
                csvName = getString(optGetter.remainingValuesAt[0], key: nil)
            default:
                break
            }
        } catch {
            throw error
        }
    }
}

/// Get usage string for common options
/// - Returns: usage string

func commonUsage() -> String? {
    return OptGetter.usage(Options.commonOpts, longFirst: true, longOnly: true)
}

/// Get usage string for canvas
/// - Returns: usage string

func canvasUsage() -> String? {
    return OptGetter.usage(Options.canvasOpts, longFirst: true, longOnly: true)
}

/// Get usage string for PDF
/// - Returns: usage string

func pdfUsage() -> String? {
    return nil
}

/// Get usage for PNG charts
/// - Returns: usage string

func pngUsage() -> String? {
    return nil
}

/// Get usage for SVG charts
/// - Returns: usage string

func svgUsage() -> String? {
    return OptGetter.usage(Options.svgOpts, longFirst: true, longOnly: true)
}

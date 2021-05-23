//
//  Options.swift
//  csv2
//
//  Created by Michael Salmon on 2021-03-08.
//

import Foundation
import OptGetter

struct Options {
    var debug = 0
    var pie = false
    var random: [Int] = []
    var semi = false
    var tsv = false
    var verbose = false

    // Positional parameters

    var csvName: String?
    var jsonName: String?
    var outName: String?

    // Defaults
    var values = Defaults()

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
        case .canvas, .canvasColourNames, .canvasColours, .canvasDashes, .canvasShape,
             .canvastag, .canvastagColourNames, .canvastagColours, .canvastagDashes, .canvastagShape:
            opts += Self.canvasOpts
        case .svg, .svgColourNames, .svgColours, .svgDashes, .svgShape:
            opts += Self.svgOpts
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
                outName = optGetter.remainingValuesAt[2].stringValue()
                fallthrough
            case 2:
                jsonName = optGetter.remainingValuesAt[1].stringValue()
                fallthrough
            case 1:
                csvName = optGetter.remainingValuesAt[0].stringValue()
            default:
                break
            }
        } catch {
            throw error
        }
    }

    /// Create defaults from command line
    /// - Returns: defaults

    func defaults() -> Defaults {
        return values
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

/// Get usage for positional parameters
/// - Returns: usage string

func positionalUsage() -> String? {
    return OptGetter.positionalUsage(Options.positionalOpts)
}

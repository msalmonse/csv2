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
    /// - Parameters:
    ///   - command: the main command, used to select the option set
    ///   - args: argument list
    ///   - start: argument to begin with
    /// - Throws:
    ///   - OptGetterError.duplicateArgument
    ///   - OptGetterError.duplicateName
    ///   - OptGetterError.illegalValue
    ///   - OptGetterError.insufficientArguments
    ///   - OptGetterError.tooManyOptions
    ///   - OptGetterError.unknownName

    mutating func getOpts(for command: MainCommandType, _ args: [String], _ start: Int) throws {
        var opts = Self.commonOpts
        switch command {
        case .canvas: opts += Self.canvasOpts
        case .help: opts = Self.helpOpts
        case .svg: opts += Self.svgOpts
        default: break
        }

        do {
            let optGetter = try OptGetter(opts, longOnly: true)
            let optsGot = try optGetter.parseArgs(args: args, start)
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

/// Fetch options from the command line, exit on error
/// - Parameters:
///   - command: the main command, used to select the option set
///   - start: argument to begin with

func getOptsOrExit(for command: MainCommandType, _ start: Int) -> Options {
    var options = Options()
    do {
        try options.getOpts(for: command, CommandLine.arguments, start)
    } catch {
        print(error, to: &standardError)
        exit(1)
    }

    return options
}

/// Get usage string for common options
/// - Returns: usage string

func commonOptsUsage() -> String? { return optUsage(Options.commonOpts) }

/// Get usage string for canvas
/// - Returns: usage string

func canvasOptsUsage() -> String? { return optUsage(Options.canvasOpts) }

/// Get usage string for help options
/// - Returns: usage string

func helpOptsUsage() -> String? { return optUsage(Options.helpOpts) }

/// Get usage string for PDF
/// - Returns: usage string

func pdfOptsUsage() -> String? { return nil }

/// Get usage for PNG charts
/// - Returns: usage string

func pngOptsUsage() -> String? { return nil }

/// Get usage for SVG charts
/// - Returns: usage string

func svgOptsUsage() -> String? { return optUsage(Options.svgOpts)}

/// Get usage for positional parameters
/// - Returns: usage string

func positionalArgsUsage() -> String? { return positionalUsage(Options.positionalOpts) }

/// Wrap text
/// - Parameter text: text to wrap
/// - Returns: wrapped text

func textWrap(_ text: String) -> String { return textWrap([text]) }

/// Wrap text array
/// - Parameter text: Array of strings
/// - Returns: wrapped text

func textWrap(_ text: [String]) -> String { return paragraphWrap(text) }

//
//  Commands.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-09.
//

import Foundation
import ArgumentParser

protocol CSVplotterCommand {
    var iAm: PlotterType { get }
    func options() -> Options
    func ownOptions<T>(key: CommandPath, default: T) -> T
}

enum CommandPath {
    case canvas, canvastag, css, cssid, hover, logo, svg
}

struct CSVplotter: ParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: AppInfo.name,
        abstract: "Generate an SVG, PNG or, Canvas file using data from a CSV file and settings from a JSON file.",
        subcommands: [Canvas.self, PNG.self, SVG.self],
        defaultSubcommand: SVG.self
    )
}

extension CSVplotter {
    struct Canvas: ParsableCommand, CSVplotterCommand {
        static var configuration = CommandConfiguration(
            abstract: "Plot data on an HTML Canvas using JavaScript"
        )

        var iAm: PlotterType { PlotterType.canvas }
        func options() -> Options { return common }
        func ownOptions<T>(key: CommandPath, default val: T) -> T {
            switch key {
            case .canvas: return canvas as? T ?? val
            case .canvastag: return canvastag as? T ?? val
            default: return val
            }
        }

        @OptionGroup var common: Options

        // Canvas specific options

        @Option(name: .long, help: "Canvas name")
        var canvas = Defaults.global.canvasID

        @Flag(name: .long, help: "Print the canvas tag")
        var canvastag = false
    }
}

extension CSVplotter {
    struct PNG: ParsableCommand, CSVplotterCommand {
        static var configuration = CommandConfiguration(
            abstract: "Plot data on a PNG image"
        )

        var iAm: PlotterType { PlotterType.png }
        func options() -> Options { return common }
        func ownOptions<T>(key: CommandPath, default val: T) -> T {
            return val
        }

        @OptionGroup var common: Options

        // PNG specific options
    }
}

extension CSVplotter {
    struct SVG: ParsableCommand, CSVplotterCommand {
        static var configuration = CommandConfiguration(
            abstract: "Plot data in an SVG"
        )

        var iAm: PlotterType { PlotterType.svg }
        func options() -> Options { return common }
        func ownOptions<T>(key: CommandPath, default val: T) -> T {
            switch key {
            case .css: return css as? T ?? val
            case .cssid: return cssid as? T ?? val
            case .hover: return !nohover as? T ?? val
            case .svg: return svg as? T ?? val
            default: return val
            }
        }

        @OptionGroup var common: Options

        // SVG specific options

        @Option(name: .long, help: "Default include file for css styling")
        var css = Defaults.global.cssInclude

        @Option(name: .long, help: "Default id for SVG")
        var cssid = Defaults.global.cssID

        @Flag(name: .long, help: "Don't add CSS code to emphasize hovered plots")
        var nohover = !Defaults.global.hover

        @Option(name: .long, help: "Default include file for svg elements")
        var svg = Defaults.global.svgInclude
    }
}

func getCommand() -> CSVplotterCommand {
    var result: CSVplotterCommand
    do {
        var command = try CSVplotter.parseAsRoot()
        switch command {
        case let canvasCmd as CSVplotter.Canvas: result = canvasCmd
        case let pngCmd as CSVplotter.PNG: result = pngCmd
        case let svgCmd as CSVplotter.SVG: result = svgCmd
        default: try command.run(); exit(0)
        }
    } catch {
        CSVplotter.exit(withError: error)
    }
    return result
}

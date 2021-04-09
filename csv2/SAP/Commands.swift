//
//  Commands.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-09.
//

import Foundation
import ArgumentParser

protocol CSVplotterCommand {
    func iAm() -> PlotterType
    func options() -> Options
}

struct CSVplotter: ParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: AppInfo.name,
        abstract: "Generate an SVG or JS file using data from a CSV file and settings from a JSON file.",
        version: AppInfo.version,
        subcommands: [JS.self, SVG.self],
        defaultSubcommand: SVG.self
    )
}

extension CSVplotter {
    struct JS: ParsableCommand, CSVplotterCommand {
        static var configuration = CommandConfiguration(
            abstract: "Plot data on an HTML Canvas using JavaScript"
        )

        func iAm() -> PlotterType { return PlotterType.js }
        func options() -> Options { return common }

        @OptionGroup var common: Options

        @Option(name: .long, help: "Canvas name")
        var canvas = Defaults.global.canvas
    }
}

extension CSVplotter {
    struct SVG: ParsableCommand, CSVplotterCommand {
        static var configuration = CommandConfiguration(
            abstract: "Plot data in an SVG"
        )

        func iAm() -> PlotterType { return PlotterType.js }
        func options() -> Options { return common }

        @OptionGroup var common: Options
    }
}

func getCommand() -> CSVplotterCommand {
    var result: CSVplotterCommand
    do {
        let command = try CSVplotter.parseAsRoot()
        switch command {
        case let jsCmd as CSVplotter.JS: result = jsCmd
        case let svgCmd as CSVplotter.SVG: result = svgCmd
        default: exit(1)
        }
    } catch {
        CSVplotter.exit(withError: error)
    }
    return result
}

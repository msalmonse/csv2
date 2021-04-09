//
//  Commands.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-09.
//

import Foundation
import ArgumentParser

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
    struct JS: ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Plot data on an HTML Canvas using JavaScript"
        )

        static let iAm = PlotterType.js

        @OptionGroup var options: Options

        @Option(name: .long, help: "Canvas name")
        var canvas = Defaults.global.canvas
    }
}

extension CSVplotter {
    struct SVG: ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Plot data in an SVG"
        )

        static let iAm = PlotterType.svg

        @OptionGroup var options: Options
    }
}

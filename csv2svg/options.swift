//
//  options.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-08.
//

import Foundation
import ArgumentParser

struct Options: ParsableCommand {
    @Option(name: .shortAndLong, help: "Add debug info")
    var debug = 0

    @Option(name: .long, help: "Default header rows or columns")
    var headers = Settings.Defaults.headers

    @Option(name: .long, help: "Default svg height")
    var height = Settings.Defaults.height

    @Option(name: .long, help: "Default index row or column")
    var index = Settings.Defaults.index

    @Flag(name: .long, help: "Default to grouping data by rows")
    var rows = Settings.Defaults.rowGrouping

    @Option(name: .long, help: "Default stroke width")
    var stroke = Settings.Defaults.strokeWidth

    @Flag(name: .shortAndLong, help: "Add extra information")
    var verbose = false

    @Flag(name: [.customShort("V"), .long], help: "Display version and exit")
    var version = false

    @Option(name: .long, help: "Default svg width")
    var width = Settings.Defaults.width

    @Argument(help: "CSV file and optionally JSON file") var files: [String] = []
}

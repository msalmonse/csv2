//
//  options.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-08.
//

import Foundation
import ArgumentParser

struct Options: ParsableCommand {
    @Flag(name: .shortAndLong, help: "Add debug info") var debug = false
    @Option(name: .long, help: "Default header rows or columns") var headers = 0
    @Option(name: .long, help: "Default svg height") var height = 0
    @Option(name: .long, help: "Default index row or column") var index = 0
    @Flag(name: .long, help: "Default to grouping data by rows") var rows = false
    @Option(name: .long, help: "Default stroke width") var stroke = 2
    @Flag(name: .shortAndLong, help: "Add extra information") var verbose = false
    @Flag(name: [.customShort("V"), .long], help: "Display version and exit") var version = false
    @Option(name: .long, help: "Default svg width") var width = 0
    @Argument(help: "CSV file and optionally JSON file") var files: [String] = []
}

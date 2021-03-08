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
    @Option(name: .shortAndLong, help: "Default index row or column") var index = 0
    @Flag(name: .shortAndLong, help: "Default to grouping data by rows") var rows = false
    @Flag(name: .shortAndLong, help: "Add extra information") var verbose = false
    @Flag(name: [.customShort("V"), .long], help: "Display version and exit") var version = false
    @Argument(help: "CSV file and optionally JSON file") var files: [String] = []
}

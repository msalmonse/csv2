//
//  main.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-16.
//

import Foundation

let csvName = CommandLine.argc > 1 ? CommandLine.arguments[1] : "/Users/mesa/xcode/Fibonacci/timing.csv"
let jsonName = CommandLine.argc > 2 ? CommandLine.arguments[2] : csvName + ".json"

let settings = try? Settings.load(URL(fileURLWithPath: jsonName))

let csv = try? CSV(URL(fileURLWithPath: csvName))

let svg = SVG(csv!, settings!)
_ = svg.gen().map { print($0) }

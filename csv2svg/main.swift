//
//  main.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-16.
//

import Foundation

let csvName = CommandLine.argc > 1 ? CommandLine.arguments[1] : "/Users/mesa/xcode/Fibonacci/timing.csv"
let plistName = CommandLine.argc > 2 ? CommandLine.arguments[2] : csvName + ".plist"

let settings = Settings(plistName)

let csv = try CSV(csvName)

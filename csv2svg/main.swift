//
//  main.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-16.
//

import Foundation

if CommandLine.argc < 2 { exit(0) }

let csvName = CommandLine.arguments[1]
let jsonName = CommandLine.argc > 2 ? CommandLine.arguments[2] : csvName + ".json"

let settings = try? Settings.load(URL(fileURLWithPath: jsonName))

let csv = try? CSV(URL(fileURLWithPath: csvName))

if csv == nil || settings == nil {
    print("Error loading data.", to: &standardError)
    exit(1)
}

let svg = SVG(csv!, settings!)
_ = svg.gen().map { print($0) }

//
//  main.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-16.
//

import Foundation

var options = Options.parseOrExit()
options.setDefaults()

if options.debug != 0 {
    print(options, to: &standardError)
}

if options.version {
    print("\(AppInfo.name): \(AppInfo.version) (\(AppInfo.build)) Built at \(AppInfo.builtAt)",
          to: &standardError)
    exit(0)
}

if options.shapes {
    print(SVG.Shape.allNames())
    exit(0)
}

if options.show != "" {
    print(showShape(shape: options.show, stroke: options.colour))
    exit(0)
}

// use a csvName of - to mean use stdin
if options.csvName == "-" { options.csvName = nil }

if options.verbose {
    print(options.csvName ?? "Missing CSV file name", to: &standardError)
    print(options.jsonName ?? "Missing JSON file name", to: &standardError)
}

let settings = try? Settings.load(URL(fileURLWithPath: options.jsonName ?? ((options.csvName ?? "") + ".json")))
if (options.debug & 2) > 0 { print(settings ?? "Nil settings", to: &standardError) }

let csv = options.csvName != nil ? (try? CSV(URL(fileURLWithPath: options.csvName!))) : CSV(readLines())
if (options.debug & 4) > 0 { print(csv ?? "Nil csv", to: &standardError) }

if csv == nil || settings == nil {
    print("Error loading data.", to: &standardError)
    exit(1)
}

let svg = SVG(csv!, settings!)
if (options.debug & 8) > 0 { print(svg, to: &standardError) }

_ = svg.gen().map { print($0) }

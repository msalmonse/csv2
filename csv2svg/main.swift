//
//  main.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-16.
//

import Foundation

let options = Options.parseOrExit()

if options.debug != 0 {
    print(options, to: &standardError)
}

if options.version {
    print("\(AppInfo.name): \(AppInfo.version) (\(AppInfo.build)) Built at \(AppInfo.builtAt)",
          to: &standardError)
}

if options.csvName == nil { exit(0) }

if options.verbose {
    print(options.csvName ?? "Missing CSV file name", to: &standardError)
    print(options.jsonName ?? "Missing JSON file name", to: &standardError)
}

setDefaultsFromOptions(options)

let settings = try? Settings.load(URL(fileURLWithPath: options.jsonName ?? options.csvName! + ".json"))
if (options.debug & 2) > 0 { print(settings ?? "Nil settings", to: &standardError) }

let csv = try? CSV(URL(fileURLWithPath: options.csvName!))
if (options.debug & 4) > 0 { print(csv ?? "Nil csv", to: &standardError) }

if csv == nil || settings == nil {
    print("Error loading data.", to: &standardError)
    exit(1)
}

let svg = SVG(csv!, settings!)
if (options.debug & 8) > 0 { print(svg, to: &standardError) }

_ = svg.gen().map { print($0) }

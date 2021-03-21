//
//  main.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-16.
//

import Foundation

var opts = Options.parseOrExit()
opts.setDefaults()

if opts.debug != 0 {
    print(opts, to: &standardError)
}

if opts.version {
    print("\(AppInfo.name): \(AppInfo.version) (\(AppInfo.build)) Built at \(AppInfo.builtAt)",
          to: &standardError)
    exit(0)
}

if opts.shapenames {
    print(SVG.Shape.allNames())
    exit(0)
}

if opts.show != "" {
    print(showShape(shape: opts.show, stroke: opts.colour))
    exit(0)
}

if opts.bitmap.count > 0 {
    print(bitmap(opts.bitmap))
    exit(0)
}

// use a csvName of - to mean use stdin
if opts.csvName == "-" { opts.csvName = nil }

if opts.verbose && opts.random.count == 0 {
    print(opts.csvName ?? "Missing CSV file name", to: &standardError)
    print(opts.jsonName ?? "Missing JSON file name", to: &standardError)
}

let jsonUrl = URL(fileURLWithPath: opts.jsonName ?? ((opts.csvName ?? "") + ".json"))
let settings = try? Settings.load(jsonUrl)
if (opts.debug & 2) > 0 { print(settings ?? "Nil settings", to: &standardError) }

let csv = csvSelect(opts, settings)
if (opts.debug & 4) > 0 { print(csv ?? "Nil csv", to: &standardError) }

if csv == nil || settings == nil {
    print("Error loading data.", to: &standardError)
    exit(1)
}

let svg = SVG(csv!, settings!)
if (opts.debug & 8) > 0 { print(svg, to: &standardError) }

_ = svg.gen().map { print($0) }

func csvSelect(_ opts: Options, _ settings: Settings?) -> CSV? {
    let colsep = opts.tsv ? "\t" : ","

    switch (opts.csvName != nil, opts.random.count > 0) {
    case (_, true): return CSV(randomCSV(opts, settings))
    case (true, false): return try? CSV(URL(fileURLWithPath: opts.csvName!), separatedBy: colsep)
    case(false, false): return CSV(readLines(), separatedBy: colsep)
    }
}

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
    print("""
        \(AppInfo.name): \(AppInfo.version) (\(AppInfo.branch):\(AppInfo.build)) Built at \(AppInfo.builtAt)
        """,
        to: &standardError
    )
    exit(0)
}

if opts.shapenames {
    print(SVG.Shape.allNames())
} else if opts.show != "" {
    let colour = opts.colours.count > 0 ? opts.colours[0] : "black"
    svgOutput(showShape(shape: opts.show, stroke: colour), to: opts.svgName)
} else if opts.bitmap.count > 0 {
    print(bitmap(opts.bitmap))
} else if opts.colourslist {
    svgOutput(showColoursList(), to: opts.svgName)
} else if opts.dasheslist {
    svgOutput(showDashesList(), to: opts.svgName)
} else {
    // use a csvName of - to mean use stdin
    if opts.csvName == "-" { opts.csvName = nil }

    if opts.verbose && opts.random.count == 0 {
        print(opts.csvName ?? "Missing CSV file name, using stdin", to: &standardError)
        print(opts.jsonName ?? "Missing JSON file name", to: &standardError)
    }

    let settings = try? Settings.load(jsonURL(opts))
    if (opts.debug & 2) > 0 { print(settings ?? "Nil settings", to: &standardError) }

    let csv = csvSelect(opts, settings)
    if (opts.debug & 4) > 0 { print(csv ?? "Nil csv", to: &standardError) }

    if csv == nil || csv!.colCt == 0 || csv!.rowCt == 0 || settings == nil {
        print("Error loading data.", to: &standardError)
        exit(1)
    }

    let svg = SVG(csv!, settings!)
    if (opts.debug & 8) > 0 { print(svg, to: &standardError) }

    svgOutput(svg.gen(), to: opts.svgName)
}

/// Determine source of CSV data
/// - Parameters:
///   - opts: Options object
///   - settings: Settings object
/// - Returns: CSV object

private func csvSelect(_ opts: Options, _ settings: Settings?) -> CSV? {
    let colsep = opts.tsv ? "\t" : ","

    switch (opts.csvName != nil, opts.random.count > 0) {
    case (_, true): return CSV(randomCSV(opts, settings))
    case (true, false): return try? CSV(URL(fileURLWithPath: opts.csvName!), separatedBy: colsep)
    case(false, false): return CSV(readLines(), separatedBy: colsep)
    }
}

/// Determine JSON file URL
/// - Parameter opts: Options object
/// - Returns: JSON file URL

private func jsonURL(_ opts: Options) -> URL {
    switch (opts.jsonName == nil, opts.csvName == nil) {
    case (false,_): return URL(fileURLWithPath: opts.jsonName!)
    case (true,false): return URL(fileURLWithPath: opts.csvName! + ".json")
    case (true,true): return URL(fileURLWithPath: "default.json")
    }
}

/// Write an SVG as a string array to a file or stdout
/// - Parameters:
///   - tagList: the text array
///   - name: file name

private func svgOutput(_ tagList: [String], to name: String?) {
    if name == nil {
        _ = tagList.map { print($0) }
    } else {
        let text = tagList.joined(separator: "\n") + "\n"
        let data = Data(text.utf8)
        do {
            try data.write(to: URL(fileURLWithPath: name!))
        } catch {
            print(error, to: &standardError)
        }
    }
}

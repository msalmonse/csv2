//
//  main.swift
//  csv2
//
//  Created by Michael Salmon on 2021-02-16.
//

import Foundation

let command = getCommand()
var commonOpts = command.options()
var defaults = commonOpts.defaults(for: command)

if commonOpts.debug != 0 {
    print(commonOpts, to: &standardError)
}

if commonOpts.version {
    print("""
        \(AppInfo.name): \(AppInfo.version) (\(AppInfo.branch):\(AppInfo.build)) Built at \(AppInfo.builtAt)
        """,
        to: &standardError
    )
    exit(0)
}

if commonOpts.shapenames {
    print(Shape.allNames())
} else if commonOpts.show.hasContent {
    output(showShape(shape: commonOpts.show, defaults: defaults), to: commonOpts.outName)
} else if commonOpts.bitmap.hasEntries {
    print(bitmap(commonOpts.bitmap))
} else if commonOpts.colourslist {
    output(showColoursList(defaults), to: commonOpts.outName)
} else if commonOpts.dasheslist {
    output(showDashesList(defaults), to: commonOpts.outName)
} else {
    // use a csvName of - to mean use stdin
    if commonOpts.csvName == "-" { commonOpts.csvName = nil }

    if commonOpts.verbose && commonOpts.random.isEmpty {
        print(commonOpts.csvName ?? "Missing CSV file name, using stdin", to: &standardError)
        print(commonOpts.jsonName ?? "Missing JSON file name", to: &standardError)
    }

    let jsonSource = jsonURL(commonOpts)
    SearchPath.add(jsonSource)
    let settings = try? Settings.load(jsonSource)
    if commonOpts.debug &== 2 { print(settings ?? "Nil settings", to: &standardError) }

    if command.ownOptions(key: .canvastag, default: false) {
        output([JS.canvasTag(settings!)], to: commonOpts.outName)
        exit(0)
    }

    if commonOpts.csvName != nil { SearchPath.add(commonOpts.csvName!) }
    let csv = csvSelect(commonOpts, settings)
    if commonOpts.debug &== 4 { print(csv ?? "Nil csv", to: &standardError) }

    if csv == nil || csv!.colCt == 0 || csv!.rowCt == 0 || settings == nil {
        print("Error loading data.", to: &standardError)
        exit(1)
    }

    let plotter = command.iAm().plotter(settings: settings!)
    if commonOpts.debug &== 8 { print(plotter, to: &standardError) }

    let plot = Plot(csv!, settings!, plotter)
    output(plot.gen(), to: commonOpts.outName)
}

/// Determine source of CSV data
/// - Parameters:
///   - opts: Options object
///   - settings: Settings object
/// - Returns: CSV object

private func csvSelect(_ opts: Options, _ settings: Settings?) -> CSV? {
    let colsep = opts.tsv ? "\t" : ","

    switch (opts.csvName != nil, opts.random.hasEntries) {
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

/// Write an plot as a string array to a file or stdout
/// - Parameters:
///   - tagList: the text array
///   - name: file name

private func output(_ tagList: [String], to name: String?) {
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

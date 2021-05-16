//
//  main.swift
//  csv2
//
//  Created by Michael Salmon on 2021-02-16.
//

import Foundation

let command = getCommand()
if command.isHelp {
    help(command)
    exit(0)
}

var options = Options()
do {
    try options.getOpts(for: command)
} catch {
    print(error, to: &standardError)
    exit(1)
}
var defaults = options.defaults()

if options.debug != 0 {
    print(options, to: &standardError)
}

if options.version {
    print("""
        \(AppInfo.name): \(AppInfo.version) (\(AppInfo.branch):\(AppInfo.build)) Built at \(AppInfo.builtAt)
        """,
        to: &standardError
    )
    exit(0)
}

if options.shapenames {
    print(Shape.allNames())
} else if options.show.hasContent {
    showShape(shape: options.show, defaults: defaults, with: command, to: options.outName)
} else if options.bitmap.hasEntries {
    print(bitmap(options.bitmap))
} else if options.colourslist {
    showColoursList(defaults, namesList: false, with: command, to: options.outName)
} else if options.colournames {
    print(ColourTranslate.all.map { "\($0): \(ColourTranslate.lookup($0)!.hashRGBA)" }.joined(separator: "\n"))
} else if options.colournameslist {
    showColoursList(defaults, namesList: true, with: command, to: options.outName)
} else if options.dasheslist {
    showDashesList(defaults, with: command, to: options.outName)
} else {
    // use a csvName of - to mean use stdin
    if options.csvName == "-" { options.csvName = nil }

    if options.verbose && options.random.isEmpty {
        print(options.csvName ?? "Missing CSV file name, using stdin", to: &standardError)
        print(options.jsonName ?? "Missing JSON file name", to: &standardError)
    }

    let jsonSource = jsonURL(options)
    SearchPath.add(jsonSource)
    let settings = try? Settings.load(jsonSource)
    if options.debug &== 2 { print(settings ?? "Nil settings", to: &standardError) }

    trySpecialCases(settings)

    if options.csvName != nil { SearchPath.add(options.csvName!) }
    let csv = csvSelect(options, settings)
    if options.debug &== 4 { print(csv ?? "Nil csv", to: &standardError) }

    if csv == nil || csv!.colCt == 0 || csv!.rowCt == 0 || settings == nil {
        print("Error loading data.", to: &standardError)
        exit(1)
    }

    let plotter = command.plotter(settings: settings!)
    if options.debug &== 8 { print(plotter, to: &standardError) }

    let plot = Plot(csv!, settings!, plotter)
    plot.chartGen()

    output(plotter, to: options.outName)
}

/// Determine source of CSV data
/// - Parameters:
///   - opts: Options object
///   - settings: Settings object
/// - Returns: CSV object

private func csvSelect(_ opts: Options, _ settings: Settings?) -> CSV? {
    switch (opts.csvName != nil, opts.random.hasEntries) {
    case (_, true): return CSV(randomCSV(opts, settings))
    case (true, false): return try? CSV(URL(fileURLWithPath: opts.csvName!), separatedBy: opts.separator)
    case(false, false): return CSV(readLines(), separatedBy: opts.separator)
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

func output(_ plotter: Plotter, to name: String?) {
    if name == nil {
        plotter.plotPrint()
    } else {
        do {
            try plotter.plotWrite(to: URL(fileURLWithPath: name!))
        } catch {
            print(error, to: &standardError)
        }
    }
}

/// Try any special cases before proceeding
/// - Parameter settings: image settings

func trySpecialCases(_ settings: Settings?) {
    guard let settings = settings else { exit(1) }

    if options.canvastag {
        print(Canvas.canvasTag(settings))
        exit(0)
    }
}

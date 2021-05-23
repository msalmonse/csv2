//
//  ExecCommand.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-23.
//

import Foundation

func execCommand(_ main: MainCommandType, _ sub: SubCommandType, _ options: Options) {
    switch sub {
    case .none:
        plotCommand(main, sub, options)
    case .colourNames:
        showColoursList(options.defaults(), namesList: true, with: main, to: options.outName)
    case .colours:
        showColoursList(options.defaults(), namesList: false, with: main, to: options.outName)
    case .dashes:
        showDashesList(defaults, with: main, to: options.outName)
    case .shapes(let name):
        showShape(shape: name, defaults: defaults, with: main, to: options.outName)
    }
}

func plotCommand(_ main: MainCommandType, _ sub: SubCommandType, _ options: Options) {
    let jsonSource = jsonURL(options)
    SearchPath.add(jsonSource)
    let settings = try? Settings.load(jsonSource)
    if options.debug &== 2 { print(settings ?? "Nil settings", to: &standardError) }

    if options.csvName != nil { SearchPath.add(options.csvName!) }
    let csv = csvSelect(options, settings)
    if options.debug &== 4 { print(csv ?? "Nil csv", to: &standardError) }
    if csv == nil || csv!.colCt == 0 || csv!.rowCt == 0 || settings == nil {
        print("Error loading data.", to: &standardError)
        exit(1)
    }

    let plotter = main.plotter(settings: settings!)
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

/// Generate a list of all the colour names
/// - Returns: colour name list

func colourNames() -> String {
    return
        ColourTranslate.all.map { "\($0): \(ColourTranslate.lookup($0)!.hashRGBA)" }
        .sorted().joined(separator: "\n")
}

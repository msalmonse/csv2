//
//  ExecCommand.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-23.
//

import Foundation

func execCommand(_ cmd: CommandType, _ options: Options) {
    switch cmd {
    case .canvas, .canvastag, .pdf, .png, .svg:
        plotCommand(cmd, options)
    case .canvasColourNames, .canvastagColourNames, .pdfColourNames, .pngColourNames, .svgColourNames:
        showColoursList(options.defaults(), namesList: true, with: cmd, to: options.outName)
    case .canvasColours, .canvastagColours, .pdfColours, .pngColours, .svgColours:
        showColoursList(options.defaults(), namesList: false, with: cmd, to: options.outName)
    case .canvasDashes, .canvastagDashes, .pdfDashes, .pngDashes, .svgDashes:
        showDashesList(defaults, with: cmd, to: options.outName)
    case .canvasShape, .pdfShape, .pngShape, .svgShape:
        if CommandLine.arguments.count > 4 {
            let name = CommandLine.arguments[4]
            showShape(shape: name, defaults: defaults, with: cmd, to: options.outName)
        }
    case .canvastagShape:
        if CommandLine.arguments.count > 5 {
            let name = CommandLine.arguments[5]
            showShape(shape: name, defaults: defaults, with: cmd, to: options.outName)
        }
    case .listColourNames:
        print(colourNames())
    case .listShapes:
        print(Shape.allNames())
    default:
        print("Got command: \(cmd)", to: &standardError)
        help(cmd)
    }
}

func plotCommand(_ cmd: CommandType, _ options: Options) {
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

    let plotter = cmd.plotter(settings: settings!)
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

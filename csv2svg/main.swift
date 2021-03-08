//
//  main.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-16.
//

import Foundation

let options = Options.parseOrExit()

if options.version {
    print("\(AppInfo.name): \(AppInfo.version) (\(AppInfo.build)) Built at \(AppInfo.builtAt)",
          to: &standardError)
}

if options.files.count == 0 { exit(0) }

let csvName = options.files[0]
let jsonName = options.files.count > 1 ? options.files[1] : csvName + ".json"

if options.verbose {
    print(csvName, to: &standardError)
    print(jsonName, to: &standardError)
}

let settings = try? Settings.load(URL(fileURLWithPath: jsonName))

let csv = try? CSV(URL(fileURLWithPath: csvName))

if csv == nil || settings == nil {
    print("Error loading data.", to: &standardError)
    exit(1)
}

let svg = SVG(csv!, settings!)
_ = svg.gen().map { print($0) }

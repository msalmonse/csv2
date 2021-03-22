//
//  RandomCSV.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-21.
//

import Foundation

func randomCSV(_ opts: Options, _ settings: Settings?) -> [String] {
    let count = opts.random[0]
    var max: Double
    var min: Double

    switch opts.random.count {
    case 3:
        max = Double(opts.random[1])
        min = Double(opts.random[2])
    case 2:
        max = Double(opts.random[1])
        min = -max
    default:
        if settings == nil {
            max = 500
            min = -500
        } else {
            max = settings!.yMax != Defaults.maxDefault ? settings!.yMax : Double(settings!.height)
            min = settings!.yMin != Defaults.minDefault ? settings!.yMin : -max
        }
    }

    if opts.verbose {
        print("\(count) plots with data from \(min.f(2)) to \(max.f(2))", to: &standardError)
    }

    var result: [String] = []
    var y = (min + max)/2.0
    let ymax = max * 5.0
    let ymin = min * 5.0

    for _ in 0..<count {
        var row: [String] = []
        for _ in 0..<count {
            y += Double.random(in: min...max) * Double.random(in: -2.0...2.0)
            if y > ymax { y = ymax/2.0 }
            if y < ymin { y = ymin/2.0 }
            row.append(y.f(2))
        }
        result.append(row.joined(separator: ","))
    }
    return result
}
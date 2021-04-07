//
//  Readlines.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-10.
//

import Foundation

func readLines() -> [String] {
    var lines: [String] = []

    while let line = readLine(strippingNewline: true) {
        lines.append(line)
    }

    return lines
}

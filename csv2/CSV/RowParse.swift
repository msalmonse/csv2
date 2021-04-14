//
//  RowParse.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-14.
//

import Foundation

fileprivate enum ParserState: Comparable {
    case
        nocell,             // no cell data found, ros is empty or whitespace
        start,              // cell started
        normal,             // non-whitespace found
        qdfound,            // double quote found while quoted
        quoted              // quoted text started
}

func csvRowParse(row: String, separatedBy: String = ",") -> [String] {
    var result: [String] = []
    let data = row.unicodeScalars
    let colsep = separatedBy.unicodeScalars.first
    let cr = "\r".unicodeScalars.first
    let qd = "\"".unicodeScalars.first
    let nl = "\n".unicodeScalars.first
    let space = " ".unicodeScalars.first
    var state = ParserState.nocell
    var cell = ""
    var spaceCount = 0

    for ch in data {
        // handle copying to cell and next state
        switch (state, ch) {
        case (_, cr), (.start, space), (.nocell, space): break
        case (.quoted, colsep):
            cell.unicodeScalars.append(ch)
        case (_, colsep), (_, nl):
            if spaceCount > 0 { cell.unicodeScalars.removeLast(spaceCount) }
            result.append(cell)
            cell = ""
            state = .start
            spaceCount = 0
        case (.nocell, qd), (.start, qd), (.normal, qd): state = .quoted
        case (.quoted, qd): state = .qdfound
        case (.qdfound, qd):
            cell.unicodeScalars.append(ch)
            state = .quoted
        case (.qdfound, _):
            cell.unicodeScalars.append(ch)
            state = .normal
        case (.nocell, _), (.start, _):
            state = .normal
            cell.unicodeScalars.append(ch)
        default:
            cell.unicodeScalars.append(ch)
        }

        // handle spaceCount
        switch (state, ch) {
        case (.quoted, _): spaceCount = 0
        case (.normal, space): spaceCount += 1
        default:
            spaceCount = 0
        }
    }
    if state != .nocell {
        if spaceCount > 0 { cell.unicodeScalars.removeLast(spaceCount) }
        result.append(cell)
    }

    return result
}

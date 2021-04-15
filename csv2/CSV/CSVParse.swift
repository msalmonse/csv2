//
//  RowParse.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-14.
//

import Foundation

/// State of parser

fileprivate enum ParserState: Comparable {
    case
        lineStart,          // no field data found, row is empty or whitespace
        fieldStart,         // field started but no data found, like lineStart but at least one field already
        normal,             // non-whitespace found
        qdfound,            // double quote found while quoted
        quoted              // quoted text started
}

/// Parse csv string
/// - Parameters:
///   - inData: the string to parse
///   - separatedBy: field separator
///   - outData: Array of arrays to hold results

func csvParse(_ inData: String, separatedBy: String = ",", to outData: inout [[String]]) {
    let colsep = separatedBy.unicodeScalars.first
    let cr: UnicodeScalar = "\r"
    let qd: UnicodeScalar = "\""
    let nl: UnicodeScalar = "\n"
    let space: UnicodeScalar = " "
    var state = ParserState.lineStart
    var field = ""
    var spaceCount = 0              // count of potentially trailing spaces
    var lastRow = -1                // the index of the last row in outData
    var ws = CharacterSet()
    ws.insert(charactersIn: "\r\n ")

    // clean up output
    outData = []

    for ch in inData.unicodeScalars {
        // Valid data found so add a row?
        if state == .lineStart && !ws.contains(ch) {
            outData.append([])
            lastRow += 1
            assert(lastRow == outData.endIndex - 1, "outData indices don't match")
        }

        // handle copying to field and next state
        switch (state, ch) {
            // when quoted colsep, cr and nl are normal characters
        case (.quoted, colsep), (.quoted, cr), (.quoted, nl):
            field.unicodeScalars.append(ch)

            // skip carriage return, spaces at the start of a line or field, nl if we haven't started a field
        case (_, cr), (.fieldStart, space), (.lineStart, space), (.lineStart, nl):
            break

            // in every other state colsep terminates a cell, new line always terminates a cell
        case (_, colsep), (_, nl):
            if spaceCount > 0 { field.unicodeScalars.removeLast(spaceCount) }
            outData[lastRow].append(field)
            field = ""
            state = ch == nl ? .lineStart : .fieldStart
            spaceCount = 0

            // double quote normally puts us into quoted
        case (.lineStart, qd), (.fieldStart, qd), (.normal, qd): state = .quoted
            // while in quoted state a double quote may terminate the state or be an actual double quote
        case (.quoted, qd): state = .qdfound

            // two double quotes while quoted means a literal double quote
        case (.qdfound, qd):
            field.unicodeScalars.append(ch)
            state = .quoted
            // one means the end of the quote, append that character
        case (.qdfound, _):
            field.unicodeScalars.append(ch)
            state = .normal

            // if in nocell or start go to normal
        case (.lineStart, _), (.fieldStart, _):
            state = .normal
            field.unicodeScalars.append(ch)

            // otherwise just add the character to the cell
        default:
            field.unicodeScalars.append(ch)
        }

        // handle spaceCount
        switch (state, ch) {
        case (.quoted, _): spaceCount = 0
        case (.normal, space): spaceCount += 1
        default:
            spaceCount = 0
        }
    }
    if state != .lineStart {
        if spaceCount > 0 { field.unicodeScalars.removeLast(spaceCount) }
        outData[lastRow].append(field)
    }
}

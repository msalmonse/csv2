//
//  CSV.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-16.
//

import Foundation

class CSV: ReflectedStringConvertible, Equatable {

    static func == (lhs: CSV, rhs: CSV) -> Bool {
        return lhs.data == rhs.data
    }

    var data: [[String]] = []
    var values: [[Double?]] = []

    /// Number of rows and columns
    var colCt = 0
    var rowCt = 0

    /// Initialize CSV from a URL
    /// - Parameter url: location of data
    /// - Throws: whatever String throws

    init(_ url: URL, separatedBy colsep: String = ",") throws {
        do {
            try self.loadFromUrl(url, separatedBy: colsep)
        } catch {
            print(error, to: &standardError)
            throw(error)
        }
    }

    /// Initialize CSV from a String
    /// - Parameter contents: the data as a single string

    init(_ contents: String, separatedBy colsep: String = ",") {
        self.loadFrom(contents, separatedBy: colsep)
    }

    /// Initialize CSV from a String
    /// - Parameter lines: the data as an array of strings

    init(_ lines: [String], separatedBy colsep: String = ",") {
        self.loadFromLines(lines, separatedBy: colsep)
    }

    /// Return a column of values
    /// - Parameters:
    ///   - col: the column number
    ///   - from: the first row to fetch data from
    /// - Returns: list of values

    func columnValues(_ col: Int, from row1: Int = 0) -> [Double?] {
        var result: [Double?] = []

        for row in values[row1...] {
            if col < 0 || col >= row.count {
                result.append(nil)
            } else {
                result.append(row[col])
            }
        }

        return result
    }

    /// Calculate the min and max of a column
    /// - Parameters:
    ///   - col: the column number
    ///   - from: the first row to fetch data from
    ///   - initMin: the initial minimum value, usually from a previous run
    ///   - initMax: the initial maximum value, usually from a previous run
    /// - Returns: a tuple with the minimum and maximum values

    func columnMinMax(
        _ col: Int,
        from row1: Int = 0,
        min initMin: Double = Double.greatestFiniteMagnitude,
        max initMax: Double = -Double.greatestFiniteMagnitude
    ) -> (min: Double, max: Double) {
        var min = initMin
        var max = initMax

        for value in columnValues(col, from: row1) where value != nil {
            if min > value! { min = value! }
            if max < value! { max = value! }
        }

        return (min: min, max: max)
    }

    /// Return a row of values
    /// - Parameters:
    ///   - col: the row number
    ///   - from: the first column to fetch data from
    /// - Returns: list of values

    func rowValues(_ row: Int, from col1: Int = 0) -> [Double?] {
        var result: [Double?] = []

        if row >= 0 && row < values.count {
            result.append(contentsOf: values[row][col1...])
        }

        return result
    }

    /// Calculate the min and max of a row
    /// - Parameters:
    ///   - row: the column number
    ///   - from: the first row to fetch data from
    ///   - initMin: the initial minimum value, usually from a previous run
    ///   - initMax: the initial maximum value, usually from a previous run
    /// - Returns: a tuple with the minimum and maximum values

    func rowMinMax(
        _ row: Int,
        from col1: Int = 0,
        min initMin: Double = Double.greatestFiniteMagnitude,
        max initMax: Double = -Double.greatestFiniteMagnitude
    ) -> (min: Double, max: Double) {
        var min = initMin
        var max = initMax

        for value in rowValues(row, from: col1) where value != nil {
            if min > value! { min = value! }
            if max < value! { max = value! }
        }

        return (min: min, max: max)
    }

    /// Calculate the min and max of a row or column
    /// - Parameters:
    ///   - inColumns: use columnMinMax()?
    ///   - rc: the row or column number
    ///   - from: the first row to fetch data from
    ///   - initMin: the initial minimum value, usually from a previous run
    ///   - initMax: the initial maximum value, usually from a previous run
    /// - Returns: a tuple with the minimum and maximum values

    func minMax(
        _ inColumns: Bool,
        _ rc: Int,
        from col1: Int = 0,
        min initMin: Double = Double.greatestFiniteMagnitude,
        max initMax: Double = -Double.greatestFiniteMagnitude
    ) -> (min: Double, max: Double) {
        return inColumns
            ? columnMinMax(rc, from: col1, min: initMin, max: initMax)
            : rowMinMax(rc, from: col1, min: initMin, max: initMax)
    }

    /// Load data from a URL
    /// - Parameter url: data location
    /// - Throws: whatever String throws

    func loadFromUrl(_ url: URL, separatedBy colsep: String = ",") throws {
        do {
            loadFrom(try String(contentsOf: url), separatedBy: colsep)
        } catch {
            throw(error)
        }
    }

    /// Load data from a string
    /// - Parameter contents: the string containing data

    func loadFrom(_ contents: String, separatedBy colsep: String = ",") {
        loadFromLines(contents.components(separatedBy: "\n"), separatedBy: colsep)
    }

    /// Load data from a string array
    /// - Parameter lines: the string array containing data

    func loadFromLines(_ lines: [String], separatedBy colsep: String = ",") {
        var colMax = 0
        // Remove any leading or trailing unwanted characters
        let trimSet = CharacterSet.whitespacesAndNewlines.union(CharacterSet("\"".unicodeScalars))
        for row in lines where row != "" {
            let cols = row.components(separatedBy: colsep).map { $0.trimmingCharacters(in: trimSet)}
            data.append(cols)
            if cols.count > colMax { colMax = cols.count }
        }
        colCt = colMax
        rowCt = data.count

        for row in data {
            var valueRow: [Double?] = []
            for cell in row {
                let value = Double(cell)
                valueRow.append(value)
            }
            values.append(valueRow)
        }
    }
}

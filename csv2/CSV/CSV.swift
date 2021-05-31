//
//  CSV.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-16.
//

import Foundation
import CSVParser

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
            print(error.localizedDescription, to: &standardError)
            throw(error)
        }
    }

    /// Initialize CSV from a String
    /// - Parameter contents: the data as a single string

    init(_ contents: String, separatedBy colsep: String = ",") {
        self.loadFrom(contents, separatedBy: colsep)
    }

    /// Init CSV from an array of arrays of strings
    /// - Parameter data: strings array array

    init(_ data: [[String]]) {
        self.data = data
        colCt = data.map { $0.count }.reduce(0) { max($0, $1) }
        rowCt = data.count
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
        csvParse(contents, separatedBy: colsep, to: &data)
        colCt = data.map { $0.count }.reduce(0) { max($0, $1) }
        rowCt = data.count
    }

    /// Fill the values array from the data array.

    func valuesFill() {
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

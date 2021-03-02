//
//  CSV.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-16.
//

import Foundation

class CSV {
    var data: [[String]] = []
    var values: [[Double?]] = []
    
    /// Number of rows and columns
    var colCt = 0
    var rowCt = 0
    
    /// Initialize CSV from a URL
    /// - Parameter url: location of data
    /// - Throws: whatever String throws
    init(_ url: URL) throws {
        do {
            try self.loadFromUrl(url)
        } catch {
            throw(error)
        }
    }
    
    /// Initialize CSV from a String
    /// - Parameter contents: the data to load into the string

    init(_ contents: String){
        self.loadFrom(contents)
    }
    
    /// Return a column of values
    /// - Parameter col: column index
    /// - Returns: list of values
    
    func columnValues(_ col: Int) -> [Double?] {
        var result: [Double?] = []

        for row in values {
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
    ///   - initMin: the initial minimum value, usually from a previous run
    ///   - initMax: the initial maximum value, usually from a previous run
    /// - Returns: a tuple with the minimum and maximum values

    func columnMinMax(
        _ col: Int,
        min initMin: Double = Double.greatestFiniteMagnitude,
        max initMax: Double = -Double.greatestFiniteMagnitude
    ) -> (min: Double, max: Double) {
        var min = initMin
        var max = initMax

        for value in columnValues(col) {
            if value != nil {
                if min > value! { min = value! }
                if max < value! { max = value! }
            }
        }
        
        return (min: min, max: max)
    }

    /// Load data from a URL
    /// - Parameter url: data location
    /// - Throws: whatever String throws
    
    func loadFromUrl(_ url: URL) throws {
        do {
            loadFrom(try String(contentsOf: url))
        } catch {
            throw(error)
        }
    }
    
    /// Load data from a string
    /// - Parameter contents: the string containing data
    
    func loadFrom(_ contents: String) {
        var colMax = 0
        for row in contents.components(separatedBy: "\n") {
            let cols = row.components(separatedBy: ",")
            data.append(cols)
            if cols.count > colMax { colMax = cols.count }
        }
        colCt = colMax
        rowCt = data.count

        for row in data {
            var valueRow: [Double?] = []
            for cell in row {
                let value = Double(cell.replacingOccurrences(of: " ", with: ""))
                valueRow.append(value)
            }
            values.append(valueRow)
        }
    }
}

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
    
    init(_ name: String) throws {
        let url = URL(fileURLWithPath: name)
        do {
            try self.loadData(url)
        } catch {
            throw(error)
        }
    }
    
    // Calculate the min and max of a column
    func columnMinMax(
        _ col: Int,
        min initMin: Double = Double.greatestFiniteMagnitude,
        max initMax: Double = -Double.greatestFiniteMagnitude
    ) -> (min: Double, max: Double) {
        var min = initMin
        var max = initMax

        if col >= 0 {
            for row in values {
                if col < row.count {
                    if let value = row[col] {
                        if min > value { min = value }
                        if max < value { max = value }
                    }
                }
            }
        }
        
        return (min: min, max: max)
    }

    func loadData(_ url: URL) throws {
        do {
            let contents = try String(contentsOf: url)
            for row in contents.components(separatedBy: "\n") {
                let cols = row.components(separatedBy: ",")
                data.append(cols)
            }
        } catch {
            throw(error)
        }
        
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

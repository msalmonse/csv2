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

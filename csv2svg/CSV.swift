//
//  CSV.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-16.
//

import Foundation

class CSV {
    let url: URL
    
    var data: [[String]] = []
    
    init(_ name: String) throws {
        url = URL(fileURLWithPath: name)
        do {
            try self.loadData()
        } catch {
            throw(error)
        }
    }
    
    func loadData() throws {
        do {
            let contents = try String(contentsOf: url)
            for row in contents.components(separatedBy: "\n") {
                let cols = row.components(separatedBy: ",")
                data.append(cols)
            }
        } catch {
            throw(error)
        }
    }
}

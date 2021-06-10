//
//  SVGout.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-17.
//

import Foundation

extension SVG {

    /// Print the SVG data

    func plotPrint() {
        print(String(data: data, encoding: .utf8) ?? "")
    }

    /// Write the SVG data to a URL
    /// - Parameter url: location to write
    /// - Throws: any errors in writing

    func plotWrite(to url: URL) throws {
        try data.write(to: url)
    }
}

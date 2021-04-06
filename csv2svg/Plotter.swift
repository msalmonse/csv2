//
//  Plotter.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-04-05.
//

import Foundation

protocol Plotter {
    func plotHead() -> String
    func plotPath(_ points: [PathCommand], props: Properties) -> String
    func plotText(x: Double, y: Double, text: String, props: Properties) -> String
}

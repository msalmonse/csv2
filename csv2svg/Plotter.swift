//
//  Plotter.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-04-05.
//

import Foundation

/// The actual plotter used by the abstarct Plot class

protocol Plotter {
    func plotGroup(lines: String) -> String
    func plotHead(positions: Positions, plotPlane: Plane, propsList: PropertiesList) -> String
    func plotPath(_ points: [PathCommand], props: Properties) -> String
    func plotRect(x: Double, y: Double, w: Double, h: Double, rx: Double) -> String
    func plotTail() -> String
    func plotText(x: Double, y: Double, text: String, props: Properties) -> String
}

//
//  Plotter.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-05.
//

import Foundation

/// The actual plotter used by the abstarct Plot class

protocol Plotter {
    func plotGroup(lines: String) -> String
    func plotHead(positions: Positions, plotPlane: Plane, propsList: PropertiesList) -> String
    func plotPath(_ points: [PathCommand], props: Properties) -> String
    func plotRect(_ plane: Plane, rx: Double, props: Properties) -> String
    func plotTail() -> String
    func plotText(x: Double, y: Double, text: String, props: Properties) -> String
}

enum PlotterType {
    case js, svg
}

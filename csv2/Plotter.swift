//
//  Plotter.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-05.
//

import Foundation

/// The actual plotter used by the abstarct Plot class

protocol Plotter {
    func plotGroup(plotPlane: Plane, lines: String) -> String
    func plotHead(positions: Positions, plotPlane: Plane, propsList: PropertiesList) -> String
    func plotPath(_ points: [PathCommand], props: Properties, fill: Bool) -> String
    func plotRect(_ plane: Plane, rx: Double, props: Properties) -> String
    func plotTail() -> String
    func plotText(x: Double, y: Double, text: String, props: Properties) -> String
}

enum PlotterType {
    case canvas, svg

    func plotter(settings: Settings) -> Plotter {
        switch self {
        case .canvas: return Canvas(settings)
        case .svg: return SVG(settings)
        }
    }
}

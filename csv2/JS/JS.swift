//
//  JS.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-07.
//

import Foundation

class JS: Plotter {
    let settings: Settings

    init(_ settings: Settings) {
        self.settings = settings
    }

    func plotGroup(lines: String) -> String {
        return ""
    }

    func plotHead(positions: Positions, plotPlane: Plane, propsList: PropertiesList) -> String {
        return ""
    }

    func plotPath(_ points: [PathCommand], props: Properties) -> String {
        return ""
    }

    func plotRect(_ plane: Plane, rx: Double, props: Properties) -> String {
        return ""
    }

    func plotTail() -> String {
        return ""
    }

    func plotText(x: Double, y: Double, text: String, props: Properties) -> String {
        return ""
    }
}

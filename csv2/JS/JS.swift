//
//  JS.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-07.
//

import Foundation

class JS: Plotter {
    let settings: Settings

    var ctx = CTX()

    init(_ settings: Settings) {
        self.settings = settings
    }

    /// Generate a canvas tag
    /// - Parameter settings: Plot settings
    /// - Returns: Canvas tag

    static func canvasTag(_ settings: Settings) -> String {
        let id = settings.plotter.canvasID
        let w = settings.dim.width
        let h = settings.dim.height

        return "<canvas id=\"\(id)\" width=\"\(w)\" height=\"\(h)\"></canvas>"
    }
}

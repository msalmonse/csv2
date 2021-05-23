//
//  CanvasTag.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-22.
//

import Foundation

struct CanvasTag: Plotter {
    let settings: Settings

    init(_ settings: Settings) {
        self.settings = settings
    }

    /// Generate a canvas tag
    /// - Parameter settings: Plot settings
    /// - Returns: Canvas tag

    func canvasTag() -> String {
        let id = settings.plotter.canvasID
        let w = settings.dim.width
        let h = settings.dim.height

        return "<canvas id=\"\(id)\" width=\"\(w)\" height=\"\(h)\"></canvas>"
    }

    func plotClipStart(plotPlane: Plane) { return }

    func plotClipEnd() { return }

    func plotHead(positions: Positions, plotPlane: Plane, stylesList: StylesList) { return }

    func plotPath(_ path: Path, styles: Styles, fill: Bool) { return }

    func plotPrint() {
        print(canvasTag())
    }

    func plotTail() { return }

    func plotText(x: Double, y: Double, text: String, styles: Styles) { return }

    func plotWrite(to url: URL) throws {
        if let data = canvasTag().data(using: .utf8) {
            do {
                try data.write(to: url)
            } catch {
                throw(error)
            }
        }
    }
}

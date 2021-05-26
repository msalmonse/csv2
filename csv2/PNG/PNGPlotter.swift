//
//  PNGPlotter.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-18.
//

import Foundation
import AppKit

extension PNG {
    /// Start clipping to plotPlane
    /// - Parameter plotPlane: the plane for plots

    func plotClipStart(plotPlane: Plane) {
        clipRect =
            CGRect(x: plotPlane.left, y: plotPlane.top, width: plotPlane.width, height: plotPlane.height)
    }

    /// Stop clipping

    func plotClipEnd() {
        clipRect = nil
        ctx.resetClip()
    }

    /// Initialize anything before we start plotting
    /// - Parameters:
    ///   - positions: where to place things
    ///   - plotPlane: where the plots will go
    ///   - stylesList: all styles

    func plotHead(positions: Positions, plotPlane: Plane, stylesList: StylesList) {
        if settings.plotter.logoURL.hasContent {
            let logoPlane = Plane(
                left: positions.logoX, top: positions.logoY,
                height: settings.plotter.logoHeight,
                width: settings.plotter.logoWidth
            )
            cgLogo(logoPlane, from: settings.plotter.logoURL, to: ctx)
        }
    }

    /// Draw a path on the PNG
    /// - Parameters:
    ///   - components: a list of points and what to do
    ///   - styles: plot properties
    ///   - fill: fill or stroke?

    func plotPath(_ path: Path, styles: Styles, fill: Bool) {
        cgPlotPath(path, styles: styles, fill: fill, to: ctx, clippedBy: clipRect)
    }

    /// Draw the text at the place specified with the properties specified
    /// - Parameters:
    ///   - x: x position
    ///   - y: y position
    ///   - text: text to draw
    ///   - styles: properties

    func plotText(x: Double, y: Double, text: String, styles: Styles) {
        cgPlotText(xy: Point(x: x, y: y), text: text, styles: styles, to: ctx, height: height)
    }

    /// Print the chart, not applicable

    func plotPrint() {
        print("PNG needs an output file name.", to: &standardError)
        return
    }

    /// End the chart, nothing to do

    func plotTail() {
        return
    }
}

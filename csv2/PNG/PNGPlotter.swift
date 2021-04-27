//
//  PNGPlotter.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-18.
//

import Foundation

extension PNG {
    func plotClipStart(plotPlane: Plane) {
        clipRect =
            CGRect(x: plotPlane.left, y: plotPlane.top, width: plotPlane.width, height: plotPlane.height)
    }

    func plotClipEnd() {
        clipRect = nil
        image.withCGContext { ctx in
            ctx.resetClip()
        }
    }

    func plotHead(positions: Positions, plotPlane: Plane, stylesList: StylesList) {
        if settings.plotter.logoURL.hasContent {
            let logoPlane = Plane(
                left: positions.logoX, top: positions.logoY,
                height: settings.plotter.logoHeight,
                width: settings.plotter.logoWidth
            )
            logo(logoPlane, from: settings.plotter.logoURL)
        }
    }

    func plotPrint() {
        return
    }

    func plotRect(_ plane: Plane, rx: Double, styles: Styles) {
        return
    }

    func plotTail() {
        return
    }

    func plotWrite(to url: URL) throws {
        if let pngData = image.pngData() {
            do {
                try pngData.write(to: url)
            } catch {
                throw(error)
            }
        }
    }
}

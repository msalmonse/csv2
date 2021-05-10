//
//  PDFPlotter.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-09.
//

import Foundation

extension PDF {
    func plotClipStart(plotPlane: Plane) {
        page.add(action: .clipStart(plotPlane: plotPlane))
    }

    func plotClipEnd() {
        page.add(action: .clipEnd)
    }

    func plotHead(positions: Positions, plotPlane: Plane, stylesList: StylesList) {
        if settings.plotter.logoURL.hasContent {
            let logoPlane = Plane(
                left: positions.logoX, top: positions.logoY,
                height: settings.plotter.logoHeight,
                width: settings.plotter.logoWidth
            )
            page.add(action: .logo(logoPlane: logoPlane, from: settings.plotter.logoURL))
        }
    }

    func plotPath(_ path: Path, styles: Styles, fill: Bool) {
        page.add(action: .plot(path: path, styles: styles, fill: fill))
    }

    func plotPrint() {
        return
    }

    func plotTail() { return }

    func plotText(x: Double, y: Double, text: String, styles: Styles) {
        page.add(action: .text(x: x, y: y, text: text, styles: styles))
    }

    func plotWrite(to url: URL) throws {
        if let data = doc.dataRepresentation() {
            do {
                try data.write(to: url)
            } catch {
                throw(error)
            }
        }
    }
}

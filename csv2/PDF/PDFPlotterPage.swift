//
//  PDFPlotterPage.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-10.
//

import Foundation
import PDFKit

class PDFPlotterPage: PDFPage {
    var actions: [PDFActions] = []

    override init() { super.init() }

    override func draw(with box: PDFDisplayBox, to ctx: CGContext) {
        var clipRect: CGRect? = nil

        // flip coordinates
        ctx.scaleBy(x: 1.0, y: -1.0)
        ctx.translateBy(x: 0.0, y: -bounds(for: box).height)

        for action in actions {
            switch action {
            case let .bg(colour):
                // set background
                ctx.setFillColor(colour)
                ctx.fill(bounds(for: box))
            case .clipEnd:
                clipRect = nil
                ctx.resetClip()
            case let .clipStart(plotPlane):
                clipRect = CGRect(
                    x: plotPlane.left, y: plotPlane.top,
                    width: plotPlane.width, height: plotPlane.height
                )
            case let .logo(logoPlane, from):
                cgLogo(logoPlane, from: from, to: ctx)
            case let .plot(path, styles, fill):
                cgPlotPath(path, styles: styles, fill: fill, to: ctx, clippedBy: clipRect)
            case let .text(x, y, text, styles):
                cgPlotText(xy: Point(x: x, y: y), text: text, styles: styles, to: ctx,
                           height: Double(bounds(for: box).height)
                )
            }
        }
    }

    func add(action: PDFActions) { actions.append(action) }
}

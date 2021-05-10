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
    var height: CGFloat = 0.0
    var width: CGFloat = 0.0

    override init() { super.init() }

    override func setBounds(_ bounds: NSRect, for box: PDFDisplayBox) {
        super.setBounds(bounds, for: box)
        height = bounds.height
    }

    override func draw(with box: PDFDisplayBox, to ctx: CGContext) {
        var clipRect: CGRect? = nil

        // flip coordinates
        ctx.scaleBy(x: 1.0, y: -1.0)
        ctx.translateBy(x: 0.0, y: -height)

        for action in actions {
            switch action {
            case .bg(let colour):
                // set background
                ctx.setFillColor(colour)
                ctx.fill(CGRect(x: 0.0, y: 0.0, width: width, height: height))
            case .clipEnd:
                clipRect = nil
                ctx.resetClip()
            case .clipStart(let plotPlane):
                clipRect = CGRect(
                    x: plotPlane.left, y: plotPlane.top,
                    width: plotPlane.width, height: plotPlane.height
                )
            case .plot(let path, let styles, let fill):
                cgPlotPath(path, styles: styles, fill: fill, to: ctx, clippedBy: clipRect)
            case .text(let x, let y, let text, let styles):
                cgPlotText(x: x, y: y, text: text, styles: styles, to: ctx, height: Double(height))
            default:
                break
            }
        }
    }

    func add(action: PDFActions) { actions.append(action) }
}

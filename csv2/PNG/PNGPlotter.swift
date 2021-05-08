//
//  PNGPlotter.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-18.
//

import Foundation
import AppKit

extension PNG {
    func plotClipStart(plotPlane: Plane) {
        clipRect =
            CGRect(x: plotPlane.left, y: plotPlane.top, width: plotPlane.width, height: plotPlane.height)
    }

    func plotClipEnd() {
        clipRect = nil
        ctx.resetClip()
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
        // NSImage uses points for size so we rescale the image to match the intended size
        let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
        let scaleCtx = CGContext(
            data: nil,
            width: settings.dim.width,
            height: settings.dim.height,
            bitsPerComponent: cgImage.bitsPerComponent,
            bytesPerRow: cgImage.bytesPerRow,
            space: cgImage.colorSpace ?? CGColorSpace(name: CGColorSpace.sRGB)!,
            bitmapInfo: cgImage.bitmapInfo.rawValue
        )!
        scaleCtx.interpolationQuality = .high
        scaleCtx.draw(cgImage, in: CGRect(origin: .zero, size: image.size))
        let scaled = scaleCtx.makeImage()!

        let imageRep = NSBitmapImageRep(cgImage: scaled)
        if let pngData = imageRep.representation(using: .png, properties: [:]) {
            do {
                try pngData.write(to: url)
            } catch {
                throw(error)
            }
        }
    }
}

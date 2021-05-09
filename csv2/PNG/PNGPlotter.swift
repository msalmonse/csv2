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
            logo(logoPlane, from: settings.plotter.logoURL)
        }
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

    /// Write a CGImage to a file after convering to png
    /// - Parameters:
    ///   - cgImage: the image to write
    ///   - url: where to write
    /// - Throws: file writing errors

    private func cgImageWrite(_ cgImage: CGImage, to url: URL) throws {
        let imageRep = NSBitmapImageRep(cgImage: cgImage)
        if let pngData = imageRep.representation(using: .png, properties: [:]) {
            do {
                try pngData.write(to: url)
            } catch {
                throw(error)
            }
        }
    }

    /// Write the image to a file after converting to png format
    /// - Parameter url: where to write
    /// - Throws: any error to do with file writing

    func plotWrite(to url: URL) throws {
        do {
            let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
            if cgImage.width == settings.dim.width {
                try cgImageWrite(cgImage, to: url)
            } else {
                // NSImage uses points for size so we rescale the image to match the intended size
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
                try cgImageWrite(scaled, to: url)
            }
        } catch {
            throw(error)
        }
    }
}

//
//  PNGout.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-26.
//

import Foundation
import AppKit

extension PNG {

    /// Write a CGImage to a file after convering to png
    /// - Parameters:
    ///   - cgImage: the image to write
    ///   - url: where to write
    /// - Throws: file writing errors

    private func cgImageWrite(_ cgImage: CGImage, to url: URL) throws {
        let colourProfile = NSBitmapImageRep.PropertyKey.colorSyncProfileData
        let imageRep = NSBitmapImageRep(cgImage: cgImage)
        imageRep.setProperty(colourProfile, withValue: NSColorSpace.sRGB)
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

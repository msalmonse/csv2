//
//  CGlogo.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-20.
//

import Foundation
import AppKit

/// Draw an image on the PNG
/// - Parameters:
///   - logoPlane: the plane to receive the logo
///   - name: location of the logo

func cgLogo(_ logoPlane: Plane, from name: String, to ctx: CGContext) {
    if let url = URL(string: name) {
        do {
            let data = try Data(contentsOf: url)
            if let logoImage = NSImage(data: data),
               let cgLogo = logoImage.cgImage(forProposedRect: nil, context: nil, hints: nil) {
                // ctx is flipped so we need to flip the logo when drawing it
                ctx.saveGState()
                ctx.translateBy(x: 0, y: CGFloat(logoPlane.top + logoPlane.height))
                ctx.scaleBy(x: 1.0, y: -1.0)
                let logoRect =
                    CGRect(origin: CGPoint(x: logoPlane.left, y: 0.0), size: logoPlane.cgrect.size)
                ctx.draw(cgLogo, in: logoRect)
                ctx.restoreGState()
            }
        } catch {
            print(error, to: &standardError)
        }
    }
}

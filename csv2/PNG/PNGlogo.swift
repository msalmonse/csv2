//
//  PNGlogo.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-20.
//

import Foundation
import AppKit
import SwiftImage

extension PNG {

    private func alphaBlend(_ over: UInt8, _ under: UInt8, _ alpha: UInt8) -> UInt8 {
        let alpha = Double(alpha)/255.0
        let over = Double(over)/255.0
        let under = Double(under)/255.0
        let blend = over + under * (1 - alpha)
        return UInt8(min(round(blend * 256), 255))
    }

    func logo(_ plotPlane: Plane, from name: String) {
        let height = Int(plotPlane.height)
        let width = Int(plotPlane.width)
        if let url = URL(string: name) {
            do {
                let data = try Data(contentsOf: url)
                if var logoImage = Image<PremultipliedRGBA<UInt8>>(data: data) {
                    if logoImage.height != height || logoImage.width != width {
                        let newLogo = logoImage.resizedTo(width: width, height: height)
                            logoImage = newLogo
                    }
                    let xOffset = Int(plotPlane.left)
                    let yOffset = Int(plotPlane.top)
                    for row in 0..<logoImage.height {
                        for col in 0..<logoImage.width {
                            let logoPixel = logoImage[col, row]
                            let imgPixel = image[col + xOffset, row + yOffset]
                            let alpha = alphaBlend(logoPixel.alpha, imgPixel.alpha, logoPixel.alpha)
                            let red = alphaBlend(logoPixel.red, imgPixel.red, logoPixel.alpha)
                            let green = alphaBlend(logoPixel.green, imgPixel.green, logoPixel.alpha)
                            let blue = alphaBlend(logoPixel.blue, imgPixel.blue, logoPixel.alpha)
                            image[col + xOffset, row + yOffset] =
                                PremultipliedRGBA(red: red, green: green, blue: blue, alpha: alpha)
                        }
                    }
                }
            } catch {
                print(error, to: &standardError)
            }
        }
    }
}

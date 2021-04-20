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
        let blend = min(over + under * (1 - alpha), 1.0)
        return UInt8(round(blend * 255))
    }

    func logo(_ positions: Positions) {
        if let url = URL(string: settings.plotter.logoURL) {
            do {
                let data = try Data(contentsOf: url)
                if let logoImage = Image<PremultipliedRGBA<UInt8>>(data: data) {
                    let xOffset = Int(positions.logoX)
                    let yOffset = Int(positions.logoY)
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

//
//  StapleGet.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-11.
//

import Foundation

extension Plot {

    /// Get a Staple object if everything is OK
    /// - Parameters:
    ///   - xi: list of x values
    ///   - ts: TransScale object
    /// - Returns: Scale object if OK or nil

    func stapleGet(_ xi: [XIvalue]) -> Staple? {
        if Staple.count <= 0 { return nil }
        if settings.plot.stapleOffset >= 0.0 && settings.plot.stapleWidth > 0.0 {
            return Staple(offset: settings.plot.stapleOffset, width: settings.plot.stapleWidth)
        } else if settings.plot.stapleOffset >= 6.0 {
            return Staple(offset: settings.plot.stapleOffset, width: settings.plot.stapleOffset - 2.0)
        }
        let minδx = Staple.minSpan(xi, first: settings.headers)
        if minδx < 0.0 { return nil }
        let minδpixels = ts.xpos(minδx) - point00.x
        if !Staple.spanOK(minδpixels) { return nil }
        if settings.plot.stapleOffset >= 0.0 {
            return Staple(offset: settings.plot.stapleOffset, width: minδpixels - settings.plot.stapleOffset - 2.0)
        } else if settings.plot.stapleWidth > 0.0 {
            let offset = minδpixels/Double(Staple.count) - settings.plot.stapleWidth
            return Staple(offset: offset, width: settings.plot.stapleWidth)
        }
        return Staple(pixels: minδpixels)
    }
}

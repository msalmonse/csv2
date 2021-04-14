//
//  BarGet.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-11.
//

import Foundation

extension Plot {

    /// Get a Bar object if everything is OK
    /// - Parameters:
    ///   - xi: list of x values
    /// - Returns: Bar object if OK or nil

    func barGet(_ xi: [XIvalue]) -> Bar? {
        if Bar.count <= 0 { return nil }
        if settings.plot.barOffset >= 0.0 && settings.plot.barWidth > 0.0 {
            return Bar(offset: settings.plot.barOffset, width: settings.plot.barWidth)
        } else if settings.plot.barOffset >= 6.0 {
            return Bar(offset: settings.plot.barOffset, width: settings.plot.barOffset - 2.0)
        }
        let minδx = Bar.minSpan(xi, first: settings.headers)
        if minδx < 0.0 { return nil }
        let minδpixels = ts.xpos(minδx) - point00.x
        if !Bar.spanOK(minδpixels) { return nil }
        if settings.plot.barOffset >= 0.0 {
            return Bar(offset: settings.plot.barOffset, width: minδpixels - settings.plot.barOffset - 2.0)
        } else if settings.plot.barWidth > 0.0 {
            let offset = minδpixels/Double(Bar.count) - settings.plot.barWidth
            return Bar(offset: offset, width: settings.plot.barWidth)
        }
        return Bar(pixels: minδpixels)
    }
}

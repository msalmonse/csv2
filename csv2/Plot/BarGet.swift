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
        if Bar.none { return nil }
        let barOffset = settings.doubleValue(.barOffset)
        let barWidth = settings.doubleValue(.barWidth)
        let headers = settings.intValue(.headerColumns)

        if barOffset >= 0.0 && barWidth > 0.0 {
            return Bar(offset: barOffset, width: barWidth)
        } else if barOffset >= 6.0 {
            return Bar(offset: barOffset, width: barOffset - 2.0)
        }
        let minδx = Bar.minSpan(xi, first: headers)
        if minδx < 0.0 { return nil }
        let minδpixels = ts.xpos(minδx) - point00.x
        if !Bar.spanOK(minδpixels) { return nil }
        if barOffset >= 0.0 {
            return Bar(offset: barOffset, width: minδpixels - barOffset - 2.0)
        } else if barWidth > 0.0 {
            let offset = minδpixels / Double(Bar.count) - barWidth
            return Bar(offset: offset, width: barWidth)
        }
        return Bar(pixels: minδpixels)
    }
}

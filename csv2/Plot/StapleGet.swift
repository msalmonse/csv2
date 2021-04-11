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
    
    func stapleGet(_ xi: [XIvalue], _ ts: TransScale) -> Staple? {
        if Staple.count <= 0 { return nil }
        let minδx = Staple.minSpan(xi)
        if minδx < 0.0 { return nil }
        let minδpixels = ts.xpos(minδx) - ts.xpos(minδx)
        if !Staple.spanOK(minδpixels) { return nil }
        return Staple()
    }
}

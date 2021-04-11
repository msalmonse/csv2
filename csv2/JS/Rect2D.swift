//
//  Rect2D.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-11.
//

import Foundation

extension JS {
    /// Plot a rectangle
    /// - Parameters:
    ///   - plane: the 4 sides of the rectangle
    ///   - rx: corner radius
    ///   - props: rectangle properties
    /// - Returns: JS code to create rectangle

    func plotRect(_ plane: Plane, rx: Double, props: Properties) -> String {
        var result = [""]
        ctx.sync(props, &result)
        if rx == 0.0 {
            let x = plane.left.f(1)
            let y = plane.top.f(1)
            let w = plane.width.f(1)
            let h = plane.height.f(1)

            result.append("ctx.rect(\(x), \(y), \(w), \(h))")
            result.append("ctx.stroke()")
        } else {
            let l = plane.left.f(1)
            let t = plane.top.f(1)
            let r = plane.right.f(1)
            let b = plane.bottom.f(1)
            let lq = (plane.left + rx).f(1)
            let rq = (plane.right - rx).f(1)
            let tq = (plane.top + rx).f(1)
            let bq = (plane.bottom - rx).f(1)

            let path = "M \(rq),\(t) Q \(r),\(t),\(r),\(tq) L \(r),\(bq) Q \(r),\(b),\(rq),\(b) L \(lq),\(b) Q \(l),\(b),\(l),\(bq) L \(l),\(tq) Q \(l),\(t),\(lq),\(t) Z"
            result.append("p = new Path2D('\(path)')")
            result.append("ctx.stroke(p)")
        }
        return result.joined(separator: "\n    ")
    }
}

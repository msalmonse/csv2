//
//  Rect.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-20.
//

import Foundation

extension Plot {

    /// Plot a rectangle
    /// - Parameters:
    ///   - plane: the 4 sides of the rectangle
    ///   - rx: corner radius
    /// - Returns: path to create rectangle

    func rectPath(_ plane: Plane, rx: Double) -> Path {
        if rx == 0.0 {
            return Path([
                .moveTo(x: plane.left, y: plane.vMid),
                .vertTo(y: plane.top),
                .horizTo(x: plane.right),
                .vertTo(y: plane.bottom),
                .horizTo(x: plane.left),
                .z
            ])
        } else {
            let left = plane.left
            let top = plane.top
            let right = plane.right
            let bottom = plane.bottom
            // Start and end points of bezier curves.
            let lq = min(plane.hMid, left + rx)
            let rq = max(plane.hMid, right - rx)
            let tq = min(plane.vMid, top + rx)
            let bq = max(plane.vMid, bottom - rx)

            return Path([
                .moveTo(x: rq, y: top),
                .qBezierTo(x: right, y: tq, cx: right, cy: top),
                .lineTo(x: right, y: bq),
                .qBezierTo(x: rq, y: bottom, cx: right, cy: bottom),
                .lineTo(x: lq, y: bottom),
                .qBezierTo(x: left, y: bq, cx: left, cy: bottom),
                .lineTo(x: left, y: tq),
                .qBezierTo(x: lq, y: top, cx: left, cy: top),
                .z
            ])
        }
    }
}

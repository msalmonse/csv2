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
                .moveTo(xy: Point(x: plane.left, y: plane.vMid)),
                .vertTo(y: plane.top),
                .horizTo(x: plane.right),
                .vertTo(y: plane.bottom),
                .horizTo(x: plane.left),
                .closePath
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
                .moveTo(xy: Point(x: rq, y: top)),
                .qBezierTo(xy: Point(x: right, y: tq), cxy: Point(x: right, y: top)),
                .lineTo(xy: Point(x: right, y: bq)),
                .qBezierTo(xy: Point(x: rq, y: bottom), cxy: Point(x: right, y: bottom)),
                .lineTo(xy: Point(x: lq, y: bottom)),
                .qBezierTo(xy: Point(x: left, y: bq), cxy: Point(x: left, y: bottom)),
                .lineTo(xy: Point(x: left, y: tq)),
                .qBezierTo(xy: Point(x: lq, y: top), cxy: Point(x: left, y: top)),
                .closePath
            ])
        }
    }
}

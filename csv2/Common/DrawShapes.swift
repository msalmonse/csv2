//
//  DrawShapes.swift
//  csv2
//
//  Created by Michael Salmon on 2021-03-11.
//

import Foundation

extension PathCommand {

    /// Generate a bar
    /// - Parameters:
    ///   - p0: the origin
    ///   - w: width of the bar
    ///   - y: top or bottom of the bar
    /// - Returns: path to create the bar

    func drawBar(p0: Point, w: Double, y: Double) -> [PathCommand] {
        let x0 = p0.x
        let y0 = p0.y
        let left = x0 - w/2.0
        let right = left + w
        let r = w/32.0
        return [
            PathCommand.moveTo(x: x0, y: y0),
            .horizTo(x: left),
            .vertTo(y: y + r),
            .qBezierTo(x: left + r, y: y, cx: left, cy: y),
            .horizBy(dx: w - 2.0 * r),
            .qBezierTo(x: right, y: y + r, cx: right, cy: y),
            .vertTo(y: y0),
            .z
        ]
    }

    /// Generate a blade shape
    /// - Parameter w: the width
    /// - Returns: path  for a blade

    func drawBlade(w: Double) -> [PathCommand] {
        let half = w/2.0
        return [
            Self.moveBy(dx: -half, dy: half/2.0),
            .lineBy(dx: -half, dy: -w),
            .vertBy(dy: -half),
            .horizBy(dx: half),
            .lineBy(dx: w, dy: w),
            .lineBy(dx: half, dy: w),
            .vertBy(dy: half),
            .horizBy(dx: -half),
            .lineBy(dx: -w, dy: -w),
            .moveBy(dx: half, dy: -half/2.0)
        ]
    }

    /// Generate a circle
    /// - Parameter r: the radius
    /// - Returns: path  for a circle

    func drawCircle(r: Double) -> [PathCommand] {
        let r = r * 1.2
        return [
            Self.moveBy(dx: 0, dy: -r),
            .qBezierBy(dx: r, dy: r, cdx: r, cdy: 0.0),
            .qBezierBy(dx: -r, dy: r, cdx: 0.0, cdy: r),
            .qBezierBy(dx: -r, dy: -r, cdx: -r, cdy: 0.0),
            .qBezierBy(dx: r, dy: -r, cdx: 0.0, cdy: -r),
            .moveBy(dx: 0, dy: r)
        ]
    }

    /// Generate a stared circle
    /// - Parameter r: the radius
    /// - Returns: path  for a circle

    func drawCircleStar(w: Double) -> [PathCommand] {
        return drawStar(w: w) + drawCircle(r: w)
    }

    /// Generate a cross shape
    /// - Parameter w: the width
    /// - Returns: path  for a cross

    func drawCross(w: Double) -> [PathCommand] {
        let full = w * 0.4
        let half = full * 0.5
        return [
            Self.moveBy(dx: -full - half, dy: 0.0),
            // left
            .lineBy(dx: -full, dy: -half),
            .vertBy(dy: full),
            .lineBy(dx: full, dy: -half),
            .moveBy(dx: full + half, dy: -full - half),
            // top
            .lineBy(dx: -half, dy: -full),
            .horizBy(dx: full),
            .lineBy(dx: -half, dy: full),
            .moveBy(dx: full + half, dy: full + half),
            // right
            .lineBy(dx: full, dy: -half),
            .vertBy(dy: full),
            .lineBy(dx: -full, dy: -half),
            .moveBy(dx: -full - half, dy: full + half),
            // bottom
            .lineBy(dx: -half, dy: full),
            .horizBy(dx: full),
            .lineBy(dx: -half, dy: -full),
            .moveBy(dx: 0.0, dy: -full)
        ]
    }

    /// Generate a diamond shape
    /// - Parameter w: the width
    /// - Returns: path  for a diamond

    func drawDiamond(w: Double) -> [PathCommand] {
        let half = w * 0.625
        let full = half + half
        return [
            Self.moveBy(dx: -full, dy: 0.0),
            .lineBy(dx: full, dy: -full),
            .lineBy(dx: full, dy: full),
            .lineBy(dx: -full, dy: full),
            .lineBy(dx: -full, dy: -full),
            .lineBy(dx: half, dy: -half),
            .moveBy(dx: half, dy: half)
        ]
    }

    /// Generate a shuriken shape
    /// - Parameter w: the width
    /// - Returns: path  for a shuriken

    func drawShuriken(w: Double) -> [PathCommand] {
        let half = w/2.0
        return [
            Self.moveBy(dx: -half, dy: -half),
            .lineBy(dx: -half, dy: -half), .horizBy(dx: half), .lineBy(dx: w, dy: half),
            .lineBy(dx: half, dy: -half), .vertBy(dy: half), .lineBy(dx: -half, dy: w),
            .lineBy(dx: half, dy: half), .horizBy(dx: -half), .lineBy(dx: -w, dy: -half),
            .lineBy(dx: -half, dy: half), .vertBy(dy: -half), .lineBy(dx: half, dy: -w)
,            .moveBy(dx: half, dy: half)
        ]
    }

    /// Generate a square
    /// - Parameter w: the width
    /// - Returns: path  for a square

    func drawSquare(w: Double) -> [PathCommand] {
        let w2 = w * 2.0
        return [
            Self.moveBy(dx: -w, dy: -w),
            .horizBy(dx: w2),
            .vertBy(dy: w2),
            .horizBy(dx: -w2),
            .vertBy(dy: -w2),
            .horizBy(dx: w),
            .moveBy(dx: 0.0, dy: w)
        ]
    }

    /// Generate a star shape
    /// - Parameter w: the width
    /// - Returns: path  for a star

    func drawStar(w: Double) -> [PathCommand] {
        let half = w/2.0
        return [
            Self.moveBy(dx: -half, dy: 0.0),
            .lineBy(dx: -half, dy: -w), .lineBy(dx: w, dy: half),
            .lineBy(dx: w, dy: -half), .lineBy(dx: -half, dy: w),
            .lineBy(dx: half, dy: w), .lineBy(dx: -w, dy: -half),
            .lineBy(dx: -w, dy: half), .lineBy(dx: half, dy: -w),
            .moveBy(dx: half, dy: 0.0)
        ]
    }

    /// Generate a triangle
    /// - Parameter w: the width
    /// - Returns: path  for a triangle

    func drawTriangle(w: Double) -> [PathCommand] {
        let w2 = w * 2.0
        let half = w/2.0
        return [
            Self.moveBy(dx: 0.0, dy: -w),
            .lineBy(dx: w, dy: w2),
            .horizBy(dx: -w2),
            .lineBy(dx: w, dy: -w2),
            .lineBy(dx: half, dy: w),
            .moveBy(dx: -half, dy: 0.0)
        ]
    }
}

//
//  DrawShapes.swift
//  csv2
//
//  Created by Michael Salmon on 2021-03-11.
//

import Foundation

extension PathComponent {

    /// Draw an arc
    /// - Parameters:
    ///   - centre: centre of arc
    ///   - radius: radius of arc
    ///   - start: start angle
    ///   - end: end angle
    ///   - cw: draw clockwise
    ///   - onPath: path already started
    /// - Returns: path string

    // swiftlint:disable:next function_parameter_count
    func drawArc(centre: Point, radius: Double, start: Double, end: Double, cw: Bool, onPath: Bool) -> String {
        let startPoint = centre + Vector(length: radius, angle: start)
        let endPoint = centre + Vector(length: radius, angle: end)
        let largeSweep: String
        if cw {
            largeSweep = ((end - start) >= Double.pi) ? "1,0" : "0,0"
        } else {
            largeSweep = ((start - end) >= Double.pi) ? "1,1" : "0,1"
        }
        let toStart: PathComponent
        if onPath {
            toStart = PathComponent.lineTo(xy: startPoint)
        } else {
            toStart = PathComponent.moveTo(xy: startPoint)
        }
        return
            toStart.path + PathComponent.arcTo(end: endPoint, r: radius, largeSweep: largeSweep).path
    }

    /// Draw a relative arc
    /// - Parameters:
    ///   - centre: offset to centre of arc
    ///   - radius: radius of arc
    ///   - start: start angle
    ///   - end: end angle
    ///   - cw: draw clockwise
    /// - Returns: path string

    func drawArcRelative(centre: Vector, radius: Double, start: Double, end: Double, cw: Bool) -> String {
        let endPoint = centre + Vector(length: radius, angle: end)
        let largeSweep: String
        if cw {
            largeSweep = ((end - start) >= Double.pi) ? "1,0" : "0,0"
        } else {
            largeSweep = ((start - end) >= Double.pi) ? "1,1" : "0,1"
        }
        return PathComponent.arcBy(end: endPoint, r: radius, largeSweep: largeSweep).path
    }

    /// Generate a bar
    /// - Parameters:
    ///   - p0: the origin
    ///   - w: width of the bar
    ///   - y: top or bottom of the bar
    /// - Returns: path to create the bar

    func drawBar(p0: Point, w: Double, y: Double) -> Path {
        let x0 = p0.x
        let y0 = p0.y
        let left = x0 - w / 2.0
        let right = left + w
        let r = w / 32.0
        return Path([
            PathComponent.moveTo(xy: p0),
            .horizTo(x: left),
            .vertTo(y: y + r),
            .qBezierTo(xy: Point(x: left + r, y: y), cxy: Point(x: left, y: y)),
            .horizBy(dx: w - 2.0 * r),
            .qBezierTo(xy: Point(x: right, y: y + r), cxy: Point(x: right, y: y)),
            .vertTo(y: y0),
            .closePath
        ])
    }

    /// Generate a blade shape
    /// - Parameter w: the width
    /// - Returns: path  for a blade

    func drawBlade(w: Double) -> Path {
        let half = w / 2.0
        return Path([
             Self.moveBy(dxy: Vector(dx: -half, dy: half / 2.0)),
            .lineBy(dxy: Vector(dx: -half, dy: -w)),
            .vertBy(dy: -half),
            .horizBy(dx: half),
            .lineBy(dxy: Vector(dx: w, dy: w)),
            .lineBy(dxy: Vector(dx: half, dy: w)),
            .vertBy(dy: half),
            .horizBy(dx: -half),
            .lineBy(dxy: Vector(dx: -w, dy: -w)),
            .moveBy(dxy: Vector(dx: half, dy: -half / 2.0))
        ])
    }

    /// Generate a circle
    /// - Parameter r: the radius
    /// - Returns: path  for a circle

    func drawCircle(r: Double) -> Path {
        let r = r * 1.2
        return Path([
            Self.moveBy(dxy: Vector(dx: r, dy: 0)),
            .arcRelative(centre: Vector(dx: -r, dy: 0), radius: r, start: 0, end: 2.5, cw: true),
            .arcRelative(centre: Vector(length: -r, angle: 2.5), radius: r, start: 2.5, end: 5, cw: true),
            .arcRelative(centre: Vector(length: -r, angle: 5), radius: r, start: 5, end: 6.5, cw: true),
            .moveBy(dxy: Vector(dx: -r, dy: 0))
        ])
    }

    /// Generate a stared circle
    /// - Parameter r: the radius
    /// - Returns: path  for a circle

    func drawCircleStar(w: Double) -> Path {
        return drawStar(w: w) + drawCircle(r: w)
    }

    /// Generate a cross shape
    /// - Parameter w: the width
    /// - Returns: path  for a cross

    func drawCross(w: Double) -> Path {
        let full = w * 0.4
        let half = full * 0.5
        return Path([
            Self.moveBy(dxy: Vector(dx: -full - half, dy: 0.0)),
            // left
            .lineBy(dxy: Vector(dx: -full, dy: -half)),
            .vertBy(dy: full),
            .lineBy(dxy: Vector(dx: full, dy: -half)),
            .moveBy(dxy: Vector(dx: full + half, dy: -full - half)),
            // top
            .lineBy(dxy: Vector(dx: -half, dy: -full)),
            .horizBy(dx: full),
            .lineBy(dxy: Vector(dx: -half, dy: full)),
            .moveBy(dxy: Vector(dx: full + half, dy: full + half)),
            // right
            .lineBy(dxy: Vector(dx: full, dy: -half)),
            .vertBy(dy: full),
            .lineBy(dxy: Vector(dx: -full, dy: -half)),
            .moveBy(dxy: Vector(dx: -full - half, dy: full + half)),
            // bottom
            .lineBy(dxy: Vector(dx: -half, dy: full)),
            .horizBy(dx: full),
            .lineBy(dxy: Vector(dx: -half, dy: -full)),
            .moveBy(dxy: Vector(dx: 0.0, dy: -full))
        ])
    }

    /// Generate a diamond shape
    /// - Parameter w: the width
    /// - Returns: path  for a diamond

    func drawDiamond(w: Double) -> Path {
        let half = w * 0.625
        let full = half + half
        return Path([
            Self.moveBy(dxy: Vector(dx: -full, dy: 0.0)),
            .lineBy(dxy: Vector(dx: full, dy: -full)),
            .lineBy(dxy: Vector(dx: full, dy: full)),
            .lineBy(dxy: Vector(dx: -full, dy: full)),
            .lineBy(dxy: Vector(dx: -full, dy: -full)),
            .lineBy(dxy: Vector(dx: half, dy: -half)),
            .moveBy(dxy: Vector(dx: half, dy: half))
        ])
    }

    /// Generate a shuriken shape
    /// - Parameter w: the width
    /// - Returns: path  for a shuriken

    func drawShuriken(w: Double) -> Path {
        let half = w / 2.0
        return Path([
            Self.moveBy(dxy: Vector(dx: -half, dy: -half)),
            //
            .lineBy(dxy: Vector(dx: -half, dy: -half)),
            .horizBy(dx: half),
            .lineBy(dxy: Vector(dx: w, dy: half)),
            //
            .lineBy(dxy: Vector(dx: half, dy: -half)),
            .vertBy(dy: half),
            .lineBy(dxy: Vector(dx: -half, dy: w)),
            //
            .lineBy(dxy: Vector(dx: half, dy: half)),
            .horizBy(dx: -half),
            .lineBy(dxy: Vector(dx: -w, dy: -half)),
            //
            .lineBy(dxy: Vector(dx: -half, dy: half)),
            .vertBy(dy: -half),
            .lineBy(dxy: Vector(dx: half, dy: -w)),
            //
            .moveBy(dxy: Vector(dx: half, dy: half))
        ])
    }

    /// Generate a square
    /// - Parameter w: the width
    /// - Returns: path  for a square

    func drawSquare(w: Double) -> Path {
        let w2 = w * 2.0
        return Path([
            Self.moveBy(dxy: Vector(dx: -w, dy: -w)),
            .horizBy(dx: w2),
            .vertBy(dy: w2),
            .horizBy(dx: -w2),
            .vertBy(dy: -w2),
            .horizBy(dx: w),
            .moveBy(dxy: Vector(dx: 0.0, dy: w))
        ])
    }

    /// Generate a star shape
    /// - Parameter w: the width
    /// - Returns: path  for a star

    func drawStar(w: Double) -> Path {
        let half = w / 2.0
        return Path([
            Self.moveBy(dxy: Vector(dx: -half, dy: 0.0)),
            .lineBy(dxy: Vector(dx: -half, dy: -w)), .lineBy(dxy: Vector(dx: w, dy: half)),
            .lineBy(dxy: Vector(dx: w, dy: -half)), .lineBy(dxy: Vector(dx: -half, dy: w)),
            .lineBy(dxy: Vector(dx: half, dy: w)), .lineBy(dxy: Vector(dx: -w, dy: -half)),
            .lineBy(dxy: Vector(dx: -w, dy: half)), .lineBy(dxy: Vector(dx: half, dy: -w)),
            .moveBy(dxy: Vector(dx: half, dy: 0.0))
        ])
    }

    /// Generate a triangle
    /// - Parameter w: the width
    /// - Returns: path  for a triangle

    func drawTriangle(w: Double) -> Path {
        let w2 = w * 2.0
        let half = w / 2.0
        return Path([
            Self.moveBy(dxy: Vector(dx: 0.0, dy: -w)),
            .lineBy(dxy: Vector(dx: w, dy: w2)),
            .horizBy(dx: -w2),
            .lineBy(dxy: Vector(dx: w, dy: -w2)),
            .lineBy(dxy: Vector(dx: half, dy: w)),
            .moveBy(dxy: Vector(dx: -half, dy: 0.0))
        ])
    }
}

//
//  PathComponent.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-22.
//

import Foundation

/// path components

/// Enum describing the ways a path can be drawn

enum PathComponent {
    case
        arcTo(end: Point, r: Double, large: Bool),  // Draw an arc to end with radius r
        arcAround(centre: Point, radius: Double, start: Double, end: Double),
                                    // Draw an arc at centre with radius from start angle to end
        bar(p0: Point, w: Double, y: Double),       // Draw a bar w wide from p0 to y
        blade(w: Double),                           // Draw a blade of width 2 * w
        cBezierBy(dxy: Vector, c1dxy: Vector, c2dxy: Vector),
                                    // Draw cubic bezier curve by dx,dy with contol points c1dx,c1dy & c2dx,c2dy
        cBezierTo(xy: Point, c1xy: Point, c2xy: Point),
                                    // Draw cubic bezier curve to x,y with contol points c1x,c1y & c2x,c2y
        circle(r: Double),                          // Draw a circle of radius r
        circleStar(w: Double),                      // Draw a stared circle of width 2*w
        cross(w: Double),                           // a cross of width 2 * w
        diamond(w: Double),                         // a diamond of width 2 * w
        horizBy(dx: Double),                        // Draw line horizontally by dx
        horizTo(x: Double),                         // Draw line horizontally to x
        lineBy(dxy: Vector),                        // Draw line by dx,dy
        lineTo(xy: Point),                          // Draw line to x,y
        moveBy(dxy: Vector),                        // Move by dx and dy
        moveTo(xy: Point),                          // Move absolute to x,y
        qBezierBy(dxy: Vector, cdxy: Vector),
                                    // Draw quadratic bezier curve by dx,dy with control point cdx,cdy
        qBezierTo(xy: Point, cxy: Point),       // Draw quadratic bezier curve to x,y with control point cx,cy
        shuriken(w: Double),                        // Draw shuriken
        square(w: Double),                          // Draw a square with sides 2 * w
        star(w: Double),                            // Draw a star of width 2 * w
        triangle(w: Double),                        // Draw a triangle of width 2 * w
        vertBy(dy: Double),                         // Draw line vertically by dy
        vertTo(y: Double),                          // Draw line vertically to y
        z                                           // close path

    /// Convert a command into a path string
    /// - Returns: path string

    var path: String {
        switch self {
        case .arcAround(let c, let r, let s, let e):
            return drawArc(centre: c, radius: r, start: s, end: e)
        case .arcTo(let end, let r, let l):
            return " A \(r.f(1)),\(r.f(1)) 0,\(l ? "1" : "0"),0 \(end.x.f(1)),\(end.y.f(1))"
        case .cBezierBy(let dxy, let c1dxy, let c2dxy):
            return "c \(c1dxy.f(1)) \(c2dxy.f(1)) \(dxy.f(1))"
        case .cBezierTo(let xy, let c1xy, let c2xy):
            return "C \(c1xy.f(1)) \(c2xy.f(1))) \(xy.f(1))"
        case .moveBy(let dxy): return "m \(dxy.f(1))"
        case .moveTo(let xy): return "M \(xy.f(1))"
        case .horizBy(let dx): return "h \(dx.f(1))"
        case .horizTo(let x): return "H \(x.f(1))"
        case .lineBy(let dxy): return "l \(dxy.f(1))"
        case .lineTo(let xy): return "L \(xy.f(1))"
        case .qBezierBy(let dxy, let cdxy):
            return "q \(cdxy.f(1)), \(dxy.f(1))"
        case .qBezierTo(let xy, let cxy):
            return "Q \(cxy.f(1)), \(xy.f(1))"
        case .vertBy(let dy): return "v \(dy.f(1))"
        case .vertTo(let y): return "V \(y.f(1))"
        case .z: return "Z"
        default:
            return self.expand!.path
        }
    }

    /// Expand multi part commands
    /// - Returns: a list of commands or nil

    var expand: Path? {
        switch self {
        case .bar(let p0, let w, let y): return drawBar(p0: p0, w: w, y: y)
        case .blade(let w): return drawBlade(w: w)
        case .circle(let r): return drawCircle(r: r)
        case .circleStar(let w): return drawCircleStar(w: w)
        case .cross(let w): return drawCross(w: w)
        case .diamond(let w): return drawDiamond(w: w)
        case .shuriken(let w): return drawShuriken(w: w)
        case .square(let w): return drawSquare(w: w)
        case .star(let w): return drawStar(w: w)
        case .triangle(let w): return drawTriangle(w: w)
        default: return nil
        }
    }
}

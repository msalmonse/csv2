//
//  PNGpath.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-18.
//

import Foundation

extension PNG {

    /// Plot a single path component which may be a multi-component component
    /// - Parameters:
    ///   - ctx: context
    ///   - component: current command
    ///   - current: current position

    private func plotComponent(_ ctx: CGContext, component: PathComponent, current: inout CGPoint) {
        if let path = component.expand {
            for component in path.components {
                plotComponent(ctx, component: component, current: &current)
            }
        } else {
            switch component {
            case .arcAround(let c, let r, let s, let e):
                ctx.addArc(
                    center: c.cgpoint, radius: CGFloat(r),
                    startAngle: CGFloat(s), endAngle: CGFloat(e),
                    clockwise: false
                )
            case .cBezierBy(let dxy, let c1dxy, let c2dxy):
                let end = current + dxy.cgvector
                let control1 = current + c1dxy.cgvector
                let control2 = current + c2dxy.cgvector
                ctx.addCurve(to: end, control1: control1, control2: control2)
                current = end
            case .cBezierTo(let xy, let c1xy, let c2xy):
                let end = xy.cgpoint
                ctx.addCurve(to: end, control1: c1xy.cgpoint, control2: c2xy.cgpoint)
                current = end
            case .horizBy(let dx):
                current += CGVector(dx: dx, dy: 0.0)
                ctx.addLine(to: current)
            case .horizTo(let x):
                current = CGPoint(x: CGFloat(x), y: current.y)
                ctx.addLine(to: current)
            case .lineBy(let dxy):
                current += dxy.cgvector
                ctx.addLine(to: current)
            case .lineTo(let xy):
                current = xy.cgpoint
                ctx.addLine(to: current)
            case .moveBy(let dxy):
                current += dxy.cgvector
                ctx.move(to: current)
            case .moveTo(let xy):
                current = xy.cgpoint
                ctx.move(to: current)
            case .qBezierBy(let dxy, let cdxy):
                let end = current + dxy.cgvector
                let control = current + cdxy.cgvector
                ctx.addQuadCurve(to: end, control: control)
                current = end
            case .qBezierTo(let xy, let cxy):
                let end = xy.cgpoint
                let control = cxy.cgpoint
                ctx.addQuadCurve(to: end, control: control)
                current = end
            case .vertBy(let dy):
                current += CGVector(dx: 0.0, dy: dy)
                ctx.addLine(to: current)
            case .vertTo(let y):
                current = CGPoint(x: current.x, y: CGFloat(y))
                ctx.addLine(to: current)
            case .z:
                ctx.closePath()
            default:
                print("\(component) not implemented", to: &standardError)
            }
        }
    }

    /// Draw a path on the PNG
    /// - Parameters:
    ///   - components: a list of points and what to do
    ///   - styles: plot properties
    ///   - fill: fill or stroke?

    func plotPath(_ path: Path, styles: Styles, fill: Bool) {
        let colour = RGBAu8(styles.cascade(fill ? .fill : .colour), or: .black)
        let lineWidth = CGFloat(styles.cascade(.strokeWidth))
        image.withCGContext { ctx in
            if let clipRect = clipRect { ctx.clip(to: clipRect)}
            var current = CGPoint.zero
            ctx.setLineWidth(lineWidth)
            ctx.setLineCap(stylesCap(styles))
            if let dashes = styles.cascade(.dash) {
                ctx.setLineDash(phase: 0.0, lengths: dashParse(dashes))
            } else {
                ctx.setLineDash(phase: 0.0, lengths: [])
            }
            for component in path.components {
                plotComponent(ctx, component: component, current: &current)
            }
            if fill {
                ctx.setFillColor(colour.cgColor)
                ctx.fillPath()
            } else {
                ctx.setStrokeColor(colour.cgColor)
                ctx.strokePath()
            }
        }
    }

    /// Calculate CGLineCap from propery
    /// - Parameter styles: plot properties
    /// - Returns:  CGLineCap value

    func stylesCap(_ styles: Styles) -> CGLineCap {
        switch styles.cascade(.strokeLineCap) ?? "round" {
        case "butt": return .butt
        case "square": return .square
        default: return .round
        }
    }

    /// Parse the dash string
    /// - Parameter dashes: dash string
    /// - Returns: Array of CGFloat values

    func dashParse(_ dashes: String) -> [CGFloat] {
        var result: [CGFloat] = []
        let separators = CharacterSet(charactersIn: " ,")
        for dash in dashes.components(separatedBy: separators) {
            if let val = Double(dash) {
                result.append(CGFloat(val))
            }
        }
        return result
    }
}

//
//  CGplotPath.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-18.
//

import Foundation

/// Plot a single path component which may be a multi-component component
/// - Parameters:
///   - ctx: context
///   - component: current command
///   - current: current position

fileprivate func plotComponent(_ ctx: CGContext, component: PathComponent, current: inout CGPoint) {
    if let path = component.expand {
        for component in path.components {
            plotComponent(ctx, component: component, current: &current)
        }
    } else {
        switch component {
        case let .arcAround(c, r, s, e):
            // SVG and CG can't agree on up and down so use -ve angles
            ctx.addArc(
                center: c.cgpoint, radius: CGFloat(r),
                startAngle: CGFloat(-s), endAngle: CGFloat(-e),
                clockwise: true
            )
        case let .cBezierBy(dxy, c1dxy, c2dxy):
            let end = current + dxy.cgvector
            let control1 = current + c1dxy.cgvector
            let control2 = current + c2dxy.cgvector
            ctx.addCurve(to: end, control1: control1, control2: control2)
            current = end
        case let .cBezierTo(xy, c1xy, c2xy):
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
        case let .qBezierBy(dxy, cdxy):
            let end = current + dxy.cgvector
            let control = current + cdxy.cgvector
            ctx.addQuadCurve(to: end, control: control)
            current = end
        case let .qBezierTo(xy, cxy):
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
        case .closePath:
            ctx.closePath()
        default:
            print("\(component) not implemented", to: &standardError)
        }
    }
}

/// Draw a path on the context
/// - Parameters:
///   - components: a list of points and what to do
///   - styles: plot properties
///   - fill: fill or stroke?
///   - ctx: context for plotting
///   - clipRect: clipping rectangle

func cgPlotPath(_ path: Path, styles: Styles, fill: Bool, to ctx: CGContext, clippedBy clipRect: CGRect?) {
    let colour = (fill ? styles.fill : styles.colour) ?? .black
    let lineWidth = CGFloat(styles.strokeWidth)
    if let clipRect = clipRect { ctx.clip(to: clipRect) }
    var current = CGPoint.zero
    ctx.setLineWidth(lineWidth)
    ctx.setLineCap(stylesCap(styles))
    if let dashes = styles.dash {
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

/// Calculate CGLineCap from propery
/// - Parameter styles: plot properties
/// - Returns:  CGLineCap value

func stylesCap(_ styles: Styles) -> CGLineCap {
    switch styles.strokeLineCap! {
    case "butt": return .butt
    case "square": return .square
    default: return .round
    }
}

/// Parse the dash string
/// - Parameter dashes: dash string
/// - Returns: Array of CGFloat values

fileprivate func dashParse(_ dashes: String) -> [CGFloat] {
    var result: [CGFloat] = []
    let separators = CharacterSet(charactersIn: " ,")
    for dash in dashes.components(separatedBy: separators) {
        if let val = Double(dash) {
            result.append(CGFloat(val))
        }
    }
    return result
}

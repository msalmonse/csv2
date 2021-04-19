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
        if let componentsList = component.expand {
            for component in componentsList {
                plotComponent(ctx, component: component, current: &current)
            }
        } else {
            switch component {
            case .cBezierBy(let dx, let dy, let c1dx, let c1dy, let c2dx, let c2dy):
                let end = current + CGPoint(x: dx, y: dy)
                let control1 = current + CGPoint(x: c1dx, y: c1dy)
                let control2 = current + CGPoint(x: c2dx, y: c2dy)
                ctx.addCurve(to: end, control1: control1, control2: control2)
                current = end
            case .cBezierTo(let x, let y, let c1x, let c1y, let c2x, let c2y):
                let end = CGPoint(x: x, y: y)
                let control1 = CGPoint(x: c1x, y: c1y)
                let control2 = CGPoint(x: c2x, y: c2y)
                ctx.addCurve(to: end, control1: control1, control2: control2)
                current = end
            case .horizBy(let dx):
                current += CGPoint(x: dx, y: 0.0)
                ctx.addLine(to: current)
            case .horizTo(let x):
                current = CGPoint(x: CGFloat(x), y: current.y)
                ctx.addLine(to: current)
            case .lineBy(let dx, let dy):
                current += CGPoint(x: dx, y: dy)
                ctx.addLine(to: current)
            case .lineTo(let x, let y):
                current = CGPoint(x: x, y: y)
                ctx.addLine(to: current)
            case .moveBy(let dx, let dy):
                current += CGPoint(x: dx, y: dy)
                ctx.move(to: current)
            case .moveTo(let x, let y):
                current = CGPoint(x: x, y: y)
                ctx.move(to: current)
            case .qBezierBy(let dx, let dy, let cdx, let cdy):
                let end = current + CGPoint(x: dx, y: dy)
                let control = current + CGPoint(x: cdx, y: cdy)
                ctx.addQuadCurve(to: end, control: control)
                current = end
            case .qBezierTo(let x, let y, let cx, let cy):
                let end = CGPoint(x: x, y: y)
                let control = CGPoint(x: cx, y: cy)
                ctx.addQuadCurve(to: end, control: control)
                current = end
            case .vertBy(let dy):
                current += CGPoint(x: 0.0, y: dy)
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
    ///   - props: plot properties
    ///   - fill: fill or stroke?

    func plotPath(_ components: [PathComponent], props: Properties, fill: Bool) {
        let colour = ColourTranslate.lookup(props.cascade(fill ? .fill : .colour) ?? "black")
        let lineWidth = CGFloat(props.cascade(.strokeWidth))
        image.withCGContext { ctx in
            if let clipRect = clipRect { ctx.clip(to: clipRect)}
            var current = CGPoint.zero
            ctx.setLineWidth(lineWidth)
            ctx.setLineCap(propsCap(props))
            if let dashes = props.cascade(.dash) {
                ctx.setLineDash(phase: 0.0, lengths: dashParse(dashes))
            } else {
                ctx.setLineDash(phase: 0.0, lengths: [])
            }
            for component in components {
                plotComponent(ctx, component: component, current: &current)
            }
            if fill {
                if let colour = colour { ctx.setFillColor(colour.cgColor) }
                ctx.fillPath()
            } else {
                if let colour = colour { ctx.setStrokeColor(colour.cgColor) }
                ctx.strokePath()
            }
        }
    }

    /// Calculate CGLineCap from propery
    /// - Parameter props: plot properties
    /// - Returns:  CGLineCap value

    func propsCap(_ props: Properties) -> CGLineCap {
        switch props.cascade(.strokeLineCap) ?? "round" {
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

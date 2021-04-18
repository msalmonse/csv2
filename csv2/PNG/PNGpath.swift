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
            case .vertTo(let y):
                current = CGPoint(x: current.x, y: CGFloat(y))
                ctx.addLine(to: current)
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
        let colour = ColourTranslate.lookup(props.cascade(.colour) ?? "black")
        let lineWidth = CGFloat(props.cascade(.strokeWidth))
        image.withCGContext { ctx in
            var current = CGPoint.zero
            if let colour = colour { ctx.setStrokeColor(colour.cgColor) }
            ctx.setLineWidth(lineWidth)
            for component in components {
                plotComponent(ctx, component: component, current: &current)
            }
            ctx.strokePath()
        }
    }
}

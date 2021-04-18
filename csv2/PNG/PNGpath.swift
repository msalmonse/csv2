//
//  PNGpath.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-18.
//

import Foundation

extension PNG {

    /// Plot a single path command
    /// - Parameters:
    ///   - ctx: context
    ///   - command: current command
    ///   - current: current position

    private func plotCommand(_ ctx: CGContext, command: PathCommand, current: inout CGPoint) {
        if let commandList = command.expand {
            for command in commandList {
                plotCommand(ctx, command: command, current: &current)
            }
        } else {
            switch command {
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
            case .vertTo(let y):
                current = CGPoint(x: current.x, y: CGFloat(y))
                ctx.addLine(to: current)
            default:
                print(command, to: &standardError)
            }
        }
    }

    /// Draw a path on the PNG
    /// - Parameters:
    ///   - points: a list of points and what to do
    ///   - props: plot properties
    ///   - fill: fill or stroke?

    func plotPath(_ points: [PathCommand], props: Properties, fill: Bool) {
        let colour = ColourTranslate.lookup(props.cascade(.colour) ?? "black")
        let lineWidth = CGFloat(props.cascade(.strokeWidth))
        image.withCGContext { ctx in
            var current = CGPoint.zero
            if let colour = colour { ctx.setStrokeColor(colour.cgColor) }
            ctx.setLineWidth(lineWidth)
            for command in points {
                plotCommand(ctx, command: command, current: &current)
            }
            ctx.strokePath()
        }
    }
}

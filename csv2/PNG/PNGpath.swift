//
//  PNGpath.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-18.
//

import Foundation

extension PNG {

    func plotPath(_ points: [PathCommand], props: Properties, fill: Bool) {
        image.withCGContext { ctx in
            var current = CGPoint.zero
            ctx.setStrokeColor(gray: 0.0, alpha: 1.0)
            ctx.setLineWidth(2.0)
            for command in points {
                switch command {
                case .arc(let rx, _, _, _, let dx, let dy):
                    ctx.addArc(center: current, radius: CGFloat(rx),
                               startAngle: 0, endAngle: CGFloat(Double.pi), clockwise: true
                    )
                    current += CGPoint(x: dx, y: dy)
                case .horizTo(let x):
                    current = CGPoint(x: CGFloat(x), y: current.y)
                    ctx.addLine(to: current)
                case .lineTo(let x, let y):
                    current = CGPoint(x: x, y: y)
                    ctx.addLine(to: current)
                case .moveTo(let x, let y):
                    current = CGPoint(x: x, y: y)
                    ctx.move(to: current)
                case .vertTo(let y):
                    current = CGPoint(x: current.x, y: CGFloat(y))
                    ctx.addLine(to: current)
                default: break
                }
            }
            ctx.strokePath()
        }
    }
}

//
//  JSplotter.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-09.
//

import Foundation

extension JS {
    func plotGroup(plotPlane: Plane, lines: String) -> String {
        let shapeWidth = settings.css.shapeWidth
        // Make plottable a bit bigger so that shapes aren't clipped
        let left = (plotPlane.left - shapeWidth * 2.0)
        let top = (plotPlane.top - shapeWidth * 2.0)
        let bottom = (plotPlane.bottom + shapeWidth * 4.0)
        let right = (plotPlane.right + shapeWidth * 4.0)
        var result = [""]
        result.append("ctx.save()")
        result.append("")
        result.append("ctx.beginPath()")
        result.append("ctx.moveTo(\(left.f(1)), \(top.f(1)))")
        result.append("ctx.lineTo(\(right.f(0)), \(top.f(1)))")
        result.append("ctx.lineTo(\(right.f(0)), \(bottom.f(1)))")
        result.append("ctx.lineTo(\(left.f(0)), \(bottom.f(1)))")
        result.append("ctx.lineTo(\(left.f(1)), \(top.f(1)))")
        result.append("ctx.clip()")
        result.append(lines)
        result.append("")
        result.append("ctx.restore()")

        return result.joined(separator: "\n    ")
    }

    func plotHead(positions: Positions, plotPlane: Plane, propsList: PropertiesList) -> String {
        let id = settings.plotter.canvasID
        return """
            const canvas = document.getElementById('\(id)');
            if (canvas.getContext) {
                const ctx = canvas.getContext('2d');
            """
    }

    func plotRect(_ plane: Plane, rx: Double, props: Properties) -> String {
        return ""
    }

    func plotTail() -> String {
        return "}"
    }

    func plotText(x: Double, y: Double, text: String, props: Properties) -> String {
        var result = [""]
        ctx.sync(props, &result, isText: true)
        result.append("ctx.fillText('\(text)', \(x.f(1)), \(y.f(1)))")
        ctx.resetTransform(&result)
        return result.joined(separator: "\n    ")
    }
}

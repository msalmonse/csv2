//
//  Legends.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-17.
//

import Foundation

extension SVG {

    private func bgRect(_ top: Double, _ bottom: Double, _ left: Double, right: Double) -> String {
        let h = bottom - top
        let w = right - left
        let x = left
        let y = top
        return """
            <rect
                x="\(x.f(1))" y="\(y.f(1))" height="\(h.f(1))" width="\(w.f(1))" rx="\(plotWidth * 3.0)"
                fill="silver" opacity=".1" stroke="black" stroke-width="1.5"
            />
            """
    }

    private func scatteredLine(
        _ x: Double, _ y: Double,
        _ props: PathProperties
    ) -> String {
        guard props.shape != nil else { return "" }
        return SVG.svgPath([
            PathCommand.moveTo(x: x, y: y),
            props.shape!.pathCommand(w: shapeWidth)
        ],
        props, width: plotWidth)
    }

    private func pointedLine(
        _ left: Double, _ mid: Double, _ right: Double, _ y: Double,
        _ props: PathProperties
    ) -> String {
        guard props.shape != nil else { return "" }
        return SVG.svgPath([
            PathCommand.moveTo(x: left, y: y),
            .horizTo(x: mid),
            props.shape!.pathCommand(w: shapeWidth),
            .horizTo(x: right)
        ],
        props, width: plotWidth)
    }

    private func plainLine(
        _ left: Double, _ right: Double, _ y: Double,
        _ props: PathProperties
    ) -> String {
        return SVG.svgPath([
            PathCommand.moveTo(x: left, y: y),
            .horizTo(x: right)
        ],
        props, width: plotWidth)
    }

    private func shortened(_ text: String, len: Int = 10) -> String {
        if text.count <= len { return text }
        return text.prefix(len) + "…"
    }
    /// Add legends to an SVG
    /// - Returns: Text string with all legends

    func svgLegends() -> String {
        let size = legendPX
        let x = positions.legendX
        let xRight = width - settings.legendSize/2.0
        let xMid = (x + xRight)/2.0
        var y = positions.legendY
        let yStep = settings.legendSize * 1.5
        var legends: [String] = [
            "",     // reserved for background
            "<text x=\"\(x)\" y=\"\(y)\" font-size=\"\(size)\" font-weight=\"bold\">Legends:</text>"
        ]
        y += yStep/2.0

        for i in 0..<props.count where i != index {
            y += yStep
            let propi = props[i]
            let text = shortened(propi.name!)
            let colour = propi.colour!
            legends.append(
                "<text x=\"\(x.f(1))\" y=\"\(y.f(1))\" stroke=\"\(colour)\" font-size=\"\(size)\">\(text)</text>"
            )
            let lineY = y + yStep/2.0
            if propi.dashed || propi.pointed || propi.scattered { y += yStep }
            switch (propi.dashed, propi.pointed, propi.scattered) {
            case (_,_,true):
                legends.append(scatteredLine(x + shapeWidth, lineY, propi))
            case (_,true,false):
                legends.append(pointedLine(x, xMid, xRight, lineY, propi))
            case (true,_,false):
                legends.append(plainLine(x, xRight, lineY, propi))
            default: break
            }
        }

        legends[0] = bgRect(positions.legendY - yStep, y + yStep, x - settings.legendSize, right: width)

        return legends.joined(separator: "\n")
    }
}

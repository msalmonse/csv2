//
//  Legends.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-17.
//

import Foundation

extension SVG {

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

    /// Add legends to an SVG
    /// - Returns: Text string with all legends

    func svgLegends() -> String {
        let iMax = settings.inColumns ? csv.colCt : csv.rowCt
        let size = legendPX
        let x = positions.legendX
        let xMid = (x + width)/2.0
        var y = positions.legendY
        let yStep = settings.legendSize * 1.5
        var legends: [String] = [
            "<text x=\"\(x)\" y=\"\(y)\" font-size=\"\(size)\" font-weight=\"bold\">Legends:</text>"
        ]

        for i in 0..<iMax where i != index {
            y += yStep
            let propi = props[i]
            let text = propi.name!
            let colour = propi.colour!
            legends.append(
                "<text x=\"\(x)\" y=\"\(y)\" stroke=\"\(colour)\" font-size=\"\(size)\">\(text)</text>"
            )
            let lineY = y + yStep/2.0
            if propi.dashed || propi.pointed || propi.scattered { y += yStep }
            switch (propi.dashed, propi.pointed, propi.scattered) {
            case (_,_,true):
                legends.append(scatteredLine(x + shapeWidth, lineY, propi))
            case (_,true,false):
                legends.append(pointedLine(x, xMid, width, lineY, propi))
            case (true,_,false):
                legends.append(plainLine(x, width, lineY, propi))
            default: break
            }
        }

        return legends.joined(separator: "\n")
    }
}

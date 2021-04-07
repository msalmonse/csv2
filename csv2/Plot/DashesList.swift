//
//  DashesList.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-23.
//

import Foundation

extension Plot {
    func dashesListGen(_ step: Double, _ defaults: Defaults) -> [String] {
        let colour = defaults.colours.first ?? "black"
        let dashes = defaults.dashes + Dashes.all(width * 3.0)

        let xLeft = width * 0.1
        let xRight = width * 0.6
        let xText = width * 0.65

        var propsList = PropertiesList(count: dashes.count, settings: settings)
        for i in propsList.plots.indices {
            propsList.plots[i].colour = colour
            propsList.plots[i].dash = dashes[i]
            propsList.plots[i].dashed = true
            propsList.plots[i].strokeLineCap = "butt"
            propsList.plots[i].cssClass = "dash\((i + 1).d0(2))"
        }

        var y = step
        var yPath: Double { y - step/10.0 }

        var result: [String] = [
            plotter.plotHead(positions: positions, plotPlane: plotPlane, propsList: propsList)
        ]

        for i in dashes.indices {
            y += step
            let points = [ PathCommand.moveTo(x: xLeft, y: yPath), .horizTo(x: xRight) ]
            result.append(plotter.plotPath(points, props: propsList.plots[i]))
            result.append(plotter.plotText(x: xText, y: y, text: dashes[i], props: propsList.plots[i]))
        }

        result.append(plotter.plotTail())
        return result
    }
}

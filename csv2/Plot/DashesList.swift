//
//  DashesList.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-23.
//

import Foundation

extension Plot {
    func dashesListGen(_ step: Double, _ defaults: Defaults) {
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
            propsList.plots[i].fontSize = step * 0.5
            propsList.plots[i].strokeLineCap = "butt"
            propsList.plots[i].textAlign = "start"
            propsList.plots[i].cssClass = "dash\((i + 1).d0(2))"
        }

        var y = step
        var yPath: Double { y - step/10.0 }

        plotter.plotHead(positions: positions, plotPlane: plotPlane, propsList: propsList)

        for i in dashes.indices {
            y += step
            let path = Path([ PathComponent.moveTo(x: xLeft, y: yPath), .horizTo(x: xRight) ])
            plotter.plotPath(path, props: propsList.plots[i], fill: false)
            plotter.plotText(x: xText, y: y, text: dashes[i], props: propsList.plots[i])
        }

        plotter.plotTail()
    }
}

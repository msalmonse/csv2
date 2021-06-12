//
//  DashesList.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-23.
//

import Foundation

extension Plot {
    func dashesListGen(_ step: Double, _ defaults: Defaults) {
        let colour = defaults.colourArray(.colours)?.first ?? .black
        let dashes = defaults.stringArray(.dashes) + Dashes.all(width * 3.0)

        let xLeft = width * 0.1
        let xRight = width * 0.6
        let xText = width * 0.65

        var stylesList = StylesList(count: dashes.count, settings: settings)
        for i in stylesList.plots.indices {
            stylesList.plots[i].colour = colour
            stylesList.plots[i].dash = dashes[i]
            stylesList.plots[i].options[.dashed] = true
            stylesList.plots[i].fontSize = step * 0.5
            stylesList.plots[i].strokeLineCap = "butt"
            stylesList.plots[i].textAlign = "start"
            stylesList.plots[i].cssClass = "dash\((i + 1).d0(2))"
        }

        var y = step
        var yPath: Double { y - step / 10.0 }

        plotter.plotHead(positions: positions, clipPlane: clipPlane, stylesList: stylesList)

        for i in dashes.indices {
            y += step
            let path = Path([ PathComponent.moveTo(xy: Point(x: xLeft, y: yPath)), .horizTo(x: xRight) ])
            plotter.plotPath(path, styles: stylesList.plots[i], fill: false)
            plotter.plotText(x: xText, y: y, text: dashes[i], styles: stylesList.plots[i])
        }

        plotter.plotTail()
    }
}

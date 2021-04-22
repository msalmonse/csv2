//
//  ColoursList.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-22.
//

import Foundation

extension Plot {

    /// Generate an image with a list of colours
    /// - Parameters:
    ///   - step: distance between lines
    ///   - colours: list of colours

    func coloursListGen(_ step: Double, _ colours: [String]) {
        let xText = width * 0.4
        let lRect = width * 0.1
        let rRect = lRect + width * 0.25
        let hRect = step * 0.8
        let rx = step * 0.2

        var propsList = PropertiesList(count: colours.count, settings: settings)
        for i in propsList.plots.indices {
            propsList.plots[i].colour = colours[i]
            propsList.plots[i].fill = colours[i]
            propsList.plots[i].fontColour = colours[i]
            propsList.plots[i].fontSize = ceil(step * 0.75)
            propsList.plots[i].textAlign = "start"
            propsList.plots[i].cssClass = "colour\((i + 1).d0(2))"
        }

        var y = step + step
        var yRect: Double { y - hRect * 0.8 }
        plotter.plotHead(positions: positions, plotPlane: plotPlane, propsList: propsList)

        for i in colours.indices {
            plotter.plotText(x: xText, y: y, text: colours[i], props: propsList.plots[i])
            let plane = Plane(top: yRect, bottom: yRect + hRect, left: lRect, right: rRect)
            plotter.plotPath(rectPath(plane, rx: rx), props: propsList.plots[i], fill: true)
            y += step
        }

        plotter.plotTail()
    }
}

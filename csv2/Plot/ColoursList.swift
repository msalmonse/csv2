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
    ///   - rows: the number of rows

    func coloursListGen(_ step: Double, _ colours: [String], _ rows: Int, _ columnWidth: Double) {
        /// Calculate background props for colour
        func bgProps(_ name: String) -> Properties {
            switch RGBAu8(name, or: .clear).rgbValue {
            case 180...255: return midBG
            case 90...179: return darkBG
            default: return lightBG
            }
        }

        var lightBG = Properties.from(settings: settings)
        lightBG.fill = RGBAu8.lightBG.cssRGBA
        lightBG.cssClass = "lightBG"

        var darkBG = Properties.from(settings: settings)
        darkBG.fill = RGBAu8.darkBG.cssRGBA
        darkBG.cssClass = "darkBG"

        var midBG = Properties.from(settings: settings)
        midBG.fill = RGBAu8.midBG.cssRGBA
        midBG.cssClass = "midBG"

        var xText = columnWidth * 0.4
        var lRect = columnWidth * 0.1
        var lBG: Double { lRect - 2.0 * strokeWidth }
        let wRect = columnWidth * 0.25
        let wBG = columnWidth * 0.9
        let hRect = step * 0.8
        var hBG: Double { hRect + 2.0 * strokeWidth }
        let rx = step * 0.2

        var propsList = PropertiesList(count: colours.count, settings: settings)
        for i in propsList.plots.indices {
            propsList.plots[i].colour = colours[i]
            propsList.plots[i].fill = colours[i]
            // Make text colour opaque so that it can be read
            propsList.plots[i].fontColour =
                RGBAu8(colours[i], or: .black).with(alpha: 255).cssRGBA
            propsList.plots[i].fontSize = ceil(step * 0.75)
            propsList.plots[i].textAlign = "start"
            propsList.plots[i].cssClass = "colour\((i + 1).d0(2))"
        }

        var y = step + step
        var yRect: Double { y - hRect * 0.8 }
        var yBG: Double { yRect - strokeWidth }

        plotter.plotHead(positions: positions, plotPlane: plotPlane, propsList: propsList)

        for i in colours.indices {
            let bg = Plane(left: lBG, top: yBG, height: hBG, width: wBG)
            let propsBG = bgProps(colours[i])
            plotter.plotPath(rectPath(bg, rx: rx), props: propsBG, fill: true)
            plotter.plotText(x: xText, y: y, text: colours[i], props: propsList.plots[i])
            let plane = Plane(left: lRect, top: yRect, height: hRect, width: wRect)
            plotter.plotPath(rectPath(plane, rx: rx), props: propsList.plots[i], fill: true)

            if i % rows == (rows - 1) {
                xText += columnWidth
                lRect += columnWidth
                y = step
            }
            y += step
        }

        plotter.plotTail()
    }
}

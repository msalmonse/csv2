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
        /// Calculate background styles for colour
        func bgSelect(_ name: String) -> Styles {
            let luma = RGBAu8(name, or: .clear).luminance
            switch luma {
            case 2200000...: return midBG
            case 0...1500000: return lightBG
            default: return darkBG
            }
        }

        var lightBG = Styles.from(settings: settings)
        lightBG.fill = RGBAu8.lightBG.cssRGBA
        lightBG.cssClass = "lightBG"

        var darkBG = Styles.from(settings: settings)
        darkBG.fill = RGBAu8.darkBG.cssRGBA
        darkBG.cssClass = "darkBG"

        var midBG = Styles.from(settings: settings)
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

        var stylesList = StylesList(count: colours.count, settings: settings)
        for i in stylesList.plots.indices {
            stylesList.plots[i].colour = colours[i]
            stylesList.plots[i].fill = colours[i]
            // Make text colour opaque so that it can be read
            stylesList.plots[i].fontColour =
                RGBAu8(colours[i], or: .black).with(alpha: 255).cssRGBA
            stylesList.plots[i].fontSize = ceil(step * 0.75)
            stylesList.plots[i].textAlign = "start"
            stylesList.plots[i].cssClass = "colour\((i + 1).d0(2))"
        }

        var y = step + step
        var yRect: Double { y - hRect * 0.8 }
        var yBG: Double { yRect - strokeWidth }

        plotter.plotHead(positions: positions, clipPlane: clipPlane, stylesList: stylesList)

        for i in colours.indices {
            let bg = Plane(left: lBG, top: yBG, height: hBG, width: wBG)
            let bgStyles = bgSelect(colours[i])
            plotter.plotPath(rectPath(bg, rx: rx), styles: bgStyles, fill: true)
            plotter.plotText(x: xText, y: y, text: colours[i], styles: stylesList.plots[i])
            let plane = Plane(left: lRect, top: yRect, height: hRect, width: wRect)
            plotter.plotPath(rectPath(plane, rx: rx), styles: stylesList.plots[i], fill: true)

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

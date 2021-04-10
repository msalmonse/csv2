//
//  PropertiesList.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-10.
//

import Foundation

struct PropertiesList {
    var plots: [Properties]
    var axes = Properties()
    var legend = Properties()
    var legendHeadline = Properties()
    var legendBG = Properties()
    var subTitle = Properties()
    var title = Properties()
    var xLabel = Properties()
    var xTitle = Properties()
    var yLabel = Properties()
    var yTitle = Properties()

    init(count ct: Int, settings: Settings) {
        let sizes = FontSizes(size: settings.dim.baseFontSize)
        plots = Array(repeating: Properties(), count: ct)

        Properties.defaultProperties.bezier = settings.plot.bezier
        Properties.defaultProperties.colour = "black"
        Properties.defaultProperties.fill = "none"
        Properties.defaultProperties.fontColour = "black"
        Properties.defaultProperties.fontFamily = settings.css.fontFamily
        Properties.defaultProperties.strokeLineCap = "round"
        Properties.defaultProperties.strokeWidth = settings.css.strokeWidth
        Properties.defaultProperties.textAlign = "middle"

        axes.cssClass = "axes"
        legend.fontSize = sizes.legendSize
        legend.cssClass = "legend"
        legend.textAlign = "start"
        legendBG.colour = "silver"
        legendBG.cssClass = "legend"
        legendBG.colour = "silver"
        legendHeadline.fontSize = sizes.legendSize * 1.25
        legendHeadline.fontColour = "black"
        legendHeadline.bold = true
        legendHeadline.cssClass = "legend headline"
        legendHeadline.textAlign = "start"
        subTitle.fontSize = sizes.subTitleSize
        subTitle.cssClass = "subtitle"
        title.fontSize = sizes.titleSize
        title.cssClass = "title"
        xLabel.fontSize = sizes.labelSize
        xLabel.cssClass = "xlabel"
        xLabel.colour = "silver"
        xLabel.strokeWidth = 1.0
        xTitle.fontSize = sizes.axesSize
        xTitle.cssClass = "xtitle"
        yLabel.fontSize = sizes.labelSize
        yLabel.colour = "silver"
        yLabel.cssClass = "ylabel"
        yLabel.strokeWidth = 1.0
        yLabel.textAlign = "end"
        yTitle.fontSize = sizes.axesSize
        yTitle.cssClass = "ytitle"
    }
}

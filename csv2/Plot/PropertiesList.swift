//
//  PropertiesList.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-10.
//

import Foundation

struct PropertiesList {
    var plots: [Properties]
    var axes: Properties
    var legend: Properties
    var legendHeadline: Properties
    var legendBG: Properties
    var subTitle: Properties
    var title: Properties
    var xLabel: Properties
    var xTitle: Properties
    var yLabel: Properties
    var yTitle: Properties

    init(count ct: Int, settings: Settings) {
        let sizes = FontSizes(size: settings.dim.baseFontSize)
        plots = Array(repeating: Properties(), count: ct)

        Properties.defaultProperties.bezier = settings.plot.bezier
        Properties.defaultProperties.bold = settings.css.bold
        Properties.defaultProperties.colour = "black"
        Properties.defaultProperties.fill = "none"
        Properties.defaultProperties.fontColour = "black"
        Properties.defaultProperties.fontFamily = settings.css.fontFamily
        Properties.defaultProperties.italic = settings.css.italic
        Properties.defaultProperties.strokeLineCap = "round"
        Properties.defaultProperties.strokeWidth = settings.css.strokeWidth
        Properties.defaultProperties.textAlign = "middle"
        Properties.defaultProperties.textBaseline = "alphabetic"

        axes = Properties.from(settings: settings)
        axes.cssClass = "axes"
        legend = Properties.from(settings: settings)
        legend.fontSize = sizes.legendSize
        legend.cssClass = "legend"
        legend.textAlign = "start"
        legendBG = Properties.from(settings: settings)
        legendBG.colour = "silver"
        legendBG.cssClass = "legend"
        legendBG.colour = "silver"
        legendHeadline = Properties.from(settings: settings)
        legendHeadline.fontSize = sizes.legendSize * 1.25
        legendHeadline.fontColour = "black"
        legendHeadline.bold = true
        legendHeadline.cssClass = "legend headline"
        legendHeadline.textAlign = "start"
        subTitle = Properties.from(settings: settings)
        subTitle.fontSize = sizes.subTitleSize
        subTitle.cssClass = "subtitle"
        title = Properties.from(settings: settings)
        title.fontSize = sizes.titleSize
        title.cssClass = "title"
        xLabel = Properties.from(settings: settings)
        xLabel.fontSize = sizes.labelSize
        xLabel.cssClass = "xlabel"
        xLabel.colour = "silver"
        xLabel.strokeWidth = 1.0
        xTitle = Properties.from(settings: settings)
        xTitle.fontSize = sizes.axesSize
        xTitle.cssClass = "xtitle"
        yLabel = Properties.from(settings: settings)
        yLabel.fontSize = sizes.labelSize
        yLabel.colour = "silver"
        yLabel.cssClass = "ylabel"
        yLabel.strokeWidth = 1.0
        yLabel.textAlign = "end"
        yLabel.textBaseline = "middle"
        yTitle = Properties.from(settings: settings)
        yTitle.fontSize = sizes.axesSize
        yTitle.cssClass = "ytitle"
    }
}

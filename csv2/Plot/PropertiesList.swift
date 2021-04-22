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
    var legendBox: Properties
    var subTitle: Properties
    var title: Properties
    var xLabel: Properties
    var xTags: Properties
    var xTitle: Properties
    var yLabel: Properties
    var yTitle: Properties

    init(count ct: Int, settings: Settings) {
        let sizes = FontSizes(size: settings.dim.baseFontSize)
        plots = Array(repeating: Properties(), count: ct)

        Properties.defaultProperties.bezier = settings.plot.bezier
        Properties.defaultProperties.bold = settings.css.bold
        Properties.defaultProperties.colour = defaults.foregroundColour
        Properties.defaultProperties.fill = "none"
        Properties.defaultProperties.fontColour = defaults.textColour
        Properties.defaultProperties.fontFamily = settings.css.fontFamily
        Properties.defaultProperties.italic = settings.css.italic
        Properties.defaultProperties.strokeLineCap = "round"
        Properties.defaultProperties.strokeWidth = settings.css.strokeWidth
        Properties.defaultProperties.textAlign = "middle"
        Properties.defaultProperties.textBaseline = "alphabetic"

        axes = Properties.from(settings: settings)
        axes.colour = settings.fg.axes
        axes.cssClass = "axes"
        legend = Properties.from(settings: settings)
        legend.fontSize = sizes.legendSize
        legend.fontColour = settings.fg.legends
        legend.cssClass = "legend"
        legend.textAlign = "start"
        legendBox = Properties.from(settings: settings)
        legendBox.colour = ColourTranslate.lookup(settings.fg.legendsBox)?.maxAlpha(0.4).cssRGBA
        legendBox.cssClass = "legend"
        legendHeadline = Properties.from(settings: settings)
        legendHeadline.fontSize = sizes.legendSize * 1.25
        legendHeadline.bold = true
        legendHeadline.fontColour = settings.fg.legends
        legendHeadline.cssClass = "legend headline"
        legendHeadline.textAlign = "start"
        subTitle = Properties.from(settings: settings)
        subTitle.fontColour = settings.fg.subTitle
        subTitle.fontSize = sizes.subTitleSize
        subTitle.cssClass = "subtitle"
        title = Properties.from(settings: settings)
        title.fontColour = settings.fg.title
        title.fontSize = sizes.titleSize
        title.cssClass = "title"
        xLabel = Properties.from(settings: settings)
        xLabel.fontSize = sizes.labelSize
        xLabel.cssClass = "xlabel"
        xLabel.colour = ColourTranslate.lookup(settings.fg.xLabel)?.maxAlpha(0.4).cssRGBA
        xLabel.fontColour = settings.fg.xLabel
        xLabel.strokeWidth = 1.0
        xTags = Properties.from(settings: settings)
        xTags.fontColour = settings.fg.xTags
        xTags.fontSize = sizes.axesSize
        xTitle = Properties.from(settings: settings)
        xTitle.fontColour = settings.fg.xTitle
        xTitle.fontSize = sizes.axesSize
        xTitle.cssClass = "xtitle"
        yLabel = Properties.from(settings: settings)
        yLabel.fontSize = sizes.labelSize
        yLabel.colour = ColourTranslate.lookup(settings.fg.yLabel)?.maxAlpha(0.4).cssRGBA
        yLabel.fontColour = settings.fg.yLabel
        yLabel.cssClass = "ylabel"
        yLabel.strokeWidth = 1.0
        yLabel.textAlign = "end"
        yLabel.textBaseline = "middle"
        yTitle = Properties.from(settings: settings)
        yTitle.fontSize = sizes.axesSize
        yTitle.cssClass = "ytitle"
    }
}

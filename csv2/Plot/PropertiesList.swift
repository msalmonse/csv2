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
    var pieLegend: Properties
    var subTitle: Properties
    var title: Properties
    var xLabel: Properties
    var xTags: Properties
    var xTitle: Properties
    var yLabel: Properties
    var yTitle: Properties

    init(count ct: Int, settings: Settings) {
        let sizes = FontSizes(size: settings.dim.baseFontSize)
        plots = Array(repeating: Properties.from(settings: settings), count: ct)

        Self.setDefaults(settings: settings, sizes: sizes)

        axes = Properties.from(settings: settings)
        axes.colour = settings.fg.axes
        axes.cssClass = "axes"

        legend = Properties.from(settings: settings)
        legend.cssClass = "legend"
        legend.fontColour = settings.fg.legends
        legend.fontSize = sizes.legend.size
        legend.textAlign = "start"

        legendBox = Properties.from(settings: settings)
        legendBox.colour = RGBAu8(settings.fg.legendsBox, or: .black).clamped(opacity: 0.4).cssRGBA
        legendBox.cssClass = "legend"

        legendHeadline = Properties.from(settings: settings)
        legendHeadline.bold = true
        legendHeadline.cssClass = "legend headline"
        legendHeadline.fontColour = settings.fg.legends
        legendHeadline.fontSize = sizes.legend.size * 1.25
        legendHeadline.textAlign = "start"

        pieLegend = Properties.from(settings: settings)
        pieLegend.cssClass = "legend pie"
        pieLegend.fontColour = settings.fg.legends
        pieLegend.fontSize = sizes.pieLegend.size
        pieLegend.textAlign = "middle"

        subTitle = Properties.from(settings: settings)
        subTitle.cssClass = "subtitle"
        subTitle.fontColour = settings.fg.subTitle
        subTitle.fontSize = sizes.subTitle.size

        title = Properties.from(settings: settings)
        title.cssClass = "title"
        title.fontColour = settings.fg.title
        title.fontSize = sizes.title.size

        xLabel = Properties.from(settings: settings)
        xLabel.colour = RGBAu8(settings.fg.axes, or: .black).clamped(opacity: 0.4).cssRGBA
        xLabel.cssClass = "xlabel"
        xLabel.fontColour = settings.fg.xLabel
        xLabel.fontSize = sizes.label.size
        xLabel.strokeWidth = 1.0

        xTags = Properties.from(settings: settings)
        xTags.colour = RGBAu8(settings.fg.axes, or: .black).clamped(opacity: 0.4).cssRGBA
        xTags.cssClass = "xtags"
        xTags.fontColour = settings.fg.xTags
        xTags.fontSize = sizes.axes.size
        xTags.strokeWidth = 1.0

        xTitle = Properties.from(settings: settings)
        xTitle.cssClass = "xtitle"
        xTitle.fontColour = settings.fg.xTitle
        xTitle.fontSize = sizes.axes.size

        yLabel = Properties.from(settings: settings)
        yLabel.colour = RGBAu8(settings.fg.axes, or: .black).clamped(opacity: 0.4).cssRGBA
        yLabel.cssClass = "ylabel"
        yLabel.fontColour = settings.fg.yLabel
        yLabel.fontSize = sizes.label.size
        yLabel.strokeWidth = 1.0
        yLabel.textAlign = "end"
        yLabel.textBaseline = "middle"

        yTitle = Properties.from(settings: settings)
        yTitle.cssClass = "ytitle"
        yTitle.fontSize = sizes.axes.size
    }

    /// Set default properties
    /// - Parameters:
    ///   - settings: image settings
    ///   - sizes: font sizes

    static func setDefaults(settings: Settings, sizes: FontSizes) {
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
    }
}

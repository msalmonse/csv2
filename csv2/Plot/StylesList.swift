//
//  PropertiesList.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-10.
//

import Foundation

struct StylesList {
    var plots: [Styles]
    var axes: Styles
    var legend: Styles
    var legendHeadline: Styles
    var legendBox: Styles
    var pieLegend: Styles
    var subTitle: Styles
    var title: Styles
    var xLabel: Styles
    var xTags: Styles
    var xTitle: Styles
    var yLabel: Styles
    var yTitle: Styles

    init(count ct: Int, settings: Settings) {
        let sizes = FontSizes(size: settings.dim.baseFontSize)
        plots = Array(repeating: Styles.from(settings: settings), count: ct)

        Self.setDefaults(settings: settings, sizes: sizes)

        axes = Styles.from(settings: settings)
        axes.colour = settings.fg.axes
        axes.cssClass = "axes"

        legend = Styles.from(settings: settings)
        legend.cssClass = "legend"
        legend.fontColour = settings.fg.legends
        legend.fontSize = sizes.legend.size
        legend.textAlign = "start"

        legendBox = Styles.from(settings: settings)
        legendBox.colour = RGBAu8(settings.fg.legendsBox, or: .black).clamped(opacity: 0.4).cssRGBA
        legendBox.cssClass = "legend"

        legendHeadline = Styles.from(settings: settings)
        legendHeadline.bold = true
        legendHeadline.cssClass = "legend headline"
        legendHeadline.fontColour = settings.fg.legends
        legendHeadline.fontSize = sizes.legend.size * 1.25
        legendHeadline.textAlign = "start"

        pieLegend = Styles.from(settings: settings)
        pieLegend.cssClass = "legend pie"
        pieLegend.fontColour = settings.fg.pieLegend
        pieLegend.fontSize = sizes.pieLegend.size
        pieLegend.textAlign = "middle"

        subTitle = Styles.from(settings: settings)
        subTitle.cssClass = "subtitle"
        subTitle.fontColour = settings.fg.subTitle
        subTitle.fontSize = sizes.subTitle.size

        title = Styles.from(settings: settings)
        title.cssClass = "title"
        title.fontColour = settings.fg.title
        title.fontSize = sizes.title.size

        xLabel = Styles.from(settings: settings)
        xLabel.colour = RGBAu8(settings.fg.axes, or: .black).clamped(opacity: 0.4).cssRGBA
        xLabel.cssClass = "xlabel"
        xLabel.fontColour = settings.fg.xLabel
        xLabel.fontSize = sizes.label.size
        xLabel.strokeWidth = 1.0

        xTags = Styles.from(settings: settings)
        xTags.colour = RGBAu8(settings.fg.axes, or: .black).clamped(opacity: 0.4).cssRGBA
        xTags.cssClass = "xtags"
        xTags.fontColour = settings.fg.xTags
        xTags.fontSize = sizes.axes.size
        xTags.strokeWidth = 1.0

        xTitle = Styles.from(settings: settings)
        xTitle.cssClass = "xtitle"
        xTitle.fontColour = settings.fg.xTitle
        xTitle.fontSize = sizes.axes.size

        yLabel = Styles.from(settings: settings)
        yLabel.colour = RGBAu8(settings.fg.axes, or: .black).clamped(opacity: 0.4).cssRGBA
        yLabel.cssClass = "ylabel"
        yLabel.fontColour = settings.fg.yLabel
        yLabel.fontSize = sizes.label.size
        yLabel.strokeWidth = 1.0
        yLabel.textAlign = "end"
        yLabel.textBaseline = "middle"

        yTitle = Styles.from(settings: settings)
        yTitle.cssClass = "ytitle"
        yTitle.fontSize = sizes.axes.size
    }

    /// Set default properties
    /// - Parameters:
    ///   - settings: image settings
    ///   - sizes: font sizes

    static func setDefaults(settings: Settings, sizes: FontSizes) {
        Styles.defaultStyles.bezier = settings.plot.bezier
        Styles.defaultStyles.bold = settings.css.bold
        Styles.defaultStyles.colour = defaults.foregroundColour
        Styles.defaultStyles.fill = "none"
        Styles.defaultStyles.fontColour = defaults.textColour
        Styles.defaultStyles.fontFamily = settings.css.fontFamily
        Styles.defaultStyles.italic = settings.css.italic
        Styles.defaultStyles.strokeLineCap = "round"
        Styles.defaultStyles.strokeWidth = settings.css.strokeWidth
        Styles.defaultStyles.textAlign = "middle"
        Styles.defaultStyles.textBaseline = "alphabetic"
    }
}

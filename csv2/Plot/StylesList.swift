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

        axes = Self.axesStyle(settings: settings, sizes: sizes)
        legend = Self.legendStyle(settings: settings, sizes: sizes)
        legendBox = Self.legendBoxStyle(settings: settings, sizes: sizes)
        legendHeadline = Self.legendHeadlineStyle(settings: settings, sizes: sizes)
        pieLegend = Self.pieLegendStyle(settings: settings, sizes: sizes)
        subTitle = Self.subTitleStyle(settings: settings, sizes: sizes)
        title = Self.titleStyle(settings: settings, sizes: sizes)
        xLabel = Self.xLabelStyle(settings: settings, sizes: sizes)
        xTags = Self.xTagsStyle(settings: settings, sizes: sizes)
        xTitle = Self.xTitleStyle(settings: settings, sizes: sizes)
        yLabel = Self.yLabelStyle(settings: settings, sizes: sizes)
        yTitle = Self.yTitleStyle(settings: settings, sizes: sizes)
    }

    /// Set default properties
    /// - Parameters:
    ///   - settings: image settings
    ///   - sizes: font sizes

    static func setDefaults(settings: Settings, sizes: FontSizes) {
        Styles.defaultStyles.bezier = settings.plot.bezier
        Styles.defaultStyles.options[.bold] = settings.css.bold
        Styles.defaultStyles.colour = defaults.foregroundColour
        Styles.defaultStyles.fill = "none"
        Styles.defaultStyles.fontColour = defaults.textColour
        Styles.defaultStyles.fontFamily = settings.css.fontFamily
        Styles.defaultStyles.options[.italic] = settings.css.italic
        Styles.defaultStyles.strokeLineCap = "round"
        Styles.defaultStyles.strokeWidth = settings.css.strokeWidth
        Styles.defaultStyles.textAlign = "middle"
        Styles.defaultStyles.textBaseline = "alphabetic"
    }

    /// Set axes style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: axes style

    static private func axesStyle(settings: Settings, sizes: FontSizes) -> Styles {
        var axes = Styles.from(settings: settings)
        axes.colour = settings.fg.axes
        axes.cssClass = "axes"
        return axes
    }

    /// Set legend style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: legend style

    static private func legendStyle(settings: Settings, sizes: FontSizes) -> Styles {
        var legend = Styles.from(settings: settings)
        legend.cssClass = "legend"
        legend.fontColour = settings.fg.legends
        legend.fontSize = sizes.legend.size
        legend.textAlign = "start"
        return legend
    }

    /// Set legendBox style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: legendBox style

    static private func legendBoxStyle(settings: Settings, sizes: FontSizes) -> Styles {
        var legendBox = Styles.from(settings: settings)
        legendBox.colour = RGBAu8(settings.fg.legendsBox, or: .black).clamped(opacity: 0.4).cssRGBA
        legendBox.cssClass = "legend"
        return legendBox
    }

    /// Set legendHeadline style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: legendHeadline style

    static private func legendHeadlineStyle(settings: Settings, sizes: FontSizes) -> Styles {
        var legendHeadline = Styles.from(settings: settings)
        legendHeadline.options[.bold] = true
        legendHeadline.cssClass = "legend headline"
        legendHeadline.fontColour = settings.fg.legends
        legendHeadline.fontSize = sizes.legend.size * 1.25
        legendHeadline.textAlign = "start"
        return legendHeadline
    }

    /// Set pieLegend style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: pieLegend style

    static private func pieLegendStyle(settings: Settings, sizes: FontSizes) -> Styles {
        var pieLegend = Styles.from(settings: settings)
        pieLegend.cssClass = "pielegend"
        pieLegend.fontColour = settings.fg.pieLegend
        pieLegend.fontSize = sizes.pieLegend.size
        pieLegend.textAlign = "middle"
        return pieLegend
    }

    /// Set subTitle style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: subTitle style

    static private func subTitleStyle(settings: Settings, sizes: FontSizes) -> Styles {
        var subTitle = Styles.from(settings: settings)
        subTitle.cssClass = "subtitle"
        subTitle.fontColour = settings.fg.subTitle
        subTitle.fontSize = sizes.subTitle.size
        return subTitle
    }

    /// Set title style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: title style

    static private func titleStyle(settings: Settings, sizes: FontSizes) -> Styles {
        var title = Styles.from(settings: settings)
        title.cssClass = "title"
        title.fontColour = settings.fg.title
        title.fontSize = sizes.title.size
        return title
    }

    /// Set xLabel style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: xLabel style

    static private func xLabelStyle(settings: Settings, sizes: FontSizes) -> Styles {
        var xLabel = Styles.from(settings: settings)
        xLabel.colour = RGBAu8(settings.fg.axes, or: .black).clamped(opacity: 0.4).cssRGBA
        xLabel.cssClass = "xlabel"
        xLabel.fontColour = settings.fg.xLabel
        xLabel.fontSize = sizes.label.size
        xLabel.strokeWidth = 1.0
        return xLabel
    }

    /// Set xTags style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: xTags style

    static private func xTagsStyle(settings: Settings, sizes: FontSizes) -> Styles {
        var xTags = Styles.from(settings: settings)
        xTags.colour = RGBAu8(settings.fg.axes, or: .black).clamped(opacity: 0.4).cssRGBA
        xTags.cssClass = "xtags"
        xTags.fontColour = settings.fg.xTags
        xTags.fontSize = sizes.axes.size
        xTags.strokeWidth = 1.0
        return xTags
    }

    /// Set xTitle style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: xTitle style

    static private func xTitleStyle(settings: Settings, sizes: FontSizes) -> Styles {
        var xTitle = Styles.from(settings: settings)
        xTitle.cssClass = "xtitle"
        xTitle.fontColour = settings.fg.xTitle
        xTitle.fontSize = sizes.axes.size
        return xTitle
    }

    /// Set yLabel style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: yLabel style

    static private func yLabelStyle(settings: Settings, sizes: FontSizes) -> Styles {
        var yLabel = Styles.from(settings: settings)
        yLabel.colour = RGBAu8(settings.fg.axes, or: .black).clamped(opacity: 0.4).cssRGBA
        yLabel.cssClass = "ylabel"
        yLabel.fontColour = settings.fg.yLabel
        yLabel.fontSize = sizes.label.size
        yLabel.strokeWidth = 1.0
        yLabel.textAlign = "end"
        yLabel.textBaseline = "middle"
        return yLabel
    }

    /// Set yTitle style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: yTitle style

    static private func yTitleStyle(settings: Settings, sizes: FontSizes) -> Styles {
        var yTitle = Styles.from(settings: settings)
        yTitle.cssClass = "ytitle"
        yTitle.fontSize = sizes.axes.size
        return yTitle
    }
}

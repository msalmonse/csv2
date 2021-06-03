//
//  PropertiesList.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-10.
//

import Foundation

/// Lookup colour and return as CSS RGBA String
/// - Parameter colour: name or hash of colour
/// - Returns: colour as rgba()

fileprivate func cssRGBA(_ colour: String?, or notFound: RGBAu8 = .black) -> String {
    return RGBAu8(colour, or: notFound).cssRGBA
}

struct StylesList {
    var plots: [Styles]
    var axes: Styles
    var draft: Styles
    var legend: Styles
    var legendHeadline: Styles
    var legendBox: Styles
    var pieLabel: Styles
    var pieLegend: Styles
    var pieSubLegend: Styles
    var subTitle: Styles
    var title: Styles
    var xLabel: Styles
    var xTags: Styles
    var xTitle: Styles
    var yLabel: Styles
    var yTitle: Styles

    init(count ct: Int, settings: Settings) {
        let sizes = FontSizes(size: settings.doubleValue(.baseFontSize))
        plots = Array(repeating: Styles.from(settings: settings), count: ct)

        axes = Self.axesStyle(settings: settings, sizes: sizes)
        draft = Self.draftStyle(settings: settings)
        legend = Self.legendStyle(settings: settings, sizes: sizes)
        legendBox = Self.legendBoxStyle(settings: settings, sizes: sizes)
        legendHeadline = Self.legendHeadlineStyle(settings: settings, sizes: sizes)
        pieLabel = Self.pieLabelStyle(settings: settings, sizes: sizes)
        pieLegend = Self.pieLegendStyle(settings: settings, sizes: sizes)
        pieSubLegend = Self.pieSubLegendStyle(settings: settings, sizes: sizes)
        subTitle = Self.subTitleStyle(settings: settings, sizes: sizes)
        title = Self.titleStyle(settings: settings, sizes: sizes)
        xLabel = Self.xLabelStyle(settings: settings, sizes: sizes)
        xTags = Self.xTagsStyle(settings: settings, sizes: sizes)
        xTitle = Self.xTitleStyle(settings: settings, sizes: sizes)
        yLabel = Self.yLabelStyle(settings: settings, sizes: sizes)
        yTitle = Self.yTitleStyle(settings: settings, sizes: sizes)
    }

    /// Set axes style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: axes style

    static private func axesStyle(settings: Settings, sizes: FontSizes) -> Styles {
        var axes = Styles.from(settings: settings)
        axes.colour = cssRGBA(settings.stringValue(.axes, in: .foreground))
        axes.cssClass = "axes"
        return axes
    }

    /// Set legend style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: legend style

    static private func draftStyle(settings: Settings) -> Styles {
        var draft = Styles.from(settings: settings)
        draft.cssClass = "draft"
        draft.fontColour = cssRGBA(settings.stringValue(.draft, in: .foreground))
        draft.fontFamily = "sans-serif"
        draft.options[.bold] = false
        draft.options[.italic] = false
        draft.options[.stroked] = true
        draft.textAlign = "middle"
        draft.textBaseline = "middle"

        // calculate font size
        let text = settings.stringValue(.draftText)
        let charSize = min(settings.width / Double(text.count), settings.height / 2.0)
        draft.fontSize = floor(charSize * 1.25)

        // now the transform
        let x = settings.width / 2.0
        let y = settings.height / 2.0
        let angle = atan(settings.height / settings.width)
        draft.transform = Transform.rotateAround(x: x, y: y, sin: sin(angle), cos: cos(angle))

        return draft
    }

    /// Set legend style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: legend style

    static private func legendStyle(settings: Settings, sizes: FontSizes) -> Styles {
        var legend = Styles.from(settings: settings)
        legend.cssClass = "legend"
        legend.fontColour = cssRGBA(settings.stringValue(.legends, in: .foreground))
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
        legendBox.colour =
            RGBAu8(settings.stringValue(.legendsBox, in: .foreground), or: .black).clamped(opacity: 0.4).cssRGBA
        legendBox.fill = legendBox.colour
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
        legendHeadline.cssClass = "legendheadline"
        legendHeadline.fontColour = settings.stringValue(.legends, in: .foreground)
        legendHeadline.fontSize = sizes.legend.size * 1.25
        legendHeadline.textAlign = "start"
        return legendHeadline
    }

    /// Set pieLabel style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: pieLabel style

    static private func pieLabelStyle(settings: Settings, sizes: FontSizes) -> Styles {
        var pieLabel = Styles.from(settings: settings)
        pieLabel.cssClass = "pielabel"
        pieLabel.fontColour = cssRGBA(settings.stringValue(.pieLabel, in: .foreground))
        pieLabel.fontSize = sizes.pieLabel.size
        pieLabel.textAlign = ""
        return pieLabel
    }

    /// Set pieLegend style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: pieLegend style

    static private func pieLegendStyle(settings: Settings, sizes: FontSizes) -> Styles {
        var pieLegend = Styles.from(settings: settings)
        pieLegend.cssClass = "pielegend"
        pieLegend.fontColour = cssRGBA(settings.stringValue(.pieLegend, in: .foreground))
        pieLegend.fontSize = sizes.pieLegend.size
        return pieLegend
    }

    /// Set pieSubLegend style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: pieSubLegend style

    static private func pieSubLegendStyle(settings: Settings, sizes: FontSizes) -> Styles {
        var pieSubLegend = Styles.from(settings: settings)
        pieSubLegend.cssClass = "piesublegend"
        pieSubLegend.fontColour = cssRGBA(settings.stringValue(.pieLegend, in: .foreground))
        pieSubLegend.fontSize = sizes.pieSubLegend.size
        return pieSubLegend
    }

    /// Set subTitle style
    /// - Parameters:
    ///   - settings: chart settings
    ///   - sizes: font sizes
    /// - Returns: subTitle style

    static private func subTitleStyle(settings: Settings, sizes: FontSizes) -> Styles {
        var subTitle = Styles.from(settings: settings)
        subTitle.cssClass = "subtitle"
        subTitle.fontColour = cssRGBA(settings.stringValue(.subTitle, in: .foreground))
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
        title.fontColour = cssRGBA(settings.stringValue(.title, in: .foreground))
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
        xLabel.colour =
            RGBAu8(settings.stringValue(.axes, in: .foreground), or: .black).clamped(opacity: 0.4).cssRGBA
        xLabel.cssClass = "xlabel"
        xLabel.fontColour = cssRGBA(settings.stringValue(.xLabel, in: .foreground))
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
        xTags.colour =
            RGBAu8(settings.stringValue(.axes, in: .foreground), or: .black).clamped(opacity: 0.4).cssRGBA
        xTags.cssClass = "xtags"
        xTags.fontColour = cssRGBA(settings.stringValue(.xTags, in: .foreground))
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
        xTitle.fontColour = cssRGBA(settings.stringValue(.xTitle, in: .foreground))
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
        yLabel.colour =
            RGBAu8(settings.stringValue(.axes, in: .foreground), or: .black).clamped(opacity: 0.4).cssRGBA
        yLabel.cssClass = "ylabel"
        yLabel.fontColour = cssRGBA(settings.stringValue(.yLabel, in: .foreground))
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
        yTitle.fontColour = cssRGBA(settings.stringValue(.yTitle, in: .foreground))
        yTitle.fontSize = sizes.axes.size
        yTitle.textAlign = "start"
        return yTitle
    }
}

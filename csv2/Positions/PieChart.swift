//
//  PieChart.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-26.
//

import Foundation

// Function to reduce cyclomatic complexity

/// Test if a value is in range
/// - Parameters:
///   - r: range
///   - val: value to test
///   - alt: alternative value
/// - Returns: val if in range. alt otherwise

private func inRange(_ r: Range<Double>, _ val: Double, _ alt: Double = 0.0) -> Double {
    return r.contains(val) ? val : alt
}

/// Various layout positions

struct PieChart: Positions {
    // Vertical positions
    let bottomY: Double
    let legendY: Double
    let logoY: Double
    let subTitleY: Double
    let titleY: Double
    let topY: Double
    let xTagsY: Double
    let xTagsTopY: Double
    let xTicksY: Double
    let xTitleY: Double

    // Horizontal positions
    let leftX: Double
    let legendLeftX: Double
    let legendRightX: Double
    let logoX: Double
    let rightX: Double
    let yTickX: Double
    let yTitleX: Double

    /// Initialize a struct with positions on SVG
    /// - Parameters:
    ///   - settings: settings object
    ///   - dataLeft: least abscissa value
    ///   - sizes: font sizes

    init(_ settings: Settings) {
        let sizes = FontSizes(size: settings.dim.baseFontSize)
        let margin = ceil(settings.dim.baseFontSize * 0.75)
        let logoHeight = settings.plotter.logoURL.isEmpty ? 0.0 : settings.plotter.logoHeight
        let logoWidth = settings.plotter.logoURL.isEmpty ? 0.0 : settings.plotter.logoWidth

        // Calculate vertical positions

        // Bottom
        var pos = settings.height - margin
        doIf((0.0..<pos).contains(settings.dim.reserveBottom)) { pos -= settings.dim.reserveBottom }
        subTitleY = pos
        doIf(settings.plotter.subTitle.hasContent || settings.csv.subTitleHeader >= 0) {
            pos -= ceil(sizes.subTitle.spacing)
        }
        titleY = pos
        doIf(settings.plotter.title.hasContent) { pos -= ceil(sizes.title.spacing) }
        xTitleY = pos
        doIf(settings.plotter.xTitle.hasContent) { pos -= ceil(sizes.axes.spacing) }
        xTagsY = pos
        xTagsTopY = floor(pos - sizes.axes.size)
        doIf(settings.csv.xTagHeader >= 0) { pos -= sizes.axes.spacing }
        xTicksY = pos
        doIf(settings.dim.xTick >= 0) { pos -= sizes.label.spacing }
        bottomY = pos

        // top
        pos = margin
        doIf((0.0..<bottomY).contains(settings.dim.reserveTop)) { pos += settings.dim.reserveTop }
        topY = pos
        logoY = pos
        legendY = ceil(topY + max(sizes.legend.size * 2.0, logoHeight + margin))

        // Calculate horizontal positions

        // left
        pos = margin
        doIf((0.0..<settings.width).contains(settings.dim.reserveLeft)) { pos += settings.dim.reserveLeft }
        doIf(settings.plotter.yTitle.hasContent) { pos += ceil(sizes.axes.spacing) }
        yTitleX = pos
        doIf(settings.dim.yTick >= 0) { pos += sizes.label.size * 4.0 }
        yTickX = pos
        pos += ceil(settings.css.strokeWidth)
        leftX = pos

        // legends are on the right
        pos = settings.width - margin
        doIf((0.0..<pos).contains(settings.dim.reserveRight)) { pos -= settings.dim.reserveRight }
        logoX = pos - logoWidth
        legendRightX = pos
        if !settings.plotter.legends {
            legendLeftX = pos
        } else {
            let newpos = floor(pos - max(6.0 * sizes.legend.size, logoWidth))
            if (newpos - leftX) >= 0.8 * settings.width {
                pos = newpos
                legendLeftX = pos
            } else {
                print("Plottable area is too small, legends suppressed.", to: &standardError)
                legendLeftX = pos + pos
            }
        }
        // Allow for some space for tick labels
        pos -= ceil(2.0 * sizes.label.size)
        rightX = pos
    }
}

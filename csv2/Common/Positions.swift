//
//  SVG/Positions.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-10.
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

struct Positions {
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

    init(_ settings: Settings, dataLeft: Double) {
        let sizes = FontSizes(size: settings.dim.baseFontSize)
        let margin = ceil(settings.dim.baseFontSize * 0.75)
        let logoHeight = settings.plotter.logoURL.isEmpty ? 0.0 : settings.plotter.logoHeight
        let logoWidth = settings.plotter.logoURL.isEmpty ? 0.0 : settings.plotter.logoWidth
        // Calculate vertical positions
        // Bottom
        var pos = settings.height - margin
        pos -= inRange(0.0..<pos, settings.dim.reserveBottom)
        subTitleY = pos
        pos -= ceil((settings.plotter.subTitle.hasContent || settings.csv.subTitleHeader >= 0)
            ? sizes.subTitleSize * 1.25 : 0.0)
        titleY = pos
        pos -= ceil((settings.plotter.title.hasContent) ? sizes.titleSize * 1.25 : 0.0)
        xTitleY = pos
        pos -= ceil((settings.plotter.xTitle.hasContent) ? sizes.axesSize * 1.25 : 0.0)
        xTagsY = pos
        xTagsTopY = floor(pos - sizes.axesSize)
        pos -= ceil((settings.csv.xTagHeader >= 0) ? sizes.axesSize * 1.25 : 0.0)
        xTicksY = pos
        pos -= ceil((settings.dim.xTick >= 0) ? sizes.labelSize * 1.25 : 0.0)
        bottomY = pos

        // top
        pos = margin
        pos += inRange(0.0..<bottomY, settings.dim.reserveTop)
        topY = pos
        logoY = pos
        legendY = ceil(topY + max(sizes.legendSize * 2.0, logoHeight + margin))

        // Calculate horizontal positions
        pos = margin
        pos += inRange(0.0..<settings.width, settings.dim.reserveLeft)
        pos += ceil((settings.plotter.yTitle.hasContent) ? sizes.axesSize * 1.25 : 0.0)
        yTitleX = pos
        // Give some extra space for minus sign
        pos += ceil((settings.dim.yTick < 0) ? 0.0 : sizes.labelSize * (dataLeft < 0.0 ? 3.5 : 4.0))
        yTickX = pos
        pos += ceil(settings.css.strokeWidth)
        leftX = pos

        // legends are on the right
        pos = settings.width - margin
        pos -= inRange(0.0..<pos, settings.dim.reserveRight)
        logoX = pos - logoWidth
        legendRightX = pos
        if !settings.plotter.legends {
            legendLeftX = pos
        } else {
            let newpos = floor(pos - max(6.0 * sizes.legendSize, logoWidth))
            if (newpos - leftX) >= 0.8 * settings.width {
                pos = newpos
                legendLeftX = pos
            } else {
                print("Plottable area is too small, legends suppressed.", to: &standardError)
                legendLeftX = pos + pos
            }
        }
        // Allow for some space for tick labels
        pos -= ceil(2.0 * sizes.labelSize)
        rightX = pos
    }
}

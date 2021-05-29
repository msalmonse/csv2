//
//  SVG/Positions.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-10.
//

import Foundation

/// Various layout positions

struct Horizontal: Positions {
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
        let sizes = FontSizes(size: settings.doubleValue(.baseFontSize))
        let margin = ceil(settings.doubleValue(.baseFontSize) * 0.75)
        let logoHeight = settings.stringValue(.logoURL).isEmpty ? 0.0 : settings.doubleValue(.logoHeight)
        let logoWidth = settings.stringValue(.logoURL).isEmpty ? 0.0 : settings.doubleValue(.logoWidth)
        var reserve: Double

        // Calculate vertical positions

        // Bottom
        var pos = settings.height - margin
        reserve = settings.doubleValue(.reserveBottom)
        doIf(0.0..<pos ~= reserve) { pos -= reserve }
        subTitleY = pos
        doIf(settings.hasContent(.subTitle) || settings.intValue(.subTitleHeader) >= 0) {
            pos -= ceil(sizes.subTitle.spacing)
        }
        titleY = pos
        doIf(settings.hasContent(.title)) { pos -= ceil(sizes.title.spacing) }
        xTitleY = pos
        doIf(settings.hasContent(.xTitle)) { pos -= ceil(sizes.axes.spacing) }
        xTagsY = pos
        xTagsTopY = floor(pos - sizes.axes.size)
        doIf(settings.intValue(.xTagsHeader) >= 0) { pos -= sizes.axes.spacing }
        xTicksY = pos
        doIf(settings.doubleValue(.xTick) >= 0) { pos -= sizes.label.spacing }
        bottomY = pos

        // top
        pos = margin
        reserve = settings.doubleValue(.reserveTop)
        doIf(0.0..<bottomY ~= reserve) { pos += reserve }
        topY = pos
        logoY = pos
        legendY = ceil(topY + max(sizes.legend.size * 2.0, logoHeight + margin))

        // Calculate horizontal positions

        // left
        pos = margin
        reserve = settings.doubleValue(.reserveLeft)
        doIf(0.0..<settings.width ~= reserve) { pos += reserve }
        doIf(settings.hasContent(.yTitle)) { pos += ceil(sizes.axes.spacing) }
        yTitleX = pos
        doIf(settings.doubleValue(.yTick) >= 0) { pos += sizes.label.size * 4.0 }
        yTickX = pos
        pos += ceil(settings.strokeWidth)
        leftX = pos

        // legends are on the right
        pos = settings.width - margin
        reserve = settings.doubleValue(.reserveRight)
        doIf(0.0..<pos ~= reserve) { pos -= reserve }
        logoX = pos - logoWidth
        legendRightX = pos
        if !settings.boolValue(.legends) {
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

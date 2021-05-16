//
//  OptionDefaults.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-28.
//

import Foundation

extension Options {
    /// Create defaults from command line
    /// - Parameter cmd: plotter command type
    /// - Returns: defaults

    func defaults() -> Defaults {
        return Defaults(
            backgroundColour: bg,
            bared: bared,           barOffset: baroffset,   barWidth: barwidth,
            baseFontSize: size,
            bezier: bezier,
            black: black,
            bold: bold,
            bounded: !nobounds,
            canvasID: cmd.ownOptions(key: .canvas, default: Defaults.global.canvasID),
            chartType: pie ? .pieChart : .horizontal,
            colours: colours,
            comment: !nocomment,
            cssClasses: [],         cssExtras: [],
            cssID: cmd.ownOptions(key: .cssid, default: Defaults.global.cssID),
            cssInclude: cmd.ownOptions(key: .css, default: Defaults.global.cssInclude),
            dashedLines: dashed,    dashes: dashes,
            dataPointDistance: distance,
            filled: filled,
            fontFamily: font,
            foregroundColour: fg,
            headers: headers,
            height: height,
            hover: cmd.ownOptions(key: .hover, default: true),
            include: include,
            index: index,
            italic: italic,
            legends: !nolegends,
            logoHeight: Defaults.global.logoHeight, logoURL: logo,  logoWidth: Defaults.global.logoWidth,
            logx: logx,         logy: logy,
            nameHeader: nameheader,
            names: names,
            opacity: opacity,
            reserveBottom: reserve.hasIndex(3) ? reserve[3] : 0.0,
            reserveLeft: reserve.hasIndex(0) ? reserve[0] : 0.0,
            reserveRight: reserve.hasIndex(2) ? reserve[2] : 0.0,
            reserveTop: reserve.hasIndex(1) ? reserve[1] : 0.0,
            rowGrouping: rows && !pie,          // in pie charts the data is in columns
            scattered: scattered,
            shapes: shapes,
            showDataPoints: showpoints,
            sortx: sortx,
            smooth: smooth,
            strokeWidth: stroke,
            subTitle: subtitle,
            subTitleHeader: subheader,
            svgInclude: cmd.ownOptions(key: .svg, default: Defaults.global.svgInclude),
            textColour: textcolour,
            title: title,
            width: width,
            xMax: xmax,     xMin: xmin,
            xTagsHeader: xtags,
            xTick: xtick,
            yMax: ymax,     yMin: ymin,
            yTick: ytick
        )
    }
}

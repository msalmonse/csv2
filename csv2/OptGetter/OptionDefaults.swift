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
            onCommandLine: onCommandLine,
            backgroundColour: bg,
            bared: bared,           barOffset: baroffset,   barWidth: barwidth,
            baseFontSize: size,
            bezier: bezier,
            black: black,
            bold: bold,
            bounded: bounds,
            canvasID: canvas,
            chartType: pie ? .pieChart : .horizontal,
            colours: colours,
            comment: comment,
            cssClasses: [],         cssExtras: [],
            cssID: cssid,
            cssInclude: css,
            dashedLines: dashed,    dashes: dashes,
            dataPointDistance: distance,
            filled: filled,
            fontFamily: font,
            foregroundColour: fg,
            headers: headers,
            height: height,
            hover: hover,
            include: include,
            index: index,
            italic: italic,
            legends: legends,
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
            svgInclude: svg,
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

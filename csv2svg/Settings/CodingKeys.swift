//
//  CodingKeys.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-30.
//

import Foundation

extension Settings {
    enum CodingKeys: CodingKey {
        case backgroundColour
        case baseFontSize
        case bezier
        case black
        case bold
        case colours
        case comment
        case cssClasses
        case cssExtras
        case cssID
        case cssInclude
        case dashedLines
        case dashes
        case dataPointDistance
        case fontFamily
        case headerColumns
        case headerRows
        case height
        case hover
        case include
        case index
        case italic
        case legends
        case logoHeight
        case logoURL
        case logoWidth
        case logx
        case logy
        case nameHeader
        case names
        case opacity
        case reserveBottom
        case reserveLeft
        case reserveRight
        case reserveTop
        case rowGrouping
        case scatterPlots
        case shapes
        case showDataPoints
        case smooth
        case sortx
        case strokeWidth
        case subTitle
        case subTitleHeader
        case svgInclude
        case title
        case width
        case xMax
        case xMin
        case xTick
        case xTitle
        case yMax
        case yMin
        case yTick
        case yTitle
    }
}

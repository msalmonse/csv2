//
//  CodingKeys.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-30.
//

import Foundation

extension Settings {
    enum CodingKeys: CodingKey {
        case author
        case axes
        case backgroundColour
        case bared
        case barOffset
        case barWidth
        case baseFontSize
        case bezier
        case black
        case bold
        case bounded
        case canvasID
        case chartType
        case colours
        case comment
        case cssClasses
        case cssExtras
        case cssID
        case cssInclude
        case dashedLines
        case dashes
        case dataPointDistance
        case filled
        case fontFamily
        case foregroundColours
        case headerColumns
        case headerRows
        case height
        case hover
        case include
        case index
        case italic
        case keywords
        case legends
        case legendsBox
        case logoHeight
        case logoURL
        case logoWidth
        case logx
        case logy
        case nameHeader
        case names
        case opacity
        case pdf
        case pieLabel
        case pieLegend
        case pieSubLegend
        case pieSubLegendPrefix
        case pieSubLegendSuffix
        case producer
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
        case subject
        case subTitle
        case subTitleHeader
        case svgInclude
        case title
        case width
        case xLabel
        case xMax
        case xMin
        case xTags
        case xTagsHeader
        case xTick
        case xTitle
        case yLabel
        case yMax
        case yMin
        case yTick
        case yTitle

        var name: String {
            return self.stringValue
        }
    }
}

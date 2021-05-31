//
//  CodingKeys.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-30.
//

import Foundation

extension Settings {
    enum CodingType {
        case isBool, isDouble, isInt, isInt1, isString, isStringArray
        case isNone     // special cases
    }

    enum CodingKeys: CodingKey, CaseIterable {
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
        case draft
        case draftText
        case filled
        case fontFamily
        case foregroundColour
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
        case tagFile
        case textcolour
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

extension Settings.CodingKeys {
    var codingType: Settings.CodingType {
        switch self {
        case .author: return .isString
        case .axes: return .isString
        case .backgroundColour: return .isString
        case .bared: return .isInt
        case .barOffset: return .isDouble
        case .barWidth: return .isDouble
        case .baseFontSize: return .isDouble
        case .bezier: return .isDouble
        case .black: return .isBool
        case .bold: return .isBool
        case .bounded: return .isBool
        case .canvasID: return .isString
        case .chartType: return .isString
        case .colours: return .isStringArray
        case .comment: return .isBool
        case .cssClasses: return .isStringArray
        case .cssExtras: return .isStringArray
        case .cssID: return .isString
        case .cssInclude: return .isString
        case .dashedLines: return .isInt
        case .dashes: return .isStringArray
        case .dataPointDistance: return .isDouble
        case .draft: return .isBool
        case .draftText: return .isString
        case .filled: return .isInt
        case .fontFamily: return .isString
        case .foregroundColour: return .isString
        case .foregroundColours: return .isNone
        case .headerColumns: return .isInt
        case .headerRows: return .isInt
        case .height: return .isInt
        case .hover: return .isBool
        case .include: return .isInt
        case .index: return .isInt1
        case .italic: return .isBool
        case .keywords: return .isString
        case .legends: return .isBool
        case .legendsBox: return .isString
        case .logoHeight: return .isDouble
        case .logoURL: return .isString
        case .logoWidth: return .isDouble
        case .logx: return .isBool
        case .logy: return .isBool
        case .nameHeader: return .isInt1
        case .names: return .isStringArray
        case .opacity: return .isDouble
        case .pdf: return .isNone
        case .pieLabel: return .isBool
        case .pieLegend: return .isString
        case .pieSubLegend: return .isBool
        case .pieSubLegendPrefix: return .isString
        case .pieSubLegendSuffix: return .isString
        case .reserveBottom: return .isDouble
        case .reserveLeft: return .isDouble
        case .reserveRight: return .isDouble
        case .reserveTop: return .isDouble
        case .rowGrouping: return .isBool
        case .scatterPlots: return .isInt
        case .shapes: return .isStringArray
        case .showDataPoints: return .isInt
        case .smooth: return .isDouble
        case .sortx: return .isBool
        case .strokeWidth: return .isDouble
        case .subject: return .isString
        case .subTitle: return .isString
        case .subTitleHeader: return .isInt1
        case .svgInclude: return .isString
        case .tagFile: return .isString
        case .textcolour: return .isString
        case .title: return .isString
        case .width: return .isInt
        case .xLabel: return .isString
        case .xMax: return .isDouble
        case .xMin: return .isDouble
        case .xTags: return .isString
        case .xTagsHeader: return .isInt1
        case .xTick: return .isDouble
        case .xTitle: return .isString
        case .yLabel: return .isString
        case .yMax: return .isDouble
        case .yMin: return .isDouble
        case .yTick: return .isDouble
        case .yTitle: return .isString
        }
    }
}

extension Settings.CodingKeys {
    var doubleBounds: ClosedRange<Double>? {
        switch self {
        case .baseFontSize: return Defaults.baseFontSizeBounds
        case .bezier: return Defaults.bezierBounds
        case .opacity: return Defaults.opacityBounds
        case .smooth: return Defaults.smoothBounds
        case .strokeWidth: return Defaults.strokeWidthBounds
        default: return nil
        }
    }

    var intBounds: ClosedRange<Int>? {
        switch self {
        case .headerColumns: return Defaults.headerBounds
        case .headerRows: return Defaults.headerBounds
        case .index: return Defaults.headerBounds
        case .nameHeader: return Defaults.headerBounds
        case .subTitleHeader: return Defaults.headerBounds
        case .xTagsHeader: return Defaults.headerBounds
        default: return nil
        }
    }
}

extension Settings.CodingKeys {
    /// Where a key should be.
    var domain: DomainKey {
        switch self {
        case .canvasID, .tagFile: return .canvas
        case .cssID, .cssExtras, .cssClasses, .cssInclude, .svgInclude: return .svg
        default: return .topLevel
        }
    }
}

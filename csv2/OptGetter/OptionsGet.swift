//
//  OptionsGet.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-16.
//

import Foundation
import OptGetter

extension Options {

    // swiftlint:disable function_body_length

    /// Assign an option from the command line
    /// - Parameter opt: the opt to assign
    /// - Throws: OptGetterError.illegalValue

    mutating func getOpt(opt: OptGot) throws {
        do {
            // swiftlint:disable:next force_cast
            let optTag = opt.tag as! Key
            let val0 = opt.optValuesAt.hasIndex(0)  ? opt.optValuesAt[0] : OptValueAt.empty

            switch optTag {
            case .bared: bared = try getInt(val0, key: .bared)
            case .baroffset: baroffset = try getDouble(val0, key: .barOffset)
            case .barwidth: barwidth = try getDouble(val0, key: .barWidth)
            case .bezier: bezier = try getDouble(val0, key: .bezier)
            case .bg: bg = try getColour(val0, key: .backgroundColour)
            case .bitmap: bitmap = try getIntArray(opt.optValuesAt, key: nil)
            case .black: black = getBool(true, key: .black)
            case .bold: bold = getBool(true, key: .bold)
            case .bounds: bounds = false
            case .canvas: canvas = getString(val0, key: .canvasID)
            case .canvastag: canvastag = true
            case .colournames: colournames = true
            case .colournameslist: colournameslist = true
            case .colours: colours = try getColourArray(opt.optValuesAt, key: .colours)
            case .colourslist: colourslist = true
            case .comment: comment = getBool(false, key: .comment)
            case .css: css = getString(val0, key: .cssInclude)
            case .cssid: cssid = getString(val0, key: .cssID)
            case .dashed: dashed = try getInt(val0, key: .dashedLines)
            case .dashes: dashes = getStringArray(opt.optValuesAt, key: .dashes)
            case .dasheslist: dasheslist = true
            case .debug: debug = try getInt(val0, key: nil)
            case .distance: distance = try getDouble(val0, key: .dataPointDistance)
            case .fg: fg = try getColour(val0, key: nil)
            case .filled: filled = try getInt(val0, key: .filled)
            case .font: font = getString(val0, key: .fontFamily)
            case .headers: headers = try getInt(val0, key: nil)
            case .height: height = try getInt(val0, key: .height)
            case .hover: hover = getBool(false, key: .hover)
            case .include: include = try getInt(val0, key: .include)
            case .index: index = try getInt(val0, key: .index)
            case .italic: italic = getBool(true, key: .italic)
            case .legends: legends = getBool(false, key: .legends)
            case .logo: logo = getString(val0, key: .logoURL)
            case .logx: logx = getBool(true, key: .logx)
            case .logy: logy = getBool(true, key: .logy)
            case .nameheader: nameheader = try getInt(val0, key: .nameHeader)
            case .names: names = getStringArray(opt.optValuesAt, key: .names)
            case .opacity: opacity = try getDouble(val0, key: .opacity)
            case .pie: pie = true
            case .random: random = try getIntArray(opt.optValuesAt, key: nil)
            case .reserve: reserve = try getDoubleArray(opt.optValuesAt, key: nil)
            case .rows: rows = getBool(true, key: .rowGrouping)
            case .scattered: scattered = try getInt(val0, key: .scatterPlots)
            case .semi: semi = true
            case .shapenames: shapenames = true
            case .shapes: shapes = getStringArray(opt.optValuesAt, key: .shapes)
            case .show: show = getString(val0, key: nil)
            case .showpoints: showpoints = try getInt(val0, key: .showDataPoints)
            case .size: size = try getDouble(val0, key: .baseFontSize)
            case .smooth: smooth = try getDouble(val0, key: .smooth)
            case .sortx: sortx = getBool(true, key: .sortx)
            case .stroke: stroke = try getDouble(val0, key: .strokeWidth)
            case .subheader: subheader = try getInt(val0, key: .subTitleHeader)
            case .subtitle: subtitle = getString(val0, key: .subTitle)
            case .svg: svg = getString(val0, key: .svgInclude)
            case .textcolour: textcolour = try getColour(val0, key: nil)
            case .title: title = getString(val0, key: .title)
            case .tsv: tsv = true
            case .verbose: verbose = true
            case .version: version = true
            case .width: width = try getInt(val0, key: .width)
            case .xmax: xmax = try getDouble(val0, key: .xMax)
            case .xmin: xmin = try getDouble(val0, key: .xMin)
            case .xtags: xtags = try getInt(val0, key: .xTags)
            case .xtick: xtick = try getDouble(val0, key: .xTick)
            case .ymax: ymax = try getDouble(val0, key: .yMax)
            case .ymin: ymin = try getDouble(val0, key: .yMin)
            case .ytick: ytick = try getDouble(val0, key: .yTick)
            }
        } catch {
            throw error
        }
    }
}

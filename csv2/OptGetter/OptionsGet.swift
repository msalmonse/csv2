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
            case .bared: try getInt(val0, key: .bared)
            case .baroffset: try getDouble(val0, key: .barOffset)
            case .barwidth: try getDouble(val0, key: .barWidth)
            case .bezier: try getDouble(val0, key: .bezier)
            case .bg: getString(val0, key: .backgroundColour)
            case .bitmap: bitmap = try OptValueAt.intArray(opt.optValuesAt)
            case .black: getBool(true, key: .black)
            case .bold: getBool(true, key: .bold)
            case .bounds: getBool(false, key: .bounded)
            case .canvas: getString(val0, key: .canvasID)
            case .canvastag: canvastag = true
            case .colournames: colournames = true
            case .colournameslist: colournameslist = true
            case .colours: getStringArray(opt.optValuesAt, key: .colours)
            case .colourslist: colourslist = true
            case .comment: getBool(false, key: .comment)
            case .css: getString(val0, key: .cssInclude)
            case .cssid: getString(val0, key: .cssID)
            case .dashed: try getInt(val0, key: .dashedLines)
            case .dashes: getStringArray(opt.optValuesAt, key: .dashes)
            case .dasheslist: dasheslist = true
            case .debug: debug = try getInt(val0, key: nil)
            case .distance: try getDouble(val0, key: .dataPointDistance)
            case .fg: getString(val0, key: .foregroundColour)
            case .filled: try getInt(val0, key: .filled)
            case .font: getString(val0, key: .fontFamily)
            case .headers: try getInt(val0, key: nil)
            case .help: helpAndExit()
            case .height: try getInt(val0, key: .height)
            case .hover: getBool(false, key: .hover)
            case .include: try getInt(val0, key: .include)
            case .index: try getInt(val0, key: .index)
            case .italic: getBool(true, key: .italic)
            case .legends: getBool(false, key: .legends)
            case .logo: getString(val0, key: .logoURL)
            case .logx: getBool(true, key: .logx)
            case .logy: getBool(true, key: .logy)
            case .nameheader: try getInt(val0, key: .nameHeader)
            case .names: getStringArray(opt.optValuesAt, key: .names)
            case .opacity: try getDouble(val0, key: .opacity)
            case .pie:
                values.values[.chartType] = .stringValue(val: "piechart")
                values.onCommandLine.insert(.chartType)
            case .random: random = try OptValueAt.intArray(opt.optValuesAt)
            case .reserve:
                switch opt.optValuesAt.count {
                case 4:
                    try getDouble(opt.optValuesAt[3], key: .reserveBottom)
                    fallthrough
                case 3:
                    try getDouble(opt.optValuesAt[2], key: .reserveRight)
                    fallthrough
                case 2:
                    try getDouble(opt.optValuesAt[1], key: .reserveTop)
                    fallthrough
                case 1:
                    try getDouble(opt.optValuesAt[0], key: .reserveLeft)
                default:
                    break
                }
            case .rows: getBool(true, key: .rowGrouping)
            case .scattered: try getInt(val0, key: .scatterPlots)
            case .semi: semi = true
            case .shapenames: shapenames = true
            case .shapes: getStringArray(opt.optValuesAt, key: .shapes)
            case .show: show = val0.stringValue()
            case .showpoints: try getInt(val0, key: .showDataPoints)
            case .size: try getDouble(val0, key: .baseFontSize)
            case .smooth: try getDouble(val0, key: .smooth)
            case .sortx: getBool(true, key: .sortx)
            case .stroke: try getDouble(val0, key: .strokeWidth)
            case .subheader: try getInt(val0, key: .subTitleHeader)
            case .subtitle: getString(val0, key: .subTitle)
            case .svg: getString(val0, key: .svgInclude)
            case .textcolour: getString(val0, key: .textcolour)
            case .title: getString(val0, key: .title)
            case .tsv: tsv = true
            case .verbose: verbose = true
            case .version: version = true
            case .width: try getInt(val0, key: .width)
            case .xmax: try getDouble(val0, key: .xMax)
            case .xmin: try getDouble(val0, key: .xMin)
            case .xtags: try getInt(val0, key: .xTags)
            case .xtick: try getDouble(val0, key: .xTick)
            case .ymax: try getDouble(val0, key: .yMax)
            case .ymin: try getDouble(val0, key: .yMin)
            case .ytick: try getDouble(val0, key: .yTick)
            }
        } catch {
            throw error
        }
    }

    func helpAndExit() {
        help(CommandType.help)
        exit(0)
    }
}

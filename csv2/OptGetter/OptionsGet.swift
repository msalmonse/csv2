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
            case .bared: try setInt(val0, key: .bared)
            case .baroffset: try setDouble(val0, key: .barOffset)
            case .barwidth: try setDouble(val0, key: .barWidth)
            case .bezier: try setDouble(val0, key: .bezier)
            case .bg: setString(val0, key: .backgroundColour)
            case .black: setBool(true, key: .black)
            case .bold: setBool(true, key: .bold)
            case .bounds: setBool(false, key: .bounded)
            case .canvas: setString(val0, key: .canvasID)
            case .colours: setStringArray(opt.optValuesAt, key: .colours)
            case .comment: setBool(false, key: .comment)
            case .css: setString(val0, key: .cssInclude)
            case .cssid: setString(val0, key: .cssID)
            case .dashed: try setInt(val0, key: .dashedLines)
            case .dashes: setStringArray(opt.optValuesAt, key: .dashes)
            case .debug: debug = try val0.intValue()
            case .distance: try setDouble(val0, key: .dataPointDistance)
            case .draft:
                setBool(true, key: .draft)
                if !val0.isEmpty { setString(val0, key: .draftText) }
            case .fg: setString(val0, key: .foregroundColour)
            case .filled: try setInt(val0, key: .filled)
            case .font: setString(val0, key: .fontFamily)
            case .headers:
                try setInt(val0, key: .headerColumns)
                try setInt(val0, key: .headerRows)
            case .help: helpAndExit()
            case .height: try setInt(val0, key: .height)
            case .hover: setBool(false, key: .hover)
            case .include: try setInt(val0, key: .include)
            case .index: try setInt(val0, key: .index)
            case .italic: setBool(true, key: .italic)
            case .legends: setBool(false, key: .legends)
            case .logo: setString(val0, key: .logoURL)
            case .logx: setBool(true, key: .logx)
            case .logy: setBool(true, key: .logy)
            case .nameheader: try setInt(val0, key: .nameHeader)
            case .names: setStringArray(opt.optValuesAt, key: .names)
            case .opacity: try setDouble(val0, key: .opacity)
            case .pie:
                values.values[.chartType] = .stringValue(val: "piechart")
                values.onCommandLine.insert(.chartType)
            case .random: random = try OptValueAt.intArray(opt.optValuesAt)
            case .reserve:
                switch opt.optValuesAt.count {
                case 4:
                    try setDouble(opt.optValuesAt[3], key: .reserveBottom)
                    fallthrough
                case 3:
                    try setDouble(opt.optValuesAt[2], key: .reserveRight)
                    fallthrough
                case 2:
                    try setDouble(opt.optValuesAt[1], key: .reserveTop)
                    fallthrough
                case 1:
                    try setDouble(opt.optValuesAt[0], key: .reserveLeft)
                default:
                    break
                }
            case .rows: setBool(true, key: .rowGrouping)
            case .scattered: try setInt(val0, key: .scatterPlots)
            case .semi: semi = true
            case .shapes: setStringArray(opt.optValuesAt, key: .shapes)
            case .showpoints: try setInt(val0, key: .showDataPoints)
            case .size: try setDouble(val0, key: .baseFontSize)
            case .smooth: try setDouble(val0, key: .smooth)
            case .sortx: setBool(true, key: .sortx)
            case .stroke: try setDouble(val0, key: .strokeWidth)
            case .subheader: try setInt(val0, key: .subTitleHeader)
            case .subtitle: setString(val0, key: .subTitle)
            case .svg: setString(val0, key: .svgInclude)
            case .textcolour: setString(val0, key: .textcolour)
            case .title: setString(val0, key: .title)
            case .tsv: tsv = true
            case .verbose: verbose = true
            case .width: try setInt(val0, key: .width)
            case .xmax: try setDouble(val0, key: .xMax)
            case .xmin: try setDouble(val0, key: .xMin)
            case .xtags: try setInt(val0, key: .xTags)
            case .xtick: try setDouble(val0, key: .xTick)
            case .ymax: try setDouble(val0, key: .yMax)
            case .ymin: try setDouble(val0, key: .yMin)
            case .ytick: try setDouble(val0, key: .yTick)
            }
        } catch {
            throw error
        }
    }

    func helpAndExit() {
        help(HelpCommandType.help)
        exit(0)
    }
}

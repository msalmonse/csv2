//
//  OptionsGet.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-16.
//

import Foundation
import OptGetter

extension Options {

    /// Assign an option from the command line
    /// - Parameter opt: the opt to assign
    /// - Throws: OptGetterError.illegalValue

    mutating func getOpt(opt: OptGot) throws {
        do {
            // swiftlint:disable:next force_cast
            let optTag = opt.tag as! Key
            let val0 = opt.valuesAt[0]

            switch optTag {
            case .bared: bared = try getInt(val0, key: .bared)
            case .baroffset: baroffset = try getDouble(val0, key: .barOffset)
            case .barwidth: barwidth = try getDouble(val0, key: .barWidth)
            case .bezier: bezier = try getDouble(val0, key: .bezier)
            // case .bg:
            case .black: black = getBool(true, key: .black)
            case .bold: bold = getBool(true, key: .bold)
            case .bounds: bounds = getBool(false, key: nil)
            case .bitmap: bitmap = try getIntArray(opt.valuesAt, key: nil)
            case .canvas: canvas = getString(val0, key: .canvasID)
            case .canvastag: canvastag = getBool(true, key: nil)
            case .css: css = getString(val0, key: .cssInclude)
            case .cssid: cssid = getString(val0, key: .cssID)
            // case .colours:
            case .comment: comment = getBool(false, key: .comment)
            default: break
            }
        } catch {
            throw error
        }
    }
}

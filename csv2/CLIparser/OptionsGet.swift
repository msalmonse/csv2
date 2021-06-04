//
//  OptionsGet.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-16.
//

import Foundation
import CLIparser

extension Options {

    /// Assign an option from the command line
    /// - Parameter opt: the opt to assign
    /// - Throws: CLIparserError.illegalValue

    mutating func getOpt(opt: OptGot) throws {
        do {
            // swiftlint:disable:next force_cast
            let optTag = opt.tag as! OptionsKey
            let val0 = opt.optValuesAt.hasIndex(0)  ? opt.optValuesAt[0] : OptValueAt.empty

            switch optTag {
            case let .bitmapValue(key, _): try setBitmap(opt.optValuesAt, key: key)
            case let .boolSpecial(key, _):
                switch key {
                case .help: helpAndExit()
                case .pie:
                    values.setValue(.chartType, .stringValue(val: "piechart"))
                    values.onCLI(.chartType)
                case .semi: semi = true
                case .tsv: tsv = true
                case .verbose: verbose = true
                }
            case let .boolValue(key, _): setBool((opt.count > 0), key: key)
            case .doubleArray: break
            case let .doubleSpecialArray(key, _):
                switch key {
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
                }
            case let .doubleValue(key, _): try setDouble(val0, key: key)
            case let .intSpecial(key, _):
                switch key {
                case .debug: debug = try val0.intValue()
                case .headers:
                    try setInt(val0, key: .headerColumns)
                    try setInt(val0, key: .headerRows)
                case .indent: UsageLeftRight.setIndent(try val0.intValue())
                case .left: UsageLeftRight.setLeft(try val0.intValue())
                case .right: UsageLeftRight.setRight(try val0.intValue())
                case .usage: UsageLeftRight.setUsage(try val0.intValue())
                }
            case let .intSpecialArray(key, _):
                switch key {
                case .random: random = try OptValueAt.intArray(opt.optValuesAt)
                }
            case let .intValue(key, _): try setInt(val0, key: key)
            case .positionalValues: setPositional(OptValueAt.stringArray(opt.optValuesAt))
            case let .stringArray(key, _): setStringArray(opt.optValuesAt, key: key)
            case let .stringSpecial(key, _):
                switch key {
                case .draft:
                    setBool(true, key: .draft)
                    if !val0.isEmpty { setString(val0, key: .draftText) }
                }
            case let .stringValue(key, _): setString(val0, key: key)
            }
        } catch {
            throw error
        }
    }

    /// Set the positional parameters
    /// - Parameter values: array of strings

    mutating func setPositional(_ values: [String]) {
        switch values.count {
        case 3:
            outName = values[2]
            fallthrough
        case 2:
            jsonName = values[1]
            fallthrough
        case 1:
            csvName = values[0]
        default:
            break
        }
    }

    func helpAndExit() {
        help(HelpCommandType.help)
        exit(0)
    }
}

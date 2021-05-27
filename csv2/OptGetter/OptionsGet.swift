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
            let val0 = opt.optValuesAt.hasIndex(0)  ? opt.optValuesAt[0] : OptValueAt.empty

            switch optTag {
            case .boolSpecial(let key, _):
                switch key {
                case .help: helpAndExit()
                case .pie:
                    values.values[.chartType] = .stringValue(val: "piechart")
                    values.onCommandLine.insert(.chartType)
                case .semi: semi = true
                case .tsv: tsv = true
                case .verbose: verbose = true
                }
            case .boolValue(let key, _): setBool((opt.count > 0), key: key)
            case .doubleArray: break
            case .doubleSpecialArray(let key, _):
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
            case .doubleValue(let key, _): try setDouble(val0, key: key)
            case .intSpecial(let key, _):
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
            case .intSpecialArray(let key, _):
                switch key {
                case .random: random = try OptValueAt.intArray(opt.optValuesAt)
                }
            case .intValue(let key, _): try setInt(val0, key: key)
            case .stringArray(let key, _): setStringArray(opt.optValuesAt, key: key)
            case .stringSpecial(let key, _):
                switch key {
                case .draft:
                    setBool(true, key: .draft)
                    if !val0.isEmpty { setString(val0, key: .draftText) }
                }
            case .stringValue(let key, _): setString(val0, key: key)
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

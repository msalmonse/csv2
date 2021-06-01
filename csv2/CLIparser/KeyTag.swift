//
//  KeyTag.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-16.
//

import Foundation
import CLIparser

extension Options {
    enum BoolSpecialKey {
        case help
        case pie
        case semi
        case tsv
        case verbose
    }

    enum DoubleArraySpecialKey {
        case reserve
    }

    enum IntArraySpecialKey {
        case random
    }

    enum IntSpecialKey {
        case debug
        case headers
        case indent
        case left
        case right
        case usage
    }

    enum StringSpecialKey {
        case draft
    }

    enum Key: CLIparserTag {
        // generic tags
        case boolValue(key: Settings.CodingKeys, name: String)
        case boolSpecial(key: BoolSpecialKey, name: String)
        case doubleArray(key: Settings.CodingKeys, name: String)
        case doubleSpecialArray(key: DoubleArraySpecialKey, name: String)
        case doubleValue(key: Settings.CodingKeys, name: String)
        case intSpecial(key: IntSpecialKey, name: String)
        case intSpecialArray(key: IntArraySpecialKey, name: String)
        case intValue(key: Settings.CodingKeys, name: String)
        case positionalValues
        case stringArray(key: Settings.CodingKeys, name: String)
        case stringSpecial(key: StringSpecialKey, name: String)
        case stringValue(key: Settings.CodingKeys, name: String)

        var longname: String {
            switch self {
            case .boolValue(_, let name): return name
            case .boolSpecial(_, let name): return name
            case .doubleArray(_, let name): return name
            case .doubleSpecialArray(_, let name): return name
            case .doubleValue(_, let name): return name
            case .intSpecial(_, let name): return name
            case .intSpecialArray(_, let name): return name
            case .intValue(_, let name): return name
            case .positionalValues: return "positional"
            case .stringArray(_, let name): return name
            case .stringSpecial(_, let name): return name
            case .stringValue(_, let name): return name
            }
        }
    }
}

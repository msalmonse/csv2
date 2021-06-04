//
//  KeyTag.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-16.
//

import Foundation
import CLIparser

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

enum OptionsKey: CLIparserTag {
    // generic tags
    case bitmapValue(key: Settings.CodingKeys, name: String)
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
        case let .bitmapValue(_, name): return name
        case let .boolValue(_, name): return name
        case let .boolSpecial(_, name): return name
        case let .doubleArray(_, name): return name
        case let .doubleSpecialArray(_, name): return name
        case let .doubleValue(_, name): return name
        case let .intSpecial(_, name): return name
        case let .intSpecialArray(_, name): return name
        case let .intValue(_, name): return name
        case .positionalValues: return "positional"
        case let .stringArray(_, name): return name
        case let .stringSpecial(_, name): return name
        case let .stringValue(_, name): return name
        }
    }
}

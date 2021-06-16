//
//  CLIparser.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-16.
//

import Foundation
import CLIparser

extension OptToGet {
    convenience init(
        _ optTag: OptionsKey,
        short: String? = nil,
        aka: [String]? = nil,
        _ minMax: ClosedRange<UInt8> = 0...0,
        options: [Options],
        usage: String? = nil,
        argTag: String? = nil
    ) {
        self.init(
            short: short,
            long: optTag.longname,
            aka: aka,
            minMax,
            options: options,
            tag: optTag,
            usage: usage,
            argTag: argTag
        )
    }

    convenience init(
        _ optTag: OptionsKey,
        short: String? = nil,
        aka: [String]? = nil,
        _ minMax: ClosedRange<UInt8> = 0...0,
        option: Options,
        usage: String? = nil,
        argTag: String? = nil
    ) {
        self.init(
            short: short,
            long: optTag.longname,
            aka: aka,
            minMax,
            options: [option] ,
            tag: optTag,
            usage: usage,
            argTag: argTag
        )
    }

    convenience init(
        _ optTag: OptionsKey,
        short: String? = nil,
        aka: [String]? = nil,
        _ minMax: ClosedRange<UInt8> = 0...0,
        usage: String? = nil,
        argTag: String? = nil
    ) {
        self.init(
            short: short,
            long: optTag.longname,
            aka: aka,
            minMax,
            options: [],
            tag: optTag,
            usage: usage,
            argTag: argTag
        )
    }
}

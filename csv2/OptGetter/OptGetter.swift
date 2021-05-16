//
//  OptGetter.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-16.
//

import Foundation
import OptGetter

extension OptToGet {
    convenience init(
        _ optTag: Options.Key
        short: String? = nil,
        _ minMax: ClosedRange<UInt8> = 0...0,
        options: [OptGetter.Options] = [],
        tag: OptGetterTag? = nil,
        usage: String? = nil,
        argTag: String? = nil
    ) {
        self.init(
            short: short,
            long: optTag.longname,
            minMax,
            options: options,
            tag: optTag,
            usage: usage,
            argTag: argTag
        )
    }
}

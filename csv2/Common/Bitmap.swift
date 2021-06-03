//
//  Bitmap.swift
//  csv2
//
//  Created by Michael Salmon on 2021-06-03.
//

import Foundation

struct BitMap: OptionSet {
    let rawValue: UInt64
    static let okRange = 1...64

    static var all = Self(rawValue: ~0)
    static var none = Self(rawValue: 0)

    func val(_ i: Int) -> BitMap { return BitMap(rawValue: 1 << (i - 1)) }

    subscript(_ index: Int) -> Bool {
        get { contains(val(index)) }
        set(newValue) { if newValue { insert(val(index)) } else { remove(val(index)) } }
    }
}

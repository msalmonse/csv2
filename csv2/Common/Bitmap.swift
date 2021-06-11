//
//  Bitmap.swift
//  csv2
//
//  Created by Michael Salmon on 2021-06-03.
//

import Foundation

struct BitMap: OptionSet {
    let rawValue: UInt64
    /// BitMap stores values in the range 0..<64 but append uses a different range
    /// usually 1..<65, offset is the difference between the two
    let offset: Int
    static let okRange = 0...Int(UInt64.bitWidth - 1)
    let okWithOffset: ClosedRange<Int>

    init(rawValue: UInt64, offset: Int = 1) {
        self.rawValue = rawValue
        self.offset = offset
        okWithOffset = offset...(UInt64.bitWidth - 1 + offset)
    }

    init(rawValue: UInt64) {
        self.init(rawValue: rawValue, offset: 1)
    }

    init(bitValue: Int) {
        if Self.okRange ~= bitValue {
            self.init(rawValue: 1 << bitValue)
        } else {
            self.init(rawValue: 0)
        }
    }

    init(lsb: Int) {
        let raw = ~(~0b0 << lsb)
        self.init(rawValue: UInt64(raw))
    }

    private static let cache: [BitMap] = Self.okRange.map { BitMap(rawValue: 1 << $0) }

    static var all = Self(rawValue: ~0)
    static var none = Self(rawValue: 0)

    var intValue: Int { Int(bitPattern: UInt(rawValue)) }

    @discardableResult
    mutating func append(_ i: Int) -> BitMap {
        if okWithOffset ~= i { insert(BitMap.val(i - offset)) }
        return self
    }

    static func val(_ i: Int) -> BitMap {
        if !Self.cache.hasIndex(i) { return BitMap.none }
        return Self.cache[i]
    }

    subscript(_ index: Int) -> Bool {
        get { contains(BitMap.val(index)) }
        set(newValue) { if newValue { insert(BitMap.val(index)) } else { remove(BitMap.val(index)) } }
    }

    /// Count the number of bits set in a BitMap
    /// - Returns: bit count

    func bitCount() -> Int {
        var n = rawValue
        var count = 0
        while n != 0 {
            count += 1
            n &= n - 1
        }
        return count
    }

    /// Convert a BitMap to an Int Array
    /// - Returns: An Int Array

    func intArray() -> [Int] {
        var result: [Int] = []
        for i in Self.okRange where self[i] { result.append(i + offset) }
        return result
    }

    /// Invert a BitMap
    /// - Parameter rhs: BitMap to invert
    /// - Returns: Inverted BitMap
    static prefix func ~ (rhs: BitMap) -> BitMap {
        return BitMap(rawValue: ~rhs.rawValue, offset: rhs.offset)
    }
}

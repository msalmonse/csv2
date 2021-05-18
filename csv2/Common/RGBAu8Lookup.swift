//
//  RGBAu8Lookup.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-24.
//

import Foundation

fileprivate func u8val(_ val: CGFloat) -> UInt8 { UInt8(min(val * 256.0, 255)) }
fileprivate func u8val(_ val: Double) -> UInt8 { UInt8(min(val * 256.0, 255)) }

extension RGBAu8 {

    /// Convert a hex substring to an Int
    /// Return true on success
    ///
    /// Parameters:
    ///     from:     base string
    ///     first:      first character from beginning to use
    ///     count:   number of characters
    ///     to:         reference to result

    fileprivate static func hexToUInt8(from: String, first: Int, count: Int, to: inout UInt8) -> Bool {
        let start = from.index(from.startIndex, offsetBy: first)
        let end = from.index(from.startIndex, offsetBy: first + count)
        let subFrom = from[start..<end]
        guard let val = Int(subFrom, radix: 16) else { return false }
        to = UInt8(val)
        return true
    }

    /// Convert a hex string to red, green & blue
    /// Expectd formats "#rgb", "#rrggbb" or #rrggbbaa
    /// Returns true on success
    ///
    /// Parameters:
    ///     hex:        hex string
    ///     r:             reference to red colour
    ///     g:            reference to green colour
    ///     b:            reference to blue colour
    ///     a:            reference to alpha

    fileprivate static func hexToRGBA(
        hex: String,
        r: inout UInt8,
        g: inout UInt8,
        b: inout UInt8,
        a: inout UInt8
    ) -> Bool {
        if !hex.hasPrefix("#") { return false }
        switch hex.count {
        case 4:     // #rgb
            if  !hexToUInt8(from: hex, first: 1, count: 1, to: &r) ||
                !hexToUInt8(from: hex, first: 2, count: 1, to: &g) ||
                !hexToUInt8(from: hex, first: 3, count: 1, to: &b) { return false }
            r *= 17
            g *= 17
            b *= 17
            a = 255
        case 5:     // #rgba
            if  !hexToUInt8(from: hex, first: 1, count: 1, to: &r) ||
                !hexToUInt8(from: hex, first: 2, count: 1, to: &g) ||
                !hexToUInt8(from: hex, first: 3, count: 1, to: &b) ||
                !hexToUInt8(from: hex, first: 4, count: 1, to: &a) { return false }
            r *= 17
            g *= 17
            b *= 17
            a *= 17
        case 7:     // #rrggbb
            if  !hexToUInt8(from: hex, first: 1, count: 2, to: &r) ||
                !hexToUInt8(from: hex, first: 3, count: 2, to: &g) ||
                !hexToUInt8(from: hex, first: 5, count: 2, to: &b) { return false }
            a = 255
        case 9:     // #rrggbbaa
            if  !hexToUInt8(from: hex, first: 1, count: 2, to: &r) ||
                !hexToUInt8(from: hex, first: 3, count: 2, to: &g) ||
                !hexToUInt8(from: hex, first: 5, count: 2, to: &b) ||
                !hexToUInt8(from: hex, first: 7, count: 2, to: &a) { return false }
        default:
            return false
        }

        return true
    }

    fileprivate static func cssRGBAParse(
            _ css: String,
            r: inout UInt8,
            g: inout UInt8,
            b: inout UInt8,
            a: inout UInt8
    ) -> Bool {
        /// Convert a String to an Int return true on success
        /// - Parameters:
        ///   - from: string to convert
        ///   - to: value recipient
        /// - Returns: true if successful

        func cvt(from: String, to: inout UInt8) -> Bool {
            guard let val = UInt8(from.trimmingCharacters(in: .whitespaces)) else { return false }
            to = val
            return true
        }

        let css = css.lowercased()
        if !css.hasSuffix(")") { return false }
        if css.lowercased().hasPrefix("rgb(") {
            let start = css.index(css.startIndex, offsetBy: 4)
            let end = css.index(before: css.endIndex)
            let numbers = (css[start..<end]).components(separatedBy: ",")
            if numbers.count != 3 { return false }
            a = 255
            if  !cvt(from: numbers[0], to: &r) ||
                !cvt(from: numbers[1], to: &g) ||
                !cvt(from: numbers[2], to: &b) { return false }
        } else if css.lowercased().hasPrefix("rgba(") {
            let start = css.index(css.startIndex, offsetBy: 5)
            let end = css.index(before: css.endIndex)
            let numbers = (css[start..<end]).components(separatedBy: ",")
            if numbers.count != 4 { return false }
            if  !cvt(from: numbers[0], to: &r) ||
                !cvt(from: numbers[1], to: &g) ||
                !cvt(from: numbers[2], to: &b) { return false }
            // a can be an Int or a Double
            if !cvt(from: numbers[3], to: &a) {
                // try as a double
                guard let val = Double(numbers[3].trimmingCharacters(in: .whitespaces)) else { return false}
                if val > 1.0 { return false }
                a = val == 1.0 ? 255 : UInt8(floor(256.0 * val))
            }
        } else {
            return false
        }

        return true
    }

    /// Lookup a known colour name or hex code
    /// - Parameter name: colour name of hex code
    /// - Returns: A matching RGBA or nil

    static func lookup(_ name: String?) -> RGBAu8? {
        guard let name = name?.lowercased() else { return nil }
        if name.isEmpty { return nil }
        if let cached = RGBAu8.cache[name] { return cached }
        if let rgba = ColourTranslate.lookup(name) { return rgba }

        var r: UInt8 = 0
        var g: UInt8 = 0
        var b: UInt8 = 0
        var a: UInt8 = 0

        if RGBAu8.hexToRGBA(hex: name, r: &r, g: &g, b: &b, a: &a) {
            let rgba = RGBAu8(r: r, g: g, b: b, a: a)
            RGBAu8.cache[name] = rgba
            return rgba
        }

        if RGBAu8.cssRGBAParse(name, r: &r, g: &g, b: &b, a: &a) {
            let rgba = RGBAu8(r: r, g: g, b: b, a: a)
            RGBAu8.cache[name] = rgba
            return rgba
        }

        if name.lowercased().hasPrefix("clear-") {
            if let rgba = lookup(String(name.dropFirst(6))) {
                return rgba.dividingBy(alpha: 2)
            }
        } else if name.lowercased().hasPrefix("clear") {
            if let rgba = lookup(String(name.dropFirst(5))) {
                return rgba.dividingBy(alpha: 2)
            }
        }

        return nil
    }

    /// As for lookup but return a default if not found
    /// - Parameters:
    ///   - name: colour name or hexcode
    ///   - notFound: default if not found
    /// - Returns: A matching RGBA or default

    static func lookup(_ name: String?, or notFound: RGBAu8 = .clear) -> RGBAu8 {
        return Self.lookup(name) ?? notFound
    }
}

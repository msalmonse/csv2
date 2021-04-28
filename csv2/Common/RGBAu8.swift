//
//  RGBAu8.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-24.
//

import Foundation

extension UInt8 {
    var cgfloat: CGFloat { CGFloat(self)/255.0 }
}

fileprivate func u8val(_ val: CGFloat) -> UInt8 { UInt8(min(val * 256.0, 256)) }
fileprivate func u8val(_ val: Double) -> UInt8 { UInt8(min(val * 256.0, 256)) }

/// Colours with red, green, blue and, alpha UInt8 properties

struct RGBAu8: CustomStringConvertible, Equatable {
    var description: String { cssRGBA }

    let r: UInt8
    let g: UInt8
    let b: UInt8
    let a: UInt8

    /// Standard init
    /// - Parameters:
    ///   - r: red
    ///   - g: gree
    ///   - b: blue
    ///   - a: alpha

    init(r: UInt8, g: UInt8, b: UInt8, a: UInt8) {
        self.r = r
        self.g = g
        self.b = b
        self.a = a
    }

    /// Init without alpha
    /// - Parameters:
    ///   - r: red
    ///   - g: green
    ///   - b: blue

    init(r: UInt8, g: UInt8, b: UInt8) {
        self.init(r: r, g: g, b: b, a: 255)
    }

    /// Packed colours init without alpha
    /// - Parameter u24: packed colours

    init(u24: Int) {
        let r = UInt8((u24 >> 16) & 0xff)
        let g = UInt8((u24 >> 8) & 0xff)
        let b = UInt8(u24 & 0xff)
        self.init(r: r, g: g, b: b, a: 255)
    }

    /// Packed colours init with alpha
    /// - Parameter u32: packed colours and alpha

    init(u32: Int) {
        let r = UInt8((u32 >> 24) & 0xff)
        let g = UInt8((u32 >> 16) & 0xff)
        let b = UInt8((u32 >> 8) & 0xff)
        let a = UInt8(u32 & 0xff)
        self.init(r: r, g: g, b: b, a: a)
    }

    /// Failable init using a colour name
    /// - Parameter name: colour name

    init?(_ name: String?) {
        if let rgba = RGBAu8.lookup(name) {
            self = rgba
        } else {
            return nil
        }
    }

    /// Init using a colour name or fallback
    /// - Parameters:
    ///   - name: colour name
    ///   - notFound: fallback colour

    init(_ name: String?, or notFound: RGBAu8) {
        if let rgba = RGBAu8.lookup(name) {
            self = rgba
        } else {
            self.init(r: notFound.r, g: notFound.g, b: notFound.b, a: notFound.a)
        }
    }

    static var cache: [ String: RGBAu8 ] = [:]

    /// as CGColor
    var cgColor: CGColor {
        CGColor(red: r.cgfloat, green: g.cgfloat, blue: b.cgfloat, alpha: a.cgfloat)
    }

    /// Formatted RGBA
    var cssRGBA: String {
        let text = String(format: "rgba(%d,%d,%d,%.3f)", r, g, b, a.cgfloat)
        RGBAu8.cache[text] = self
        return text
    }

    var hashRGB: String {
        let text = String(format: "#%02x%02x%02x", r, g, b, a)
        RGBAu8.cache[text] = self
        return text
    }

    var hashRGBA: String {
        let text = String(format: "#%02x%02x%02x%02x", r, g, b, a)
        RGBAu8.cache[text] = self
        return text
    }

    /// The luminosity of the colour
    var luminance: Int { 2126 * Int(r) + 7152 * Int(g) + 722 * Int(b) }

    // components packed together
    var u32: UInt32 { UInt32(UInt32(r) << 24 | UInt32(g) << 16 | UInt32(b) << 8 | UInt32(a)) }

    // Standard colours
    static var clear: RGBAu8 { RGBAu8(r: 0, g: 0, b: 0, a: 0) }
    static var black: RGBAu8 { RGBAu8(r: 0, g: 0, b: 0, a: 255) }
    static var grey:  RGBAu8 { RGBAu8(r: 128, g: 128, b: 128, a: 255) }
    static var white: RGBAu8 { RGBAu8(r: 255, g: 255, b: 255, a: 255) }

    // Special colours
    static var darkBG: RGBAu8 { RGBAu8(r: 35, g: 35, b: 35, a: 170) }
    static var midBG: RGBAu8 { RGBAu8(r: 120, g: 120, b: 120, a: 170) }
    static var lightBG: RGBAu8 { RGBAu8(r: 220, g: 220, b: 220, a: 170) }

    /// Create an RGBA with a new alpha
    /// - Parameter alpha: new alpha
    /// - Returns: New RGBA with new alpha

    func with(alpha: UInt8) -> RGBAu8 {
        return RGBAu8(r: self.r, g: self.g, b: self.b, a: alpha)
    }

    /// Clamp the alpha value
    /// - Parameter opacity: maximum alpha
    /// - Returns: new rgba with the alpha clamped

    func clamped(opacity: CGFloat) -> RGBAu8 {
        return RGBAu8(r: r, g: g, b: b, a: UInt8(u8val(min(a.cgfloat, opacity))))
    }

    /// Modify the alpha by dividing
    /// - Parameter divisor: alpha divisor
    /// - Returns: New RGBA with modified alpha

    func dividingBy(alpha divisor: UInt8) -> RGBAu8 {
        return RGBAu8(r: r, g: g, b: b, a: a/divisor)
    }

    /// Modiify the alpha by multiplyimg
    /// - Parameter alpha: multiplier
    /// - Returns: New RGBA with modified alpha

    func multiplyingBy(alpha: CGFloat) -> RGBAu8 {
        return RGBAu8(r: r, g: g, b: b, a: UInt8(u8val(a.cgfloat * alpha)))
    }
}

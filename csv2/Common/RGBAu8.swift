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

struct RGBAu8: Equatable {
    let r: UInt8
    let g: UInt8
    let b: UInt8
    let a: UInt8

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

    /// The average of red, gren, blue plus the max and min values
    var rgbValue: Int { (Int(r) + Int(g) + Int(b) + Int(max(r, g, b)) + Int(min(r, g, b)))/5 }

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

    /// Modiify the alpha by multiplyimg
    /// - Parameter alpha: multiplier
    /// - Returns: New RGBA with modified alpha

    func modify(alpha: CGFloat) -> RGBAu8 {
        return RGBAu8(r: r, g: g, b: b, a: UInt8(u8val(a.cgfloat * alpha)))
    }
}

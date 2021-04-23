//
//  ColourTranslate.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-12.
//

import Foundation

extension UInt8 {
    var cgfloat: CGFloat { CGFloat(self)/255.0 }
}

fileprivate func u8val(_ val: CGFloat) -> UInt8 { UInt8(min(val * 256.0, 256)) }
fileprivate func u8val(_ val: Double) -> UInt8 { UInt8(min(val * 256.0, 256)) }

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

    /// The average of red, gren and, blue
    var rgbMean: Int { (Int(r) + Int(g) + Int(b) + Int(max(r, g, b)))/4 }

    // components packed together
    var u32: UInt32 { UInt32(UInt32(r) << 24 | UInt32(g) << 16 | UInt32(b) << 8 | UInt32(a)) }

    // Standard colours
    static var clear: RGBAu8 { RGBAu8(r: 0, g: 0, b: 0, a: 0) }
    static var black: RGBAu8 { RGBAu8(r: 0, g: 0, b: 0, a: 255) }
    static var grey:  RGBAu8 { RGBAu8(r: 128, g: 128, b: 128, a: 255) }
    static var white: RGBAu8 { RGBAu8(r: 255, g: 255, b: 255, a: 255) }

    /// Create an RGBA with a new alpha
    /// - Parameter alpha: new alpha
    /// - Returns: New RGBA with new alpha

    func with(alpha: UInt8) -> RGBAu8 {
        return RGBAu8(r: self.r, g: self.g, b: self.b, a: alpha)
    }

    /// Clamp the alpha value
    /// - Parameter alpha: maximum alpha
    /// - Returns: new rgba with the alpha clamped

    func maxAlpha(_ alpha: CGFloat) -> RGBAu8 {
        return RGBAu8(r: r, g: g, b: b, a: UInt8(min(min(a.cgfloat, alpha) * 256.0, 256)))
    }

    /// Modiify the alpha by multiplyimg
    /// - Parameter alpha: multiplier
    /// - Returns: New RGBA with modified alpha

    func modify(alpha: CGFloat) -> RGBAu8 {
        return RGBAu8(r: r, g: g, b: b, a: UInt8(min(a.cgfloat * alpha * 256.0, 256)))
    }
}

struct ColourTranslate {
    fileprivate static let name2rgba = [
        "aliceblue":            RGBAu8(r: 240, g: 248, b: 255, a: 255),
        "antiquewhite":         RGBAu8(r: 250, g: 235, b: 215, a: 255),
        "aqua":                 RGBAu8(r: 0, g: 240, b: 255, a: 255),
        "aquamarine":           RGBAu8(r: 127, g: 255, b: 212, a: 255),
        "azure":                RGBAu8(r: 240, g: 255, b: 255, a: 255),
        "beige":                RGBAu8(r: 245, g: 245, b: 220, a: 255),
        "bisque":               RGBAu8(r: 255, g: 228, b: 196, a: 255),
        "black":                .black,
        "blanchedalmond":       RGBAu8(r: 255, g: 235, b: 205, a: 255),
        "blue":                 RGBAu8(r: 0, g: 0, b: 255, a: 255),
        "blueviolet":           RGBAu8(r: 138, g: 43, b: 226, a: 255),
        "brown":                RGBAu8(r: 165, g: 42, b: 42, a: 255),
        "burlywood":            RGBAu8(r: 222, g: 184, b: 135, a: 255),
        "cadetblue":            RGBAu8(r: 95, g: 158, b: 160, a: 255),
        "chartreuse":           RGBAu8(r: 127, g: 255, b: 0, a: 255),
        "chocolate":            RGBAu8(r: 210, g: 105, b: 30, a: 255),
        "clear":                .clear,
        "coral":                RGBAu8(r: 255, g: 127, b: 80, a: 255),
        "cornflowerblue":       RGBAu8(r: 100, g: 149, b: 237, a: 255),
        "cornsilk":             RGBAu8(r: 255, g: 248, b: 220, a: 255),
        "crimson":              RGBAu8(r: 220, g: 20, b: 60, a: 255),
        "cyan":                 RGBAu8(r: 0, g: 255, b: 255, a: 255),
        "darkblue":             RGBAu8(r: 0, g: 0, b: 139, a: 255),
        "darkcyan":             RGBAu8(r: 0, g: 139, b: 139, a: 255),
        "darkgoldenrod":        RGBAu8(r: 184, g: 134, b: 11, a: 255),
        "darkgray":             RGBAu8(r: 169, g: 169, b: 169, a: 255),
        "darkgrey":             RGBAu8(r: 169, g: 169, b: 169, a: 255),
        "darkgreen":            RGBAu8(r: 0, g: 100, b: 0, a: 255),
        "darkkhaki":            RGBAu8(r: 189, g: 183, b: 107, a: 255),
        "darkmagenta":          RGBAu8(r: 139, g: 0, b: 139, a: 255),
        "darkolivegreen":       RGBAu8(r: 85, g: 107, b: 47, a: 255),
        "darkorange":           RGBAu8(r: 255, g: 140, b: 0, a: 255),
        "darkorchid":           RGBAu8(r: 153, g: 50, b: 204, a: 255),
        "darkred":              RGBAu8(r: 139, g: 0, b: 0, a: 255),
        "darksalmon":           RGBAu8(r: 233, g: 150, b: 122, a: 255),
        "darkseagreen":         RGBAu8(r: 143, g: 188, b: 143, a: 255),
        "darkslateblue":        RGBAu8(r: 72, g: 61, b: 139, a: 255),
        "darkslategray":        RGBAu8(r: 47, g: 79, b: 79, a: 255),
        "darkslategrey":        RGBAu8(r: 47, g: 79, b: 79, a: 255),
        "darkturquoise":        RGBAu8(r: 0, g: 206, b: 209, a: 255),
        "darkviolet":           RGBAu8(r: 148, g: 0, b: 211, a: 255),
        "deeppink":             RGBAu8(r: 255, g: 20, b: 147, a: 255),
        "deepskyblue":          RGBAu8(r: 0, g: 191, b: 255, a: 255),
        "dimgray":              RGBAu8(r: 105, g: 105, b: 105, a: 255),
        "dodgerblue":           RGBAu8(r: 30, g: 144, b: 255, a: 255),
        "firebrick":            RGBAu8(r: 178, g: 34, b: 34, a: 255),
        "floralwhite":          RGBAu8(r: 255, g: 250, b: 240, a: 255),
        "forestgreen":          RGBAu8(r: 34, g: 139, b: 34, a: 255),
        "fuschia":              RGBAu8(r: 255, g: 0, b: 255, a: 255),
        "gainsboro":            RGBAu8(r: 220, g: 220, b: 220, a: 255),
        "ghostwhite":           RGBAu8(r: 248, g: 248, b: 255, a: 255),
        "gold":                 RGBAu8(r: 255, g: 215, b: 0, a: 255),
        "goldenrod":            RGBAu8(r: 218, g: 165, b: 32, a: 255),
        "gray":                 .grey,
        "green":                RGBAu8(r: 0, g: 255, b: 0, a: 255),
        "greenyellow":          RGBAu8(r: 173, g: 255, b: 47, a: 255),
        "grey":                 .grey,
        "honeydew":             RGBAu8(r: 240, g: 255, b: 240, a: 255),
        "hotpink":              RGBAu8(r: 255, g: 105, b: 180, a: 255),
        "indianred":            RGBAu8(r: 205, g: 92, b: 92, a: 255),
        "indigo":               RGBAu8(r: 75, g: 0, b: 130, a: 255),
        "ivory":                RGBAu8(r: 255, g: 255, b: 240, a: 255),
        "khaki":                RGBAu8(r: 240, g: 230, b: 140, a: 255),
        "lavender":             RGBAu8(r: 230, g: 230, b: 250, a: 255),
        "lavenderblush":        RGBAu8(r: 255, g: 240, b: 245, a: 255),
        "lawngreen":            RGBAu8(r: 124, g: 252, b: 0, a: 255),
        "lemonchiffon":         RGBAu8(r: 255, g: 250, b: 205, a: 255),
        "lightblue":            RGBAu8(r: 173, g: 216, b: 230, a: 255),
        "lightcoral":           RGBAu8(r: 240, g: 128, b: 128, a: 255),
        "lightcyan":            RGBAu8(r: 224, g: 255, b: 255, a: 255),
        "lightgoldenrodyellow": RGBAu8(r: 250, g: 250, b: 210, a: 255),
        "lightgray":            RGBAu8(r: 211, g: 211, b: 211, a: 255),
        "lightgreen":           RGBAu8(r: 144, g: 238, b: 144, a: 255),
        "lightgrey":            RGBAu8(r: 211, g: 211, b: 211, a: 255),
        "lightpink":            RGBAu8(r: 255, g: 182, b: 193, a: 255),
        "lightsalmon":          RGBAu8(r: 255, g: 160, b: 122, a: 255),
        "lightseagreen":        RGBAu8(r: 32, g: 178, b: 170, a: 255),
        "lightskyblue":         RGBAu8(r: 135, g: 206, b: 250, a: 255),
        "lightslategray":       RGBAu8(r: 119, g: 136, b: 153, a: 255),
        "lightslategrey":       RGBAu8(r: 119, g: 136, b: 153, a: 255),
        "lightsteelblue":       RGBAu8(r: 176, g: 196, b: 222, a: 255),
        "lightyellow":          RGBAu8(r: 255, g: 255, b: 224, a: 255),
        "limegreen":            RGBAu8(r: 50, g: 205, b: 50, a: 255),
        "linen":                RGBAu8(r: 250, g: 240, b: 230, a: 255),
        "magenta":              RGBAu8(r: 255, g: 0, b: 255, a: 255),
        "maroon":               RGBAu8(r: 128, g: 0, b: 0, a: 255),
        "mediumaquamarine":     RGBAu8(r: 102, g: 205, b: 170, a: 255),
        "mediumblue":           RGBAu8(r: 0, g: 0, b: 205, a: 255),
        "mediumorchid":         RGBAu8(r: 186, g: 85, b: 211, a: 255),
        "mediumpurple":         RGBAu8(r: 147, g: 112, b: 219, a: 255),
        "mediumseagreen":       RGBAu8(r: 60, g: 179, b: 113, a: 255),
        "mediumslateblue":      RGBAu8(r: 123, g: 104, b: 238, a: 255),
        "mediumspringgreen":    RGBAu8(r: 0, g: 250, b: 154, a: 255),
        "mediumturquoise":      RGBAu8(r: 72, g: 209, b: 204, a: 255),
        "mediumvioletred":      RGBAu8(r: 199, g: 21, b: 133, a: 255),
        "midnightblue":         RGBAu8(r: 25, g: 25, b: 112, a: 255),
        "mintcream":            RGBAu8(r: 245, g: 255, b: 250, a: 255),
        "mistyrose":            RGBAu8(r: 255, g: 228, b: 225, a: 255),
        "moccasin":             RGBAu8(r: 255, g: 228, b: 181, a: 255),
        "navajowhite":          RGBAu8(r: 255, g: 222, b: 173, a: 255),
        "navy":                 RGBAu8(r: 0, g: 0, b: 128, a: 255),
        "oldlace":              RGBAu8(r: 253, g: 245, b: 230, a: 255),
        "olive":                RGBAu8(r: 128, g: 128, b: 0, a: 255),
        "olivedrab":            RGBAu8(r: 107, g: 142, b: 35, a: 255),
        "orange":               RGBAu8(r: 255, g: 165, b: 0, a: 255),
        "orangered":            RGBAu8(r: 255, g: 69, b: 0, a: 255),
        "orchid":               RGBAu8(r: 218, g: 112, b: 214, a: 255),
        "palegoldenrod":        RGBAu8(r: 238, g: 232, b: 170, a: 255),
        "palegreen":            RGBAu8(r: 152, g: 251, b: 152, a: 255),
        "paleturquoise":        RGBAu8(r: 174, g: 238, b: 238, a: 255),
        "palevioletred":        RGBAu8(r: 219, g: 112, b: 147, a: 255),
        "papayawhip":           RGBAu8(r: 255, g: 239, b: 213, a: 255),
        "peru":                 RGBAu8(r: 205, g: 133, b: 63, a: 255),
        "pink":                 RGBAu8(r: 255, g: 192, b: 203, a: 255),
        "plum":                 RGBAu8(r: 221, g: 160, b: 221, a: 255),
        "powderblue":           RGBAu8(r: 176, g: 224, b: 230, a: 255),
        "purple":               RGBAu8(r: 128, g: 0, b: 128, a: 255),
        "rebeccapurple":        RGBAu8(r: 102, g: 51, b: 153, a: 255),
        "red":                  RGBAu8(r: 255, g: 0, b: 0, a: 255),
        "rosybrown":            RGBAu8(r: 188, g: 143, b: 143, a: 255),
        "royalblue":            RGBAu8(r: 65, g: 105, b: 225, a: 255),
        "saddlebrown":          RGBAu8(r: 139, g: 69, b: 19, a: 255),
        "salmon":               RGBAu8(r: 250, g: 128, b: 114, a: 255),
        "sandybrown":           RGBAu8(r: 244, g: 164, b: 96, a: 255),
        "seagreen":             RGBAu8(r: 46, g: 139, b: 87, a: 255),
        "seashell":             RGBAu8(r: 255, g: 245, b: 238, a: 255),
        "sienna":               RGBAu8(r: 160, g: 82, b: 45, a: 255),
        "silver":               RGBAu8(r: 192, g: 192, b: 192, a: 255),
        "skyblue":              RGBAu8(r: 135, g: 206, b: 235, a: 255),
        "slateblue":            RGBAu8(r: 106, g: 90, b: 205, a: 255),
        "slategray":            RGBAu8(r: 112, g: 128, b: 144, a: 255),
        "slategrey":            RGBAu8(r: 112, g: 128, b: 144, a: 255),
        "snow":                 RGBAu8(r: 255, g: 250, b: 250, a: 255),
        "springgreen":          RGBAu8(r: 0, g: 255, b: 127, a: 255),
        "steelblue":            RGBAu8(r: 70, g: 130, b: 180, a: 255),
        "tan":                  RGBAu8(r: 210, g: 180, b: 140, a: 255),
        "teal":                 RGBAu8(r: 0, g: 128, b: 128, a: 255),
        "thistle":              RGBAu8(r: 223, g: 191, b: 216, a: 255),
        "tomato":               RGBAu8(r: 255, g: 99, b: 71, a: 255),
        "transparent":          .clear,
        "turquoise":            RGBAu8(r: 64, g: 224, b: 208, a: 255),
        "violet":               RGBAu8(r: 238, g: 130, b: 238, a: 255),
        "wheat":                RGBAu8(r: 245, g: 222, b: 179, a: 255),
        "white":                .white,
        "whitesmoke":           RGBAu8(r: 245, g: 245, b: 245, a: 255),
        "yellow":               RGBAu8(r: 255, g: 255, b: 0, a: 255),
        "yellowgreen":          RGBAu8(r: 154, g: 205, b: 50, a: 255),
    ]

    static var all: [String] { name2rgba.keys.map { $0 }.sorted() }

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
        if !css.lowercased().hasPrefix("rgb") { return false }
        let pattern = #"^rgba?\(\s*(?<r>\d+),\s*(?<g>\d+),\s*(?<b>\d+)(?:,\s*(?<a>[01]\.\d+))?\)$"#
        let re = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let cssRange = NSRange(css.startIndex..<css.endIndex, in: css)
        a = 255
        if let re = re, let match = re.matches(in: css, options: [], range: cssRange).first {
            if let aRange = Range(match.range(withName: "a"), in: css), let aVal = Double(css[aRange]) {
                if aVal > 1.0 { return false }
                a = u8val(aVal)
            }

            if let rRange = Range(match.range(withName: "r"), in: css), let rVal = Int(css[rRange]) {
                if rVal > 255 { return false }
                r = UInt8(rVal)
            } else { return false }

            if let gRange = Range(match.range(withName: "g"), in: css), let gVal = Int(css[gRange]) {
                if gVal > 255 { return false }
                g = UInt8(gVal)
            } else { return false }

            if let bRange = Range(match.range(withName: "b"), in: css), let bVal = Int(css[bRange]) {
                if bVal > 255 { return false }
                b = UInt8(bVal)
            } else { return false }

            return true
        }
        return false
    }

    /// Lookup a known colour name or hex code
    /// - Parameter name: colour name of hex code
    /// - Returns: A matching RGBA or nil

    static func lookup(_ name: String?) -> RGBAu8? {
        guard let name = name else { return nil }
        if name.isEmpty { return nil }
        if let cached = RGBAu8.cache[name] { return cached }
        if let rgba = name2rgba[name] { return rgba }

        var r: UInt8 = 0
        var g: UInt8 = 0
        var b: UInt8 = 0
        var a: UInt8 = 0

        if hexToRGBA(hex: name, r: &r, g: &g, b: &b, a: &a) {
            let rgba = RGBAu8(r: r, g: g, b: b, a: a)
            RGBAu8.cache[name] = rgba
            return rgba
        }

        if cssRGBAParse(name, r: &r, g: &g, b: &b, a: &a) {
            let rgba = RGBAu8(r: r, g: g, b: b, a: a)
            RGBAu8.cache[name] = rgba
            return rgba
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

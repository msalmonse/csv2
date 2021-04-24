//
//  ColourTranslate.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-12.
//

import Foundation

fileprivate func u8val(_ val: CGFloat) -> UInt8 { UInt8(min(val * 256.0, 255)) }
fileprivate func u8val(_ val: Double) -> UInt8 { UInt8(min(val * 256.0, 255)) }

struct ColourTranslate {
    fileprivate static let name2rgba = [
        "aliceblue":            RGBAu8(r: 240, g: 248, b: 255),
        "antiquewhite":         RGBAu8(r: 250, g: 235, b: 215),
        "aqua":                 RGBAu8(r: 0, g: 240, b: 255),
        "aquamarine":           RGBAu8(r: 127, g: 255, b: 212),
        "azure":                RGBAu8(r: 240, g: 255, b: 255),
        "beige":                RGBAu8(r: 245, g: 245, b: 220),
        "bisque":               RGBAu8(r: 255, g: 228, b: 196),
        "black":                .black,
        "blanchedalmond":       RGBAu8(r: 255, g: 235, b: 205),
        "blue":                 RGBAu8(r: 0, g: 0, b: 255),
        "blueviolet":           RGBAu8(r: 138, g: 43, b: 226),
        "brown":                RGBAu8(r: 165, g: 42, b: 42),
        "buff":                 RGBAu8(r: 240, g: 220, b: 130),
        "burlywood":            RGBAu8(r: 222, g: 184, b: 135),
        "cadetblue":            RGBAu8(r: 95, g: 158, b: 160),
        "chartreuse":           RGBAu8(r: 127, g: 255, b: 0),
        "chocolate":            RGBAu8(r: 210, g: 105, b: 30),
        "clear":                .clear,
        "coral":                RGBAu8(r: 255, g: 127, b: 80),
        "cornflowerblue":       RGBAu8(r: 100, g: 149, b: 237),
        "cornsilk":             RGBAu8(r: 255, g: 248, b: 220),
        "crimson":              RGBAu8(r: 220, g: 20, b: 60),
        "cyan":                 RGBAu8(r: 0, g: 255, b: 255),
        "darkblue":             RGBAu8(r: 0, g: 0, b: 139),
        "darkbuff":             RGBAu8(r: 151, g: 102, b: 56),
        "darkcyan":             RGBAu8(r: 0, g: 139, b: 139),
        "darkgoldenrod":        RGBAu8(r: 184, g: 134, b: 11),
        "darkgray":             RGBAu8(r: 169, g: 169, b: 169),
        "darkgrey":             RGBAu8(r: 169, g: 169, b: 169),
        "darkgreen":            RGBAu8(r: 0, g: 100, b: 0),
        "darkkhaki":            RGBAu8(r: 189, g: 183, b: 107),
        "darkmagenta":          RGBAu8(r: 139, g: 0, b: 139),
        "darkmustard":          RGBAu8(r: 0x7c, g: 0x7c, b: 0x40),
        "darkolivegreen":       RGBAu8(r: 85, g: 107, b: 47),
        "darkorange":           RGBAu8(r: 255, g: 140, b: 0),
        "darkorchid":           RGBAu8(r: 153, g: 50, b: 204),
        "darkred":              RGBAu8(r: 139, g: 0, b: 0),
        "darksalmon":           RGBAu8(r: 233, g: 150, b: 122),
        "darkseagreen":         RGBAu8(r: 143, g: 188, b: 143),
        "darksilver":           RGBAu8(r: 175, g: 175, b: 175),
        "darkslateblue":        RGBAu8(r: 72, g: 61, b: 139),
        "darkslategray":        RGBAu8(r: 47, g: 79, b: 79),
        "darkslategrey":        RGBAu8(r: 47, g: 79, b: 79),
        "darkturquoise":        RGBAu8(r: 0, g: 206, b: 209),
        "darkviolet":           RGBAu8(r: 148, g: 0, b: 211),
        "deeppink":             RGBAu8(r: 255, g: 20, b: 147),
        "deepskyblue":          RGBAu8(r: 0, g: 191, b: 255),
        "dimgray":              RGBAu8(r: 105, g: 105, b: 105),
        "dodgerblue":           RGBAu8(r: 30, g: 144, b: 255),
        "firebrick":            RGBAu8(r: 178, g: 34, b: 34),
        "floralwhite":          RGBAu8(r: 255, g: 250, b: 240),
        "forestgreen":          RGBAu8(r: 34, g: 139, b: 34),
        "fuschia":              RGBAu8(r: 255, g: 0, b: 255),
        "gainsboro":            RGBAu8(r: 220, g: 220, b: 220),
        "ghostwhite":           RGBAu8(r: 248, g: 248, b: 255),
        "gold":                 RGBAu8(r: 255, g: 215, b: 0),
        "goldenrod":            RGBAu8(r: 218, g: 165, b: 32),
        "gray":                 .grey,
        "green":                RGBAu8(r: 0, g: 128, b: 0),
        "greenyellow":          RGBAu8(r: 173, g: 255, b: 47),
        "grey":                 .grey,
        "honeydew":             RGBAu8(r: 240, g: 255, b: 240),
        "hotpink":              RGBAu8(r: 255, g: 105, b: 180),
        "indianred":            RGBAu8(r: 205, g: 92, b: 92),
        "indigo":               RGBAu8(r: 75, g: 0, b: 130),
        "ivory":                RGBAu8(r: 255, g: 255, b: 240),
        "khaki":                RGBAu8(r: 240, g: 230, b: 140),
        "lavender":             RGBAu8(r: 230, g: 230, b: 250),
        "lavenderblush":        RGBAu8(r: 255, g: 240, b: 245),
        "lawngreen":            RGBAu8(r: 124, g: 252, b: 0),
        "lemonchiffon":         RGBAu8(r: 255, g: 250, b: 205),
        "lightblack":           .grey,
        "lightblue":            RGBAu8(r: 173, g: 216, b: 230),
        "lightbuff":            RGBAu8(r: 0xec, g: 0xd9, b: 0xb0),
        "lightcoral":           RGBAu8(r: 240, g: 128, b: 128),
        "lightcyan":            RGBAu8(r: 224, g: 255, b: 255),
        "lightgoldenrodyellow": RGBAu8(r: 250, g: 250, b: 210),
        "lightgray":            RGBAu8(r: 211, g: 211, b: 211),
        "lightgreen":           RGBAu8(r: 144, g: 238, b: 144),
        "lightgrey":            RGBAu8(r: 211, g: 211, b: 211),
        "lightmustard":         RGBAu8(r: 0xee, g: 0xdd, b: 0x62),
        "lightpink":            RGBAu8(r: 255, g: 182, b: 193),
        "lightsalmon":          RGBAu8(r: 255, g: 160, b: 122),
        "lightseagreen":        RGBAu8(r: 32, g: 178, b: 170),
        "lightsilver":          RGBAu8(r: 225, g: 225, b: 225),
        "lightskyblue":         RGBAu8(r: 135, g: 206, b: 250),
        "lightslategray":       RGBAu8(r: 119, g: 136, b: 153),
        "lightslategrey":       RGBAu8(r: 119, g: 136, b: 153),
        "lightsteelblue":       RGBAu8(r: 176, g: 196, b: 222),
        "lightyellow":          RGBAu8(r: 255, g: 255, b: 224),
        "limegreen":            RGBAu8(r: 50, g: 205, b: 50),
        "linen":                RGBAu8(r: 250, g: 240, b: 230),
        "magenta":              RGBAu8(r: 255, g: 0, b: 255),
        "maroon":               RGBAu8(r: 128, g: 0, b: 0),
        "mediumaquamarine":     RGBAu8(r: 102, g: 205, b: 170),
        "mediumblue":           RGBAu8(r: 0, g: 0, b: 205),
        "mediumorchid":         RGBAu8(r: 186, g: 85, b: 211),
        "mediumpurple":         RGBAu8(r: 147, g: 112, b: 219),
        "mediumseagreen":       RGBAu8(r: 60, g: 179, b: 113),
        "mediumslateblue":      RGBAu8(r: 123, g: 104, b: 238),
        "mediumspringgreen":    RGBAu8(r: 0, g: 250, b: 154),
        "mediumturquoise":      RGBAu8(r: 72, g: 209, b: 204),
        "mediumvioletred":      RGBAu8(r: 199, g: 21, b: 133),
        "midnightblue":         RGBAu8(r: 25, g: 25, b: 112),
        "mintcream":            RGBAu8(r: 245, g: 255, b: 250),
        "mistyrose":            RGBAu8(r: 255, g: 228, b: 225),
        "moccasin":             RGBAu8(r: 255, g: 228, b: 181),
        "mustard":              RGBAu8(r: 0xff, g: 0xb5, b: 0x58),
        "navajowhite":          RGBAu8(r: 255, g: 222, b: 173),
        "navy":                 RGBAu8(r: 0, g: 0, b: 128),
        "oldlace":              RGBAu8(r: 253, g: 245, b: 230),
        "olive":                RGBAu8(r: 128, g: 128, b: 0),
        "olivedrab":            RGBAu8(r: 107, g: 142, b: 35),
        "orange":               RGBAu8(r: 255, g: 165, b: 0),
        "orangered":            RGBAu8(r: 255, g: 69, b: 0),
        "orchid":               RGBAu8(r: 218, g: 112, b: 214),
        "palegoldenrod":        RGBAu8(r: 238, g: 232, b: 170),
        "palegreen":            RGBAu8(r: 152, g: 251, b: 152),
        "paleturquoise":        RGBAu8(r: 174, g: 238, b: 238),
        "palevioletred":        RGBAu8(r: 219, g: 112, b: 147),
        "papayawhip":           RGBAu8(r: 255, g: 239, b: 213),
        "peru":                 RGBAu8(r: 205, g: 133, b: 63),
        "pink":                 RGBAu8(r: 255, g: 192, b: 203),
        "plum":                 RGBAu8(r: 221, g: 160, b: 221),
        "powderblue":           RGBAu8(r: 176, g: 224, b: 230),
        "purple":               RGBAu8(r: 128, g: 0, b: 128),
        "rebeccapurple":        RGBAu8(r: 102, g: 51, b: 153),
        "red":                  RGBAu8(r: 255, g: 0, b: 0),
        "rosybrown":            RGBAu8(r: 188, g: 143, b: 143),
        "royalblue":            RGBAu8(r: 65, g: 105, b: 225),
        "saddlebrown":          RGBAu8(r: 139, g: 69, b: 19),
        "salmon":               RGBAu8(r: 250, g: 128, b: 114),
        "sandybrown":           RGBAu8(r: 244, g: 164, b: 96),
        "seagreen":             RGBAu8(r: 46, g: 139, b: 87),
        "seashell":             RGBAu8(r: 255, g: 245, b: 238),
        "sienna":               RGBAu8(r: 160, g: 82, b: 45),
        "silver":               RGBAu8(r: 192, g: 192, b: 192),
        "skyblue":              RGBAu8(r: 135, g: 206, b: 235),
        "slateblue":            RGBAu8(r: 106, g: 90, b: 205),
        "slategray":            RGBAu8(r: 112, g: 128, b: 144),
        "slategrey":            RGBAu8(r: 112, g: 128, b: 144),
        "snow":                 RGBAu8(r: 255, g: 250, b: 250),
        "springgreen":          RGBAu8(r: 0, g: 255, b: 127),
        "steelblue":            RGBAu8(r: 70, g: 130, b: 180),
        "tan":                  RGBAu8(r: 210, g: 180, b: 140),
        "teal":                 RGBAu8(r: 0, g: 128, b: 128),
        "thistle":              RGBAu8(r: 223, g: 191, b: 216),
        "tomato":               RGBAu8(r: 255, g: 99, b: 71),
        "transparent":          .clear,
        "turquoise":            RGBAu8(r: 64, g: 224, b: 208),
        "violet":               RGBAu8(r: 238, g: 130, b: 238),
        "wheat":                RGBAu8(r: 245, g: 222, b: 179),
        "white":                .white,
        "whitesmoke":           RGBAu8(r: 245, g: 245, b: 245),
        "yellow":               RGBAu8(r: 255, g: 255, b: 0),
        "yellowgreen":          RGBAu8(r: 154, g: 205, b: 50),
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
        let pattern = #"""
            (?xi)
            ^rgba?\(
            \s*(?<r>\d+)\s*,            # red
            \s*(?<g>\d+)\s*,            # green
            \s*(?<b>\d+)                # blue
            (?:\s*,\s*(                 # optional alpha
            (?<a>[01]\.(?:\d+)?)        # floating point
            |(?<a8>\d+)                 # or integer
            )\s*
            )?                          # alpha end
            \)$
            """#
        let re = try? NSRegularExpression(pattern: pattern, options: [])
        let cssRange = NSRange(css.startIndex..<css.endIndex, in: css)
        a = 255
        if let re = re, let match = re.matches(in: css, options: [], range: cssRange).first {
            if let aRange = Range(match.range(withName: "a"), in: css), let aVal = Double(css[aRange]) {
                if aVal > 1.0 { return false }
                a = u8val(aVal)
            } else if let aRange = Range(match.range(withName: "a8"), in: css), let aVal = UInt8(css[aRange]) {
                a = aVal
            }

            if let rRange = Range(match.range(withName: "r"), in: css), let rVal = UInt8(css[rRange]) {
                r = rVal
            } else { return false }

            if let gRange = Range(match.range(withName: "g"), in: css), let gVal = UInt8(css[gRange]) {
                g = gVal
            } else { return false }

            if let bRange = Range(match.range(withName: "b"), in: css), let bVal = UInt8(css[bRange]) {
                b = bVal
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

        if name.lowercased().hasPrefix("clear-") {
            if let rgba = lookup(String(name.dropFirst(6))) {
                return rgba.with(alpha: 127)
            }
        } else if name.lowercased().hasPrefix("clear") {
            if let rgba = lookup(String(name.dropFirst(5))) {
                return rgba.with(alpha: 127)
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

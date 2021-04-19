//
//  ColourTranslate.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-12.
//

import Foundation

struct RGBAcolour {
    let r: Int
    let g: Int
    let b: Int
    let a: Double

    static var cache: [ String: RGBAcolour ] = [:]

    /// Create an RGBA with a new alpha
    /// - Parameter alpha: new alpha
    /// - Returns: New RGBA with new alpha

    func with(alpha: Double) -> RGBAcolour {
        return RGBAcolour(r: self.r, g: self.g, b: self.b, a: alpha)
    }

    /// Modiify the alpha by multiplyimg
    /// - Parameter alpha: multiplier
    /// - Returns: New RGBA with modified alpha

    func modify(alpha: Double) -> RGBAcolour {
        return RGBAcolour(r: r, g: g, b: b, a: min(a * alpha, 1.0))
    }

    /// Formatted RGBA
    var asText: String {
        let text = String(format: "rgba(%d,%d,%d,%.3f)", r, g, b, a)
        RGBAcolour.cache[text] = self
        return text
    }

    /// as CGColor
    var cgColor: CGColor {
        CGColor(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: CGFloat(a))
    }

    // Standard colours
    static var clear: RGBAcolour { RGBAcolour(r: 0, g: 0, b: 0, a: 0.0) }
    static var black: RGBAcolour { RGBAcolour(r: 0, g: 0, b: 0, a: 1.0) }
    static var white: RGBAcolour { RGBAcolour(r: 255, g: 255, b: 255, a: 1.0) }

    /// components as a UInt8
    var u8r: UInt8 { UInt8(r) }
    var u8g: UInt8 { UInt8(g) }
    var u8b: UInt8 { UInt8(b) }
    var u8ɑ: UInt8 { UInt8(floor(a * 255.0)) }

    // components packed together
    var u32: UInt32 { UInt32(r << 24 | g << 16 | b << 8 | Int(u8ɑ)) }
}

struct ColourTranslate {
    fileprivate static let name2rgba = [
    "aliceblue":                RGBAcolour(r: 240, g: 248, b: 255, a: 1.0),
        "antiquewhite":         RGBAcolour(r: 250, g: 235, b: 215, a: 1.0),
        "aqua":                 RGBAcolour(r: 0, g: 240, b: 255, a: 1.0),
        "aquamarine":           RGBAcolour(r: 127, g: 255, b: 212, a: 1.0),
        "azure":                RGBAcolour(r: 240, g: 255, b: 255, a: 1.0),
        "beige":                RGBAcolour(r: 245, g: 245, b: 220, a: 1.0),
        "bisque":               RGBAcolour(r: 255, g: 228, b: 196, a: 1.0),
        "black":                RGBAcolour(r: 0, g: 0, b: 0, a: 1.0),
        "blanchedalmond":       RGBAcolour(r: 255, g: 235, b: 205, a: 1.0),
        "blue":                 RGBAcolour(r: 0, g: 0, b: 255, a: 1.0),
        "blueviolet":           RGBAcolour(r: 138, g: 43, b: 226, a: 1.0),
        "brown":                RGBAcolour(r: 165, g: 42, b: 42, a: 1.0),
        "burlywood":            RGBAcolour(r: 222, g: 184, b: 135, a: 1.0),
        "cadetblue":            RGBAcolour(r: 95, g: 158, b: 160, a: 1.0),
        "chartreuse":           RGBAcolour(r: 127, g: 255, b: 0, a: 1.0),
        "chocolate":            RGBAcolour(r: 210, g: 105, b: 30, a: 1.0),
        "clear":                RGBAcolour(r: 0, g: 0, b: 0, a: 0.0),
        "coral":                RGBAcolour(r: 255, g: 127, b: 80, a: 1.0),
        "cornflowerblue":       RGBAcolour(r: 100, g: 149, b: 237, a: 1.0),
        "cornsilk":             RGBAcolour(r: 255, g: 248, b: 220, a: 1.0),
        "crimson":              RGBAcolour(r: 220, g: 20, b: 60, a: 1.0),
        "cyan":                 RGBAcolour(r: 0, g: 255, b: 255, a: 1.0),
        "darkblue":             RGBAcolour(r: 0, g: 0, b: 139, a: 1.0),
        "darkcyan":             RGBAcolour(r: 0, g: 139, b: 139, a: 1.0),
        "darkgoldenrod":        RGBAcolour(r: 184, g: 134, b: 11, a: 1.0),
        "darkgray":             RGBAcolour(r: 169, g: 169, b: 169, a: 1.0),
        "darkgrey":             RGBAcolour(r: 169, g: 169, b: 169, a: 1.0),
        "darkgreen":            RGBAcolour(r: 0, g: 100, b: 0, a: 1.0),
        "darkkhaki":            RGBAcolour(r: 189, g: 183, b: 107, a: 1.0),
        "darkmagenta":          RGBAcolour(r: 139, g: 0, b: 139, a: 1.0),
        "darkolivegreen":       RGBAcolour(r: 85, g: 107, b: 47, a: 1.0),
        "darkorange":           RGBAcolour(r: 255, g: 140, b: 0, a: 1.0),
        "darkorchid":           RGBAcolour(r: 153, g: 50, b: 204, a: 1.0),
        "darkred":              RGBAcolour(r: 139, g: 0, b: 0, a: 1.0),
        "darksalmon":           RGBAcolour(r: 233, g: 150, b: 122, a: 1.0),
        "darkseagreen":         RGBAcolour(r: 143, g: 188, b: 143, a: 1.0),
        "darkslateblue":        RGBAcolour(r: 72, g: 61, b: 139, a: 1.0),
        "darkslategray":        RGBAcolour(r: 47, g: 79, b: 79, a: 1.0),
        "darkslategrey":        RGBAcolour(r: 47, g: 79, b: 79, a: 1.0),
        "darkturquoise":        RGBAcolour(r: 0, g: 206, b: 209, a: 1.0),
        "darkviolet":           RGBAcolour(r: 148, g: 0, b: 211, a: 1.0),
        "deeppink":             RGBAcolour(r: 255, g: 20, b: 147, a: 1.0),
        "deepskyblue":          RGBAcolour(r: 0, g: 191, b: 255, a: 1.0),
        "dimgray":              RGBAcolour(r: 105, g: 105, b: 105, a: 1.0),
        "dodgerblue":           RGBAcolour(r: 30, g: 144, b: 255, a: 1.0),
        "firebrick":            RGBAcolour(r: 178, g: 34, b: 34, a: 1.0),
        "floralwhite":          RGBAcolour(r: 255, g: 250, b: 240, a: 1.0),
        "forestgreen":          RGBAcolour(r: 34, g: 139, b: 34, a: 1.0),
        "fuschia":              RGBAcolour(r: 255, g: 0, b: 255, a: 1.0),
        "gainsboro":            RGBAcolour(r: 220, g: 220, b: 220, a: 1.0),
        "ghostwhite":           RGBAcolour(r: 248, g: 248, b: 255, a: 1.0),
        "gold":                 RGBAcolour(r: 255, g: 215, b: 0, a: 1.0),
        "goldenrod":            RGBAcolour(r: 218, g: 165, b: 32, a: 1.0),
        "gray":                 RGBAcolour(r: 128, g: 128, b: 128, a: 1.0),
        "green":                RGBAcolour(r: 0, g: 255, b: 0, a: 1.0),
        "greenyellow":          RGBAcolour(r: 173, g: 255, b: 47, a: 1.0),
        "grey":                 RGBAcolour(r: 128, g: 128, b: 128, a: 1.0),
        "honeydew":             RGBAcolour(r: 240, g: 255, b: 240, a: 1.0),
        "hotpink":              RGBAcolour(r: 255, g: 105, b: 180, a: 1.0),
        "indianred":            RGBAcolour(r: 205, g: 92, b: 92, a: 1.0),
        "indigo":               RGBAcolour(r: 75, g: 0, b: 130, a: 1.0),
        "ivory":                RGBAcolour(r: 255, g: 255, b: 240, a: 1.0),
        "khaki":                RGBAcolour(r: 240, g: 230, b: 140, a: 1.0),
        "lavender":             RGBAcolour(r: 230, g: 230, b: 250, a: 1.0),
        "lavenderblush":        RGBAcolour(r: 255, g: 240, b: 245, a: 1.0),
        "lawngreen":            RGBAcolour(r: 124, g: 252, b: 0, a: 1.0),
        "lemonchiffon":         RGBAcolour(r: 255, g: 250, b: 205, a: 1.0),
        "lightblue":            RGBAcolour(r: 173, g: 216, b: 230, a: 1.0),
        "lightcoral":           RGBAcolour(r: 240, g: 128, b: 128, a: 1.0),
        "lightcyan":            RGBAcolour(r: 224, g: 255, b: 255, a: 1.0),
        "lightgoldenrodyellow": RGBAcolour(r: 250, g: 250, b: 210, a: 1.0),
        "lightgray":            RGBAcolour(r: 211, g: 211, b: 211, a: 1.0),
        "lightgreen":           RGBAcolour(r: 144, g: 238, b: 144, a: 1.0),
        "lightgrey":            RGBAcolour(r: 211, g: 211, b: 211, a: 1.0),
        "lightpink":            RGBAcolour(r: 255, g: 182, b: 193, a: 1.0),
        "lightsalmon":          RGBAcolour(r: 255, g: 160, b: 122, a: 1.0),
        "lightseagreen":        RGBAcolour(r: 32, g: 178, b: 170, a: 1.0),
        "lightskyblue":         RGBAcolour(r: 135, g: 206, b: 250, a: 1.0),
        "lightslategray":       RGBAcolour(r: 119, g: 136, b: 153, a: 1.0),
        "lightslategrey":       RGBAcolour(r: 119, g: 136, b: 153, a: 1.0),
        "lightsteelblue":       RGBAcolour(r: 176, g: 196, b: 222, a: 1.0),
        "lightyellow":          RGBAcolour(r: 255, g: 255, b: 224, a: 1.0),
        "limegreen":            RGBAcolour(r: 50, g: 205, b: 50, a: 1.0),
        "linen":                RGBAcolour(r: 250, g: 240, b: 230, a: 1.0),
        "magenta":              RGBAcolour(r: 255, g: 0, b: 255, a: 1.0),
        "maroon":               RGBAcolour(r: 128, g: 0, b: 0, a: 1.0),
        "mediumaquamarine":     RGBAcolour(r: 102, g: 205, b: 170, a: 1.0),
        "mediumblue":           RGBAcolour(r: 0, g: 0, b: 205, a: 1.0),
        "mediumorchid":         RGBAcolour(r: 186, g: 85, b: 211, a: 1.0),
        "mediumpurple":         RGBAcolour(r: 147, g: 112, b: 219, a: 1.0),
        "mediumseagreen":       RGBAcolour(r: 60, g: 179, b: 113, a: 1.0),
        "mediumslateblue":      RGBAcolour(r: 123, g: 104, b: 238, a: 1.0),
        "mediumspringgreen":    RGBAcolour(r: 0, g: 250, b: 154, a: 1.0),
        "mediumturquoise":      RGBAcolour(r: 72, g: 209, b: 204, a: 1.0),
        "mediumvioletred":      RGBAcolour(r: 199, g: 21, b: 133, a: 1.0),
        "midnightblue":         RGBAcolour(r: 25, g: 25, b: 112, a: 1.0),
        "mintcream":            RGBAcolour(r: 245, g: 255, b: 250, a: 1.0),
        "mistyrose":            RGBAcolour(r: 255, g: 228, b: 225, a: 1.0),
        "moccasin":             RGBAcolour(r: 255, g: 228, b: 181, a: 1.0),
        "navajowhite":          RGBAcolour(r: 255, g: 222, b: 173, a: 1.0),
        "navy":                 RGBAcolour(r: 0, g: 0, b: 128, a: 1.0),
        "oldlace":              RGBAcolour(r: 253, g: 245, b: 230, a: 1.0),
        "olive":                RGBAcolour(r: 128, g: 128, b: 0, a: 1.0),
        "olivedrab":            RGBAcolour(r: 107, g: 142, b: 35, a: 1.0),
        "orange":               RGBAcolour(r: 255, g: 165, b: 0, a: 1.0),
        "orangered":            RGBAcolour(r: 255, g: 69, b: 0, a: 1.0),
        "orchid":               RGBAcolour(r: 218, g: 112, b: 214, a: 1.0),
        "palegoldenrod":        RGBAcolour(r: 238, g: 232, b: 170, a: 1.0),
        "palegreen":            RGBAcolour(r: 152, g: 251, b: 152, a: 1.0),
        "paleturquoise":        RGBAcolour(r: 174, g: 238, b: 238, a: 1.0),
        "palevioletred":        RGBAcolour(r: 219, g: 112, b: 147, a: 1.0),
        "papayawhip":           RGBAcolour(r: 255, g: 239, b: 213, a: 1.0),
        "peru":                 RGBAcolour(r: 205, g: 133, b: 63, a: 1.0),
        "pink":                 RGBAcolour(r: 255, g: 192, b: 203, a: 1.0),
        "plum":                 RGBAcolour(r: 221, g: 160, b: 221, a: 1.0),
        "powderblue":           RGBAcolour(r: 176, g: 224, b: 230, a: 1.0),
        "purple":               RGBAcolour(r: 128, g: 0, b: 128, a: 1.0),
        "rebeccapurple":        RGBAcolour(r: 102, g: 51, b: 153, a: 1.0),
        "red":                  RGBAcolour(r: 255, g: 0, b: 0, a: 1.0),
        "rosybrown":            RGBAcolour(r: 188, g: 143, b: 143, a: 1.0),
        "royalblue":            RGBAcolour(r: 65, g: 105, b: 225, a: 1.0),
        "saddlebrown":          RGBAcolour(r: 139, g: 69, b: 19, a: 1.0),
        "salmon":               RGBAcolour(r: 250, g: 128, b: 114, a: 1.0),
        "sandybrown":           RGBAcolour(r: 244, g: 164, b: 96, a: 1.0),
        "seagreen":             RGBAcolour(r: 46, g: 139, b: 87, a: 1.0),
        "seashell":             RGBAcolour(r: 255, g: 245, b: 238, a: 1.0),
        "sienna":               RGBAcolour(r: 160, g: 82, b: 45, a: 1.0),
        "silver":               RGBAcolour(r: 192, g: 192, b: 192, a: 1.0),
        "skyblue":              RGBAcolour(r: 135, g: 206, b: 235, a: 1.0),
        "slateblue":            RGBAcolour(r: 106, g: 90, b: 205, a: 1.0),
        "slategray":            RGBAcolour(r: 112, g: 128, b: 144, a: 1.0),
        "slategrey":            RGBAcolour(r: 112, g: 128, b: 144, a: 1.0),
        "snow":                 RGBAcolour(r: 255, g: 250, b: 250, a: 1.0),
        "springgreen":          RGBAcolour(r: 0, g: 255, b: 127, a: 1.0),
        "steelblue":            RGBAcolour(r: 70, g: 130, b: 180, a: 1.0),
        "tan":                  RGBAcolour(r: 210, g: 180, b: 140, a: 1.0),
        "teal":                 RGBAcolour(r: 0, g: 128, b: 128, a: 1.0),
        "thistle":              RGBAcolour(r: 223, g: 191, b: 216, a: 1.0),
        "tomato":               RGBAcolour(r: 255, g: 99, b: 71, a: 1.0),
        "transparent":          RGBAcolour(r: 0, g: 0, b: 0, a: 0.0),
        "turquoise":            RGBAcolour(r: 64, g: 224, b: 208, a: 1.0),
        "violet":               RGBAcolour(r: 238, g: 130, b: 238, a: 1.0),
        "wheat":                RGBAcolour(r: 245, g: 222, b: 179, a: 1.0),
        "white":                RGBAcolour(r: 255, g: 255, b: 255, a: 1.0),
        "whitesmoke":           RGBAcolour(r: 245, g: 245, b: 245, a: 1.0),
        "yellow":               RGBAcolour(r: 255, g: 255, b: 0, a: 1.0),
        "yellowgreen":          RGBAcolour(r: 154, g: 205, b: 50, a: 1.0),
    ]

    /// Convert a hex substring to an Int
    /// Return true on success
    ///
    /// Parameters:
    ///     from:     base string
    ///     first:      first character from beginning to use
    ///     count:   number of characters
    ///     to:         reference to result

    fileprivate static func hexToInt(from: String, first: Int, count: Int, to: inout Int) -> Bool {
        let start = from.index(from.startIndex, offsetBy: first)
        let end = from.index(from.startIndex, offsetBy: first + count)
        let subFrom = from[start..<end]
        guard let val = Int(subFrom, radix: 16) else { return false }
        to = val
        return true
    }

    /// Convert a hex string to red, green & blue
    /// Expectd formats "#rgb" or "#rrggbb"
    /// Returns true on success
    ///
    /// Parameters:
    ///     hex:        hex string
    ///     r:             reference to red colour
    ///     g:            reference to green colour
    ///     b:            reference to blue colour

    fileprivate static func hexToRGB(hex: String?, r: inout Int, g: inout Int, b: inout Int) -> Bool {
        if hex == nil || !hex!.hasPrefix("#") { return false }
        switch hex!.count {
        case 4:     // #rgb
            if  !hexToInt(from: hex!, first: 1, count: 1, to: &r) ||
                !hexToInt(from: hex!, first: 2, count: 1, to: &g) ||
                !hexToInt(from: hex!, first: 3, count: 1, to: &b) { return false }
            r *= 17
            g *= 17
            b *= 17
        case 7:     // #rrggbb
            if  !hexToInt(from: hex!, first: 1, count: 2, to: &r) ||
                !hexToInt(from: hex!, first: 3, count: 2, to: &g) ||
                !hexToInt(from: hex!, first: 5, count: 2, to: &b) { return false }
        default:
            return false
        }

        return true
    }

    /// Lookup a known colour name or hex code
    /// - Parameter name: colour name of hex code
    /// - Returns: A matching RGBA or transparent black

    static func lookup(_ name: String?) -> RGBAcolour? {
        guard let name = name else { return nil }
        if name.isEmpty { return nil }
        if let cached = RGBAcolour.cache[name] { return cached }
        if let rgba = name2rgba[name] { return rgba }
        var r = 0
        var g = 0
        var b = 0
        if hexToRGB(hex: name, r: &r, g: &g, b: &b) {
            return RGBAcolour(r: r, g: g, b: b, a: 1.0)
        }
        return nil
    }
}

//
//  ColourTranslate.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-12.
//

import Foundation

struct RGBA {
    let r: Int
    let g: Int
    let b: Int
    let a: Int

    func modifyAlpha(_ alpha: Int) -> RGBA {
        return RGBA(r: self.r, g: self.g, b: self.b, a: alpha)
    }

    func modifyAlpha(_ alpha: Double) -> RGBA {
        return RGBA(r: self.r, g: self.g, b: self.b, a: Int(alpha * 255.0))
    }
}

struct ColourTranslate {
    static let name2rgba = [
    "aliceblue":                RGBA(r: 240, g: 248, b: 255, a: 255),
        "antiquewhite":         RGBA(r: 250, g: 235, b: 215, a: 255),
        "aqua":                 RGBA(r: 0, g: 240, b: 255, a: 255),
        "aquamarine":           RGBA(r: 127, g: 255, b: 212, a: 255),
        "azure":                RGBA(r: 240, g: 255, b: 255, a: 255),
        "beige":                RGBA(r: 245, g: 245, b: 220, a: 255),
        "bisque":               RGBA(r: 255, g: 228, b: 196, a: 255),
        "black":                RGBA(r: 0, g: 0, b: 0, a: 255),
        "blanchedalmond":       RGBA(r: 255, g: 235, b: 205, a: 255),
        "blue":                 RGBA(r: 0, g: 0, b: 255, a: 255),
        "blueviolet":           RGBA(r: 138, g: 43, b: 226, a: 255),
        "brown":                RGBA(r: 165, g: 42, b: 42, a: 255),
        "burlywood":            RGBA(r: 222, g: 184, b: 135, a: 255),
        "cadetblue":            RGBA(r: 95, g: 158, b: 160, a: 255),
        "chartreuse":           RGBA(r: 127, g: 255, b: 0, a: 255),
        "chocolate":            RGBA(r: 210, g: 105, b: 30, a: 255),
        "coral":                RGBA(r: 255, g: 127, b: 80, a: 255),
        "cornflowerblue":       RGBA(r: 100, g: 149, b: 237, a: 255),
        "cornsilk":             RGBA(r: 255, g: 248, b: 220, a: 255),
        "crimson":              RGBA(r: 220, g: 20, b: 60, a: 255),
        "cyan":                 RGBA(r: 0, g: 255, b: 255, a: 255),
        "darkblue":             RGBA(r: 0, g: 0, b: 139, a: 255),
        "darkcyan":             RGBA(r: 0, g: 139, b: 139, a: 255),
        "darkgoldenrod":        RGBA(r: 184, g: 134, b: 11, a: 255),
        "darkgray":             RGBA(r: 169, g: 169, b: 169, a: 255),
        "darkgrey":             RGBA(r: 169, g: 169, b: 169, a: 255),
        "darkgreen":            RGBA(r: 0, g: 100, b: 0, a: 255),
        "darkkhaki":            RGBA(r: 189, g: 183, b: 107, a: 255),
        "darkmagenta":          RGBA(r: 139, g: 0, b: 139, a: 255),
        "darkolivegreen":       RGBA(r: 85, g: 107, b: 47, a: 255),
        "darkorange":           RGBA(r: 255, g: 140, b: 0, a: 255),
        "darkorchid":           RGBA(r: 153, g: 50, b: 204, a: 255),
        "darkred":              RGBA(r: 139, g: 0, b: 0, a: 255),
        "darksalmon":           RGBA(r: 233, g: 150, b: 122, a: 255),
        "darkseagreen":         RGBA(r: 143, g: 188, b: 143, a: 255),
        "darkslateblue":        RGBA(r: 72, g: 61, b: 139, a: 255),
        "darkslategray":        RGBA(r: 47, g: 79, b: 79, a: 255),
        "darkslategrey":        RGBA(r: 47, g: 79, b: 79, a: 255),
        "darkturquoise":        RGBA(r: 0, g: 206, b: 209, a: 255),
        "darkviolet":           RGBA(r: 148, g: 0, b: 211, a: 255),
        "deeppink":             RGBA(r: 255, g: 20, b: 147, a: 255),
        "deepskyblue":          RGBA(r: 0, g: 191, b: 255, a: 255),
        "dimgray":              RGBA(r: 105, g: 105, b: 105, a: 255),
        "dodgerblue":           RGBA(r: 30, g: 144, b: 255, a: 255),
        "firebrick":            RGBA(r: 178, g: 34, b: 34, a: 255),
        "floralwhite":          RGBA(r: 255, g: 250, b: 240, a: 255),
        "forestgreen":          RGBA(r: 34, g: 139, b: 34, a: 255),
        "fuschia":              RGBA(r: 255, g: 0, b: 255, a: 255),
        "gainsboro":            RGBA(r: 220, g: 220, b: 220, a: 255),
        "ghostwhite":           RGBA(r: 248, g: 248, b: 255, a: 255),
        "gold":                 RGBA(r: 255, g: 215, b: 0, a: 255),
        "goldenrod":            RGBA(r: 218, g: 165, b: 32, a: 255),
        "gray":                 RGBA(r: 128, g: 128, b: 128, a: 255),
        "green":                RGBA(r: 0, g: 255, b: 0, a: 255),
        "greenyellow":          RGBA(r: 173, g: 255, b: 47, a: 255),
        "grey":                 RGBA(r: 128, g: 128, b: 128, a: 255),
        "honeydew":             RGBA(r: 240, g: 255, b: 240, a: 255),
        "hotpink":              RGBA(r: 255, g: 105, b: 180, a: 255),
        "indianred":            RGBA(r: 205, g: 92, b: 92, a: 255),
        "indigo":               RGBA(r: 75, g: 0, b: 130, a: 255),
        "ivory":                RGBA(r: 255, g: 255, b: 240, a: 255),
        "khaki":                RGBA(r: 240, g: 230, b: 140, a: 255),
        "lavender":             RGBA(r: 230, g: 230, b: 250, a: 255),
        "lavenderblush":        RGBA(r: 255, g: 240, b: 245, a: 255),
        "lawngreen":            RGBA(r: 124, g: 252, b: 0, a: 255),
        "lemonchiffon":         RGBA(r: 255, g: 250, b: 205, a: 255),
        "lightblue":            RGBA(r: 173, g: 216, b: 230, a: 255),
        "lightcoral":           RGBA(r: 240, g: 128, b: 128, a: 255),
        "lightcyan":            RGBA(r: 224, g: 255, b: 255, a: 255),
        "lightgoldenrodyellow": RGBA(r: 250, g: 250, b: 210, a: 255),
        "lightgray":            RGBA(r: 211, g: 211, b: 211, a: 255),
        "lightgreen":           RGBA(r: 144, g: 238, b: 144, a: 255),
        "lightgrey":            RGBA(r: 211, g: 211, b: 211, a: 255),
        "lightpink":            RGBA(r: 255, g: 182, b: 193, a: 255),
        "lightsalmon":          RGBA(r: 255, g: 160, b: 122, a: 255),
        "lightseagreen":        RGBA(r: 32, g: 178, b: 170, a: 255),
        "lightskyblue":         RGBA(r: 135, g: 206, b: 250, a: 255),
        "lightslategray":       RGBA(r: 119, g: 136, b: 153, a: 255),
        "lightslategrey":       RGBA(r: 119, g: 136, b: 153, a: 255),
        "lightsteelblue":       RGBA(r: 176, g: 196, b: 222, a: 255),
        "lightyellow":          RGBA(r: 255, g: 255, b: 224, a: 255),
        "limegreen":            RGBA(r: 50, g: 205, b: 50, a: 255),
        "linen":                RGBA(r: 250, g: 240, b: 230, a: 255),
        "magenta":              RGBA(r: 255, g: 0, b: 255, a: 255),
        "maroon":               RGBA(r: 128, g: 0, b: 0, a: 255),
        "mediumaquamarine":     RGBA(r: 102, g: 205, b: 170, a: 255),
        "mediumblue":           RGBA(r: 0, g: 0, b: 205, a: 255),
        "mediumorchid":         RGBA(r: 186, g: 85, b: 211, a: 255),
        "mediumpurple":         RGBA(r: 147, g: 112, b: 219, a: 255),
        "mediumseagreen":       RGBA(r: 60, g: 179, b: 113, a: 255),
        "mediumslateblue":      RGBA(r: 123, g: 104, b: 238, a: 255),
        "mediumspringgreen":    RGBA(r: 0, g: 250, b: 154, a: 255),
        "mediumturquoise":      RGBA(r: 72, g: 209, b: 204, a: 255),
        "mediumvioletred":      RGBA(r: 199, g: 21, b: 133, a: 255),
        "midnightblue":         RGBA(r: 25, g: 25, b: 112, a: 255),
        "mintcream":            RGBA(r: 245, g: 255, b: 250, a: 255),
        "mistyrose":            RGBA(r: 255, g: 228, b: 225, a: 255),
        "moccasin":             RGBA(r: 255, g: 228, b: 181, a: 255),
        "navajowhite":          RGBA(r: 255, g: 222, b: 173, a: 255),
        "navy":                 RGBA(r: 0, g: 0, b: 128, a: 255),
        "oldlace":              RGBA(r: 253, g: 245, b: 230, a: 255),
        "olive":                RGBA(r: 128, g: 128, b: 0, a: 255),
        "olivedrab":            RGBA(r: 107, g: 142, b: 35, a: 255),
        "orange":               RGBA(r: 255, g: 165, b: 0, a: 255),
        "orangered":            RGBA(r: 255, g: 69, b: 0, a: 255),
        "orchid":               RGBA(r: 218, g: 112, b: 214, a: 255),
        "palegoldenrod":        RGBA(r: 238, g: 232, b: 170, a: 255),
        "palegreen":            RGBA(r: 152, g: 251, b: 152, a: 255),
        "paleturquoise":        RGBA(r: 174, g: 238, b: 238, a: 255),
        "palevioletred":        RGBA(r: 219, g: 112, b: 147, a: 255),
        "papayawhip":           RGBA(r: 255, g: 239, b: 213, a: 255),
        "peru":                 RGBA(r: 205, g: 133, b: 63, a: 255),
        "pink":                 RGBA(r: 255, g: 192, b: 203, a: 255),
        "plum":                 RGBA(r: 221, g: 160, b: 221, a: 255),
        "powderblue":           RGBA(r: 176, g: 224, b: 230, a: 255),
        "purple":               RGBA(r: 128, g: 0, b: 128, a: 255),
        "rebeccapurple":        RGBA(r: 102, g: 51, b: 153, a: 255),
        "red":                  RGBA(r: 255, g: 0, b: 0, a: 255),
        "rosybrown":            RGBA(r: 188, g: 143, b: 143, a: 255),
        "royalblue":            RGBA(r: 65, g: 105, b: 225, a: 255),
        "saddlebrown":          RGBA(r: 139, g: 69, b: 19, a: 255),
        "salmon":               RGBA(r: 250, g: 128, b: 114, a: 255),
        "sandybrown":           RGBA(r: 244, g: 164, b: 96, a: 255),
        "seagreen":             RGBA(r: 46, g: 139, b: 87, a: 255),
        "seashell":             RGBA(r: 255, g: 245, b: 238, a: 255),
        "sienna":               RGBA(r: 160, g: 82, b: 45, a: 255),
        "silver":               RGBA(r: 192, g: 192, b: 192, a: 255),
        "skyblue":              RGBA(r: 135, g: 206, b: 235, a: 255),
        "slateblue":            RGBA(r: 106, g: 90, b: 205, a: 255),
        "slategray":            RGBA(r: 112, g: 128, b: 144, a: 255),
        "slategrey":            RGBA(r: 112, g: 128, b: 144, a: 255),
        "snow":                 RGBA(r: 255, g: 250, b: 250, a: 255),
        "springgreen":          RGBA(r: 0, g: 255, b: 127, a: 255),
        "steelblue":            RGBA(r: 70, g: 130, b: 180, a: 255),
        "tan":                  RGBA(r: 210, g: 180, b: 140, a: 255),
        "teal":                 RGBA(r: 0, g: 128, b: 128, a: 255),
        "thistle":              RGBA(r: 223, g: 191, b: 216, a: 255),
        "tomato":               RGBA(r: 255, g: 99, b: 71, a: 255),
        "transparent":          RGBA(r: 0, g: 0, b: 0, a: 0),
        "turquoise":            RGBA(r: 64, g: 224, b: 208, a: 255),
        "violet":               RGBA(r: 238, g: 130, b: 238, a: 255),
        "wheat":                RGBA(r: 245, g: 222, b: 179, a: 255),
        "white":                RGBA(r: 255, g: 255, b: 255, a: 255),
        "whitesmoke":           RGBA(r: 245, g: 245, b: 245, a: 255),
        "yellow":               RGBA(r: 255, g: 255, b: 0, a: 255),
        "yellowgreen":          RGBA(r: 154, g: 205, b: 50, a: 255),
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

    static func lookup(_ name: String) -> RGBA? {
        if let rgba = name2rgba[name] { return rgba }
        var r = 0
        var g = 0
        var b = 0
        if hexToRGB(hex: name, r: &r, g: &g, b: &b) {
            return RGBA(r: r, g: g, b: b, a: 255)
        }
        return nil
    }
}

//
//  KeyTag.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-16.
//

import Foundation
import OptGetter

extension Options {
    enum Key: CodingKey, OptGetterTag {
        case bared
        case baroffset
        case barwidth
        case bezier
        case bg
        case black
        case bold
        case bounds
        case canvas
        case colours
        case comment
        case css
        case cssid
        case dashed
        case dashes
        case debug
        case distance
        case draft
        case fg
        case filled
        case font
        case headers
        case height
        case help
        case hover
        case include
        case indent
        case index
        case italic
        case left
        case legends
        case logo
        case logx
        case logy
        case nameheader
        case names
        case opacity
        case pie
        case random
        case reserve
        case right
        case rows
        case scattered
        case semi
        case shapes
        case showpoints
        case size
        case smooth
        case sortx
        case stroke
        case subheader
        case subtitle
        case svg
        case tag
        case textcolour
        case title
        case tsv
        case usage
        case verbose
        case width
        case xmax
        case xmin
        case xtags
        case xtick
        case ymax
        case ymin
        case ytick

        var longname: String {
            switch self {
            case .bounds: return "nobounds"
            case .comment: return "nocomment"
            case .hover: return "nohover"
            case .legends: return "nolegends"
            default: return self.stringValue
            }
        }
    }
}

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
        case bitmap
        case black
        case bold
        case bounds
        case canvas
        case canvastag
        case colournames
        case colournameslist
        case colours
        case colourslist
        case comment
        case css
        case cssid
        case dashed
        case dashes
        case dasheslist
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
        case index
        case italic
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
        case rows
        case scattered
        case semi
        case shapenames
        case shapes
        case show
        case showpoints
        case size
        case smooth
        case sortx
        case stroke
        case subheader
        case subtitle
        case svg
        case textcolour
        case title
        case tsv
        case verbose
        case version
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

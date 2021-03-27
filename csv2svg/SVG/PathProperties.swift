//
//  Properties.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-16.
//

import Foundation

extension SVG {
    struct PathProperties {
        var colour: String?
        var cssClass: String?
        var dash: String?
        var name: String?
        var dashed = false
        var included = true
        var pointed = false
        var scattered = false
        var shape: Shape?
    }

    static func pathProperty(withColour colour: String, andClass cssClass: String) -> PathProperties {
        var props = PathProperties()
        props.colour = colour
        props.cssClass = cssClass
        return props
    }
}

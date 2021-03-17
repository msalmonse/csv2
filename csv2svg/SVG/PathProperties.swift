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
        var dash: String?
        var name: String?
        var dashed = false
        var pointed = false
        var scattered = false
        var shape: Shape?
    }

    func pathProperty(withColour colour: String) -> PathProperties {
        var props = PathProperties()
        props.colour = colour
        return props
    }
}

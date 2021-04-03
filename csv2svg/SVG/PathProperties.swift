//
//  Properties.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-16.
//

import Foundation

extension SVG {
    struct PathProperties {
        var bezier: Double = 0.0
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
}

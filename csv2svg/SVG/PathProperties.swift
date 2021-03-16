//
//  Properties.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-16.
//

import Foundation

extension SVG {
    struct PathProperties {
        var colour: String? = nil
        var dash: String? = nil
        var name: String? = nil
        var pointed = false
        var scattered = false
        var shape: Shape? = nil
    }
}

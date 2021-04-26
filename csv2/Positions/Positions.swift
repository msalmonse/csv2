//
//  Positions.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-26.
//

import Foundation

protocol Positions {
    // Vertical positions
    var bottomY: Double { get }
    var legendY: Double { get }
    var logoY: Double { get }
    var subTitleY: Double { get }
    var titleY: Double { get }
    var topY: Double { get }
    var xTagsY: Double { get }
    var xTagsTopY: Double { get }
    var xTicksY: Double { get }
    var xTitleY: Double { get }

    // Horizontal positions
    var leftX: Double { get }
    var legendLeftX: Double { get }
    var legendRightX: Double { get }
    var logoX: Double { get }
    var rightX: Double { get }
    var yTickX: Double { get }
    var yTitleX: Double { get }
}

//
//  Fonts.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-27.
//

import Foundation

// Font sizes
struct FontSizes {
    let axesSize: Double
    let labelSize: Double
    let legendSize: Double
    let subTitleSize: Double
    let titleSize: Double

    init(size: Double) {
        axesSize = size * 1.2
        labelSize = size
        legendSize = size * 1.3
        subTitleSize = size * 1.5
        titleSize = size * 2.5
    }
}

//
//  Fonts.swift
//  csv2
//
//  Created by Michael Salmon on 2021-03-27.
//

import Foundation

struct FontSizeAndSpacing {
    let size: Double
    var spacing: Double { size * 1.25 }

    init(_ size: Double) {
        self.size = size
    }
}

// Font sizes
struct FontSizes {
    let axes: FontSizeAndSpacing
    let label: FontSizeAndSpacing
    let legend: FontSizeAndSpacing
    let pieLabel: FontSizeAndSpacing
    let pieLegend: FontSizeAndSpacing
    let pieSubLegend: FontSizeAndSpacing
    let subTitle: FontSizeAndSpacing
    let title: FontSizeAndSpacing

    init(size: Double) {
        axes = FontSizeAndSpacing(size * 1.2)
        label = FontSizeAndSpacing(size)
        legend = FontSizeAndSpacing(size * 1.30)
        pieLabel = FontSizeAndSpacing(size)
        pieLegend = FontSizeAndSpacing(size * 2.0)
        pieSubLegend = FontSizeAndSpacing(size * 1.25)
        subTitle = FontSizeAndSpacing(size * 1.5)
        title = FontSizeAndSpacing(size * 2.5)
    }
}

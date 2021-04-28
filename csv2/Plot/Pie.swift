//
//  Pie.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-26.
//

import Foundation

extension Plot {

    func plotPie(_ row: Int, _ col1: Int, centre: Point, radius: Double) {
        let pi2e6 = Double.pi * 2.0e6       // 2πe6
        var arcLeft = pi2e6
        var start = 0.0

        let pieValues = csv.rowValues(row)
        var sum = pieValues[col1...].reduce(0.0) { $0 + abs($1 ?? 0) }
        for col in pieValues.indices where col >= col1 {
            if let val = pieValues[col] {
                let absVal = abs(val)
                let angle6 = min(round(arcLeft * absVal/sum), arcLeft)
                sum -= absVal
                arcLeft -= angle6
                let end = start + angle6/1.0e6
                // Don't plot tiny slices
                if radius * angle6/1.0e6 > strokeWidth {
                    let path = Path(
                        [
                            .arcAround(centre: centre, radius: radius, start: start, end: end),
                            .lineTo(xy: centre),
                            .z
                        ]
                    )
                    // Don't fill negative slices
                    if val >= 0.0 {
                        plotter.plotPath(path, styles: stylesList.plots[col], fill: true)
                    }
                    plotter.plotPath(path, styles: stylesList.plots[col], fill: false)
                }
                start = end
            }
        }
        let xtag = settings.csv.xTagsHeader
        if xtag >= 0 {
            let yPos = ceil(min(positions.xTagsY, centre.y + radius + sizes.pieLegend.spacing * 2.0))
            plotter.plotText(x: centre.x, y: yPos, text: csv.data[row][xtag], styles: stylesList.pieLegend)
        }
    }
}

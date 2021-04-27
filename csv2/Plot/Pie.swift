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
        var sum = pieValues[col1...].reduce(0.0) { $0 + ($1 ?? 0) }
        for col in pieValues.indices where col >= col1 {
            if let val = pieValues[col] {
                let angle6 = min(round(arcLeft * val/sum), arcLeft)
                sum -= val
                arcLeft -= angle6
                let end = start + angle6/1.0e6
                let path = Path(
                    [
                        .arcAround(centre: centre, radius: radius, start: start, end: end),
                        .lineTo(xy: centre),
                        .z
                    ]
                )
                start = end
                plotter.plotPath(path, props: propsList.plots[col], fill: true)
            }
        }
        let xtag = settings.csv.xTagsHeader
        if xtag >= 0 {
            let yPos = ceil(min(positions.xTagsY, centre.y + radius + sizes.legend.spacing * 2.0))
            plotter.plotText(x: centre.x, y: yPos, text: csv.data[row][xtag], props: propsList.pieLegend)
        }
    }
}

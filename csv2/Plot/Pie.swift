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
                            .closePath
                        ]
                    )
                    // Don't fill negative slices
                    if val >= 0.0 {
                        plotter.plotPath(path, styles: stylesList.plots[col], fill: true)
                    }
                    plotter.plotPath(path, styles: stylesList.plots[col], fill: false)
                }

                // add the label
                if radius * angle6/1.0e6 > sizes.pieLabel.spacing {
                    let mid = (start + end)/2.0
                    let pi = Double.pi
                    var offset: Double
                    var align: String

                    switch mid {
                    // bottom
                    case (pi * 0.375)..<(pi * 0.625):
                        offset = radius + sizes.pieLabel.spacing
                        align = "middle"
                    // left
                    case (pi * 0.625)..<(pi * 1.875):
                        offset = radius + sizes.pieLabel.size
                        align = "end"
                    // top
                    case (pi * 2.375)..<(pi * 2.625):
                        offset = radius // + sizes.pieLabel.spacing * 0.125
                        align = "middle"
                    // right
                    default:
                        offset = radius + sizes.pieLabel.size
                        align = "start"
                    }
                    let labelVector = Vector(length: offset, angle: -mid)
                    let labelPos = centre + labelVector
                    let labelVal = angle6/pi2e6 * 100
                    let labelText = "\(labelVal.f(0))%"
                    var labelStyles = stylesList.pieLabel
                    labelStyles.textAlign = align
                    plotter.plotText(x: labelPos.x, y: labelPos.y, text: labelText, styles: labelStyles)
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

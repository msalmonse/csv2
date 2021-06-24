//
//  PlotPie.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-26.
//

import Foundation

extension Plot {

    /// Draw the circle at the centre of the plot and a ring around the outside
    /// - Parameters:
    ///   - centre: centre of the plot
    ///   - radius: radius of the plot

    private func circleRing(centre: Point, radius: Double) {
        var styles = Styles.from(settings: settings)
        styles.fill = .black
        styles.colour = .black
        styles.cssClass = "black"
        styles.strokeWidth = 1.0
        // let centrePath = Path([.moveTo(xy: centre), .circle(r: 4.0)])
        // plotter.plotPath(centrePath, styles: styles, fill: true)
        let ringPath = Path(
            [
                .arcAround(centre: centre, radius: radius, start: 0.0, end: Double.pi, cw: true, onPath: false),
                .arcAround(
                    centre: centre, radius: radius, start: Double.pi, end: Double.pi * 2.0,
                    cw: true, onPath: false
                )
            ]
        )
        plotter.plotPath(ringPath, styles: styles, fill: false)
    }

    /// Add a label to a slice
    /// - Parameters:
    ///   - centre: centre of the slice
    ///   - radius: radius of the slice
    ///   - mid: middle angle of the slice
    ///   - percent: percentage of the total

    private func sliceLabel(centre: Point, radius: Double, mid: Double, percent: Double) {
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
        let labelVector = Vector(length: offset, angle: mid)
        let labelPos = centre + labelVector
        let labelText = "\(percent.f(1))%"
        var labelStyles = stylesList.pieLabel
        labelStyles.textAlign = align
        labelStyles.cssClass! += " " + align
        plotter.plotText(x: labelPos.x, y: labelPos.y, text: labelText, styles: labelStyles)
    }

    /// Plot a pie chart for a row of data
    /// - Parameters:
    ///   - row: csv row number
    ///   - col1: first column to plot
    ///   - centre: centre of the circle
    ///   - radius: circle's radius

    func plotOnePie(_ row: Int, _ col1: Int, centre: Point, radius: Double) {
        let pi2e6 = Double.pi * 2.0e6       // 2πe6
        let pieLabel = settings.boolValue(.pieLabel)
        let insideRadius = max(radius / 5.0, strokeWidth * 3.0)
        var arcLeft = pi2e6
        var start = 0.0

        let pieValues = csv.rowValues(row)
        var sum = pieValues[col1...].reduce(0.0) { $0 + abs($1 ?? 0) }
        let total = sum.f(0)
        for col in pieValues.indices where col >= col1 {
            if let val = pieValues[col] {
                let absVal = abs(val)
                let angle6 = min(round(arcLeft * absVal / sum), arcLeft)
                sum -= absVal
                arcLeft -= angle6
                let end = start + angle6 / 1.0e6
                // Don't plot tiny slices
                if radius * angle6 / 1.0e6 > strokeWidth {
                    let path = Path(
                        [
                            .arcAround(
                                centre: centre, radius: radius, start: start, end: end,
                                cw: true, onPath: false
                            ),
                            .arcAround(
                                centre: centre, radius: insideRadius, start: end, end: start,
                                cw: false, onPath: true
                            ),
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
                if  pieLabel && radius * angle6 / 1.0e6 > sizes.pieLabel.spacing {
                    let mid = (start + end) / 2.0
                    let percent = angle6 / pi2e6 * 100.0
                    sliceLabel(centre: centre, radius: radius, mid: mid, percent: percent)
                }

                start = end
            }
        }

        // Now draw a black ring in the middle
        circleRing(centre: centre, radius: insideRadius)
        // and one on the outside
        circleRing(centre: centre, radius: radius)

        let xtag = settings.intValue(.xTagsHeader)
        var yPos =
            ceil(min(positions.xTagsY, centre.y + radius + sizes.pieLegend.spacing + sizes.pieLabel.spacing))
        if xtag >= 0, csv.data[row].hasIndex(xtag) {
            let text = csv.data[row][xtag]
            plotter.plotText(x: centre.x, y: yPos, text: text, styles: stylesList.pieLegend)
            yPos += sizes.pieSubLegend.spacing
        }
        if settings.boolValue(.pieSubLegend) {
            let text = settings.stringValue(.pieSubLegendPrefix) + total + settings.stringValue(.pieSubLegendSuffix)
            plotter.plotText(x: centre.x, y: yPos, text: text, styles: stylesList.pieSubLegend)
        }
    }

    func plotPies() {
        /// Calculate the margin on the left of the plot area
        /// - Returns: margin

        func leftMargin(_ ct: Int) -> Double {
            let free = plotPlane.width - Double(ct) * side
            return floor(free / 2.0)
        }

        /// Calculate the margin at the top of the plot area
        /// - Returns: margin

        func topMargin() -> Double {
            let free = plotPlane.height - rows * side
            return floor(free / 2.0)
        }

        let row1 = settings.intValue(.headerRows)
        let pieCt = csv.rowCt - row1

        // calculate the size of the squares that can fit in plotPlane
        // cols for number of columns, rows for number of rows and side for side of square
        // cols * side <= width
        // rows * side <= height
        // rows * cols >= count
        // rows² <= count * height/width
        var rows = ceil(sqrt(Double(pieCt) * plotPlane.height / plotPlane.width))
        let side = floor(plotPlane.height / rows)
        let cols = floor(plotPlane.width / side)
        if cols * (rows - 1) >= Double(pieCt) {
            rows -= 1
        }

        let maxRadiusX = side - sizes.pieLabel.size * 4.0
        let maxRadiusY = side - sizes.pieLabel.spacing * 2.0
        let radius = floor(min(maxRadiusX, maxRadiusY) * 0.4)

        var rowY = topMargin() - side / 2.0
        var colX = 0.0

        let colsPerRow = Int(cols)
        for row in row1..<csv.rowCt {
            // time for a new row?
            if ((row - row1) % colsPerRow) == 0 {
                rowY += side
                colX = leftMargin(min(colsPerRow, csv.rowCt - row)) + side / 2.0
            }
            let centre = Point(x: colX, y: rowY)
            plotOnePie(row, settings.intValue(.headerColumns), centre: centre, radius: radius)
            colX += side
        }

    }
}

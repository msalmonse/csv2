//
//  SvgColumnPlot.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-23.
//

import Foundation

extension SVG {
    
    /// Calculate a list of x values, either a range or a data column
    /// - Returns: list of x values
    func xList() -> [Double?] {
        if index < 0 {
            return (settings.headerRows..<csv.data.count).map { Double($0) }
        } else {
            return csv.columnValues(index)
        }
        
    }

    /// Plot the non-index and non header columns
    /// - Parameter ts: a TransScale object
    /// - Returns: An array of the path elements for the columns

    func columnPlot(_ ts: TransScale) -> [String] {
        var paths: [String] = []

        let xValues = xList()
        for i in 0..<csv.colCt {
            if i != index {
                var pathPoints: [PathCommand] = []
                let yValues = csv.columnValues(i)
                var move = true
                for j in 0..<csv.rowCt {
                    if xValues[j] == nil || yValues[j] == nil {
                        move = true
                    } else if move {
                        let xPos = ts.xpos(xValues[j]!)
                        let yPos = ts.ypos(yValues[j]!)
                        pathPoints.append(.moveTo(x: xPos, y: yPos))
                        move = false
                    } else {
                        let xPos = ts.xpos(xValues[j]!)
                        let yPos = ts.ypos(yValues[j]!)
                        pathPoints.append(.lineTo(x: xPos, y: yPos))
                    }
                }
                paths.append(Self.svgPath(pathPoints))
            }
        }
        return paths
    }
}

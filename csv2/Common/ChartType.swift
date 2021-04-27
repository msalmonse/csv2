//
//  ChartType.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-27.
//

import Foundation

enum ChartType {
    case
        horizontal,        // normal
        pieChart,
        vertical           // Not implemented
}

extension ChartType {
    /// Select the type of Positions based on ChartType
    /// - Parameter settings: image settings
    /// - Returns: Positions object

    func positionsSelect(_ settings: Settings) -> Positions {
        switch self {
        case .horizontal: return Horizontal(settings)
        case .pieChart: return PieChart(settings)
        case .vertical: return Horizontal(settings)
        }
    }
}

extension ChartType {
    func dataPlane(_ csv: CSV, _ settings: Settings) -> Plane {
        switch self {
        case .horizontal: return Sides.fromData(csv, settings)
        case .pieChart:
            return Plane(left: -0.5, top: 2.0, height: -2, width: csv.rowCt - settings.csv.headerRows)
        default: return Plane(top: 0.0, bottom: 0.0, left: 0.0, right: 0.0)
        }
    }
}

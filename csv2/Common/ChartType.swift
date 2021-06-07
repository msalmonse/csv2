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
        case .vertical: return Vertical(settings)
        }
    }
}

extension ChartType {
    func dataPlane(_ csv: CSV, _ settings: Settings) -> Plane {
        switch self {
        case .horizontal: return Sides.fromDataHorizontal(csv, settings)
        case .pieChart:
            return Plane(left: -0.5, top: 2.0, height: -2, width: csv.rowCt - settings.intValue(.headerRows))
        case .vertical: return Sides.fromDataVertical(csv, settings)
        }
    }
}

extension ChartType {
    func plotCount(_ csv: CSV) -> Int {
        switch self {
        case .horizontal: return csv.rowCt
            // For a piechart we treat each column as its own plot grouped by rows as a pie
        case .pieChart: return csv.colCt
        case .vertical: return csv.colCt
        }
    }
}

extension ChartType {
    func plotFirst(_ settings: Settings) -> Int {
        switch self {
        case .horizontal: return settings.intValue(.headerRows)
        case .pieChart: return settings.intValue(.headerColumns)
        case .vertical: return settings.intValue(.headerColumns)
        }
    }
}

extension ChartType {
    func nameInRows() -> Bool {
        switch self {
        case .horizontal: return false
        case .pieChart: return true
        case .vertical: return true
        }
    }
}

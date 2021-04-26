//
//  PositionsSelect.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-26.
//

import Foundation

/// Select a Positions type corresponding with the ChartType
/// - Parameters:
///   - chartType: type of chart
///   - settings: chart settings
/// - Returns: Appropriate Positions

func positionsSelect(_ chartType: ChartType, _ settings: Settings) -> Positions {
    switch chartType {
    case .horizontal: return Horizontal(settings)
    case .pieChart: return PieChart(settings)
    case .vertical: return Horizontal(settings)
    }
}

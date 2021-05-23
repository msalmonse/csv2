//
//  Bitmap.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-21.
//

import Foundation

/// Convert a list of integers into a bitmap
/// - Parameter plots: list of plot numbers
/// - Returns: bitmap

func bitmap(_ plots: [String]) -> Int {
    var result = 0

    for plot in plots {
        if let i = Int(plot) {
            if (1...63).contains(i) { result |= 1 << (i - 1) }
        }
    }

    return result
}

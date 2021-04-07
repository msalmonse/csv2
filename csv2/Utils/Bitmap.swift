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

func bitmap(_ plots: [Int]) -> Int {
    var result = 0

    for i in plots where i > 0 && i < 64 {
        result |= 1 << (i - 1)
    }
    return result
}

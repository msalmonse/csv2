//
//  Double.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-02.
//

import Foundation

extension Double {

    /// Format a Double in exponential format
    /// - Parameter precision: the number of digits after the point
    /// - Returns: Formatted string

    func e(_ precision: Int) -> String {
        return String(format: "%.*e", precision, self)
    }

    /// Format a Double in fixed point format
    /// - Parameter precision: the number of digits after the point
    /// - Returns: Formatted string

    func f(_ precision: Int) -> String {
        return String(format: "%.*f", precision, self)
    }

    /// Format a Double in "g" format
    /// - Parameter precision: the number of digits after the point
    /// - Returns: Formatted string

    func g(_ precision: Int) -> String {
        return String(format: "%.*g", precision, self)
    }
}

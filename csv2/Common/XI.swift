//
//  XI.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-15.
//

import Foundation

/// Struct to save a value and an index into another array

struct XIvalue: Comparable, Equatable {
    let x: Double?
    let i: Int

    static func == (lhs: XIvalue, rhs: XIvalue) -> Bool {
        if lhs.x == nil || rhs.x == nil { return lhs.i == rhs.i }
        return lhs.x! == rhs.x!
    }

    static func < (lhs: XIvalue, rhs: XIvalue) -> Bool {
        if lhs.x == nil || rhs.x == nil { return lhs.i < rhs.i }
        return lhs.x! < rhs.x!
    }
}

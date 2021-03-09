//
//  ReflectedStringConvertable.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-09.
//  From: https://medium.com/swift-programming/struct-style-printing-of-classes-in-swift-7ee34f1c975a

import Foundation

public protocol ReflectedStringConvertible: CustomStringConvertible { }

extension ReflectedStringConvertible {
    public var description: String {
        let mirror = Mirror(reflecting: self)

        var str = "\(mirror.subjectType)("
        var first = true
        for (label, value) in mirror.children {
            if let label = label {
                if first {
                    first = false
                } else {
                    str += ", "
                }
                str += label
                str += ": "
                str += "\(value)"
            }
        }
        str += ")"

        return str
    }
}

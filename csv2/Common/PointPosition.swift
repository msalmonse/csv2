//
//  PointPosition.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-01.
//

import Foundation

extension Plane {

    /// Position relative to a plane

    struct PointPosition: OptionSet {
        let rawValue: Int8

        static let above = PointPosition(rawValue: 1 << 0)
        static let below = PointPosition(rawValue: 1 << 1)
        static let left = PointPosition(rawValue: 1 << 2)
        static let right = PointPosition(rawValue: 1 << 3)

        var isInside: Bool { isEmpty }

        /// Have we traversed the plane?
        /// - Parameter other: the othe end of our path
        /// - Returns: truse if we have traversed the plane

        func hasTraversed(_ other: PointPosition) -> Bool {
            if isInside || other.isInside { return false }
            if contains(.above) && other.contains(.below) { return true }
            if contains(.below) && other.contains(.above) { return true }
            if contains(.left) && other.contains(.right) { return true }
            if contains(.right) && other.contains(.left) { return true }
            if contains(.left) && other.contains(.right) { return true }
            return false
        }

        subscript(_ index: Self) -> Bool {
            get { contains(index) }
            set(newValue) { if newValue { insert(index) } else { remove(index) } }
        }
    }

    /// Calculate position of a point
    /// - Parameter point: Point to check
    /// - Returns: position

    func position(_ point: Point) -> PointPosition {
        var relativePosition = PointPosition()

        if left < right {
            switch point.x {
            case ..<left: relativePosition[.left] = true
            case left...right: break
            default: relativePosition[.right] = true
            }
        } else {
            switch point.x {
            case ..<right: relativePosition[.right] = true
            case right...left: break
            default: relativePosition[.left] = true
            }
        }

        if top < bottom {
            switch point.y {
            case ..<top: relativePosition[.above] = true
            case top...bottom: break
            default: relativePosition[.below] = true
            }
        } else {
            switch point.y {
            case ..<bottom: relativePosition[.below] = true
            case bottom...top: break
            default: relativePosition[.above] = true
            }
        }

        return relativePosition
    }
}

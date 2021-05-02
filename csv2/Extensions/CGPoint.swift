//
//  CGPoint.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-02.
//

import Foundation

extension CGPoint {
    static func + (left: CGPoint, right: CGVector) -> CGPoint {
        return CGPoint(x: left.x + right.dx, y: left.y + right.dy)
    }

    static func += (left: inout CGPoint, right: CGVector) {
        left = CGPoint(x: left.x + right.dx, y: left.y + right.dy)
    }
}

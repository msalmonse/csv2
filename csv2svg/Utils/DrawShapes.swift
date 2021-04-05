//
//  DrawShapes.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-11.
//

import Foundation

extension PathCommand {

    /// Generate a blade shape
    /// - Parameter w: the width
    /// - Returns: path string for a blade

    func drawBlade(w: Double) -> String {
        let half = w/2.0
        return [
            Self.moveBy(dx: -half, dy: half/2.0),
            .lineBy(dx: -half, dy: -w),
            .vertBy(dy: -half),
            .horizBy(dx: half),
            .lineBy(dx: w, dy: w),
            .lineBy(dx: half, dy: w),
            .vertBy(dy: half),
            .horizBy(dx: -half),
            .lineBy(dx: -w, dy: -w),
            .moveBy(dx: half, dy: -half/2.0)
        ].map { $0.command()}.joined(separator: " ")
    }

    /// Generate a circle
    /// - Parameter r: the radius
    /// - Returns: path string for a circle

    func drawCircle(r: Double) -> String {
        return [
            Self.moveBy(dx: 0, dy: -r),
            .arc(rx: r, ry: r, rot: 0, type: ArcType.longIn, dx: 0.0, dy: 2 * r),
            .arc(rx: r, ry: r, rot: 0, type: ArcType.longIn, dx: 0.0, dy: -2 * r),
            .moveBy(dx: 0, dy: r)
        ].map { $0.command() }.joined(separator: " ")
    }

    /// Generate a stared circle
    /// - Parameter r: the radius
    /// - Returns: path string for a circle

    func drawCircleStar(w: Double) -> String {
        return drawStar(w: w) + drawCircle(r: w)
    }

    /// Generate a cross shape
    /// - Parameter w: the width
    /// - Returns: path string for a cross

    func drawCross(w: Double) -> String {
        let full = w * 0.4
        let half = full * 0.5
        return [
            Self.moveBy(dx: -full - half, dy: 0.0),
            // left
            .lineBy(dx: -full, dy: -half),
            .vertBy(dy: full),
            .lineBy(dx: full, dy: -half),
            .moveBy(dx: full + half, dy: -full - half),
            // top
            .lineBy(dx: -half, dy: -full),
            .horizBy(dx: full),
            .lineBy(dx: -half, dy: full),
            .moveBy(dx: full + half, dy: full + half),
            // right
            .lineBy(dx: full, dy: -half),
            .vertBy(dy: full),
            .lineBy(dx: -full, dy: -half),
            .moveBy(dx: -full - half, dy: full + half),
            // bottom
            .lineBy(dx: -half, dy: full),
            .horizBy(dx: full),
            .lineBy(dx: -half, dy: -full),
            .moveBy(dx: 0.0, dy: -full)
        ].map { $0.command() }.joined(separator: " ")
    }

    /// Generate a diamond shape
    /// - Parameter w: the width
    /// - Returns: path string for a diamond

    func drawDiamond(w: Double) -> String {
        let half = w * 0.625
        let full = half + half
        return [
            Self.moveBy(dx: -full, dy: 0.0),
            .lineBy(dx: full, dy: -full),
            .lineBy(dx: full, dy: full),
            .lineBy(dx: -full, dy: full),
            .lineBy(dx: -full, dy: -full),
            .lineBy(dx: half, dy: -half),
            .moveBy(dx: half, dy: half)
        ].map { $0.command() }.joined(separator: " ")
    }

    /// Generate a shuriken shape
    /// - Parameter w: the width
    /// - Returns: path string for a shuriken

    func drawShuriken(w: Double) -> String {
        let half = w/2.0
        return [
            Self.moveBy(dx: -half, dy: -half),
            .lineBy(dx: -half, dy: -half), .horizBy(dx: half), .lineBy(dx: w, dy: half),
            .lineBy(dx: half, dy: -half), .vertBy(dy: half), .lineBy(dx: -half, dy: w),
            .lineBy(dx: half, dy: half), .horizBy(dx: -half), .lineBy(dx: -w, dy: -half),
            .lineBy(dx: -half, dy: half), .vertBy(dy: -half), .lineBy(dx: half, dy: -w)
,            .moveBy(dx: half, dy: half)
        ].map { $0.command() }.joined(separator: " ")
    }

    /// Generate a square
    /// - Parameter w: the width
    /// - Returns: path string for a square

    func drawSquare(w: Double) -> String {
        let w2 = w * 2.0
        return [
            Self.moveBy(dx: -w, dy: -w),
            .horizBy(dx: w2),
            .vertBy(dy: w2),
            .horizBy(dx: -w2),
            .vertBy(dy: -w2),
            .horizBy(dx: w),
            .moveBy(dx: 0.0, dy: w)
        ].map { $0.command() }.joined(separator: " ")
    }

    /// Generate a star shape
    /// - Parameter w: the width
    /// - Returns: path string for a star

    func drawStar(w: Double) -> String {
        let half = w/2.0
        return [
            Self.moveBy(dx: -half, dy: 0.0),
            .lineBy(dx: -half, dy: -w), .lineBy(dx: w, dy: half),
            .lineBy(dx: w, dy: -half), .lineBy(dx: -half, dy: w),
            .lineBy(dx: half, dy: w), .lineBy(dx: -w, dy: -half),
            .lineBy(dx: -w, dy: half), .lineBy(dx: half, dy: -w),
            .moveBy(dx: half, dy: 0.0)
        ].map { $0.command() }.joined(separator: " ")
    }

    /// Generate a triangle
    /// - Parameter w: the width
    /// - Returns: path string for a triangle

    func drawTriangle(w: Double) -> String {
        let w2 = w * 2.0
        let half = w/2.0
        return [
            Self.moveBy(dx: 0.0, dy: -w),
            .lineBy(dx: w, dy: w2),
            .horizBy(dx: -w2),
            .lineBy(dx: w, dy: -w2),
            .lineBy(dx: half, dy: w),
            .moveBy(dx: -half, dy: 0.0)
        ].map { $0.command() }.joined(separator: " ")
    }
}

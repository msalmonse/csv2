//
//  Plotter.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-05.
//

import Foundation

/// The actual plotter used by the abstarct Plot class

protocol Plotter {
    func plotClipStart(clipPlane: Plane)
    func plotClipEnd()
    func plotHead(positions: Positions, clipPlane: Plane, stylesList: StylesList)
    func plotPath(_ path: Path, styles: Styles, fill: Bool)
    func plotPrint()
    func plotTail()
    func plotText(x: Double, y: Double, text: String, styles: Styles)
    func plotWrite(to url: URL) throws
}

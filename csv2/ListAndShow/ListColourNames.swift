//
//  ListColourNames.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-22.
//

import Foundation

struct ListColourNames: Plotter {

    func colourNames() -> String {
        return ColourTranslate.all.map { "\($0): \(ColourTranslate.lookup($0)!.hashRGBA)" }.joined(separator: "\n")
    }

    func plotClipStart(plotPlane: Plane) { return }

    func plotClipEnd() { return }

    func plotHead(positions: Positions, plotPlane: Plane, stylesList: StylesList) { return }

    func plotPath(_ path: Path, styles: Styles, fill: Bool) { return }

    func plotPrint() {
        print( colourNames() )
    }

    func plotTail() { return }

    func plotText(x: Double, y: Double, text: String, styles: Styles) { return }

    func plotWrite(to url: URL) throws { return }
}

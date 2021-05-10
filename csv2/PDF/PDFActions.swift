//
//  PDFActions.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-10.
//

import Foundation

enum PDFActions {
    case
        clipStart(plotPlane: Plane),
        clipEnd,
        head(positions: Positions, plotPlane: Plane, stylesList: StylesList),
        plot(path: Path, styles: Styles, fill: Bool),
        tail,
        text(x: Double, y: Double, text: String, styles: Styles)
}

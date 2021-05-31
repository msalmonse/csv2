//
//  PDFActions.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-10.
//

import Foundation

enum PDFActions {
    case
        // set background colour
        bg(colour: CGColor),
        // start clipping
        clipStart(clipPlane: Plane),
        // end clipping
        clipEnd,
        // draw a logo
        logo(logoPlane: Plane, from: String),
        // plot a path
        plot(path: Path, styles: Styles, fill: Bool),
        // write a text
        text(x: Double, y: Double, text: String, styles: Styles)
}

//
//  PDFPlotter.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-09.
//

import Foundation

extension PDF {
    func plotClipStart(clipPlane: Plane) {
        page.add(action: .clipStart(clipPlane: clipPlane))
    }

    func plotClipEnd() {
        page.add(action: .clipEnd)
    }

    func plotHead(positions: Positions, clipPlane: Plane, stylesList: StylesList) {
        let logoURL = settings.stringValue(.logoURL)
        if settings.stringValue(.logoURL).hasContent {
            let logoPlane = Plane(
                left: positions.logoX, top: positions.logoY,
                height: settings.doubleValue(.logoHeight),
                width: settings.doubleValue(.logoWidth)
            )
            page.add(action: .logo(logoPlane: logoPlane, from: logoURL))
        }
    }

    func plotPath(_ path: Path, styles: Styles, fill: Bool) {
        page.add(action: .plot(path: path, styles: styles, fill: fill))
    }

    func plotPrint() {
        return
    }

    func plotTail() { return }

    func plotText(x: Double, y: Double, text: String, styles: Styles) {
        page.add(action: .text(x: x, y: y, text: text, styles: styles))
    }

    func plotWrite(to url: URL) throws {
        if let data = doc.dataRepresentation() {
            try data.write(to: url)
        }
        let tagFile = settings.stringValue(.tagFile)
        if tagFile.hasContent {
            let w = settings.intValue(.width) + 6
            let h = settings.intValue(.height) + 6
            let source = url.lastPathComponent
            let tagURL = URL(fileURLWithPath: tagFile)

            if let tag = """
                <object type="application/pdf" data="\(source)" width="\(w)" height="\(h)"></object>
                """.data(using: .utf8) {
                try tag.write(to: tagURL)
            } else {
                print("Error creating tag data", to: &standardError)
            }
        }
    }
}

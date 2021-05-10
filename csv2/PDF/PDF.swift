//
//  PDF.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-09.
//

import Foundation
import PDFKit

class PDF: Plotter {
    let settings: Settings
    let doc: PDFDocument
    let page: PDFPlotterPage

    init(_ settings: Settings) {
        self.settings = settings
        doc = PDFDocument()
        page = PDFPlotterPage()
        doc.insert(page, at: 0)
        let box = NSRect(x: 0, y: 0, width: settings.dim.width, height: settings.dim.height)
        page.setBounds(box, for: .mediaBox)

        if let bg = RGBAu8(settings.css.backgroundColour) {
            page.add(action: .bg(colour: bg.cgColor))
        }
    }
}

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
    }
}

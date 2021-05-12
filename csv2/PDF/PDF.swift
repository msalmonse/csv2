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
        doc.setAttributes(from: settings)

        page = PDFPlotterPage()
        doc.insert(page, at: 0)

        let box = NSRect(x: 0, y: 0, width: settings.dim.width, height: settings.dim.height)
        page.setBounds(box, for: .mediaBox)

        if let bg = RGBAu8(settings.css.backgroundColour) {
            page.add(action: .bg(colour: bg.cgColor))
        }
    }
}

extension PDFDocument {
    func setAttributes(from settings: Settings) {

        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "'D:'yyyyMMddHHmmSSX"
        let creationDate = formatter.string(from: now)

        documentAttributes?[PDFDocumentAttribute.creationDateAttribute] = creationDate
        documentAttributes?[PDFDocumentAttribute.creatorAttribute] = settings.comment

        if let author = settings.pdf.author {
            documentAttributes?[PDFDocumentAttribute.authorAttribute] = author
        }

        if let keywords = settings.pdf.keywords {
            documentAttributes?[PDFDocumentAttribute.keywordsAttribute] = keywords
        }

        if let subject = settings.pdf.subject {
            documentAttributes?[PDFDocumentAttribute.subjectAttribute] = subject
        }

        if let title = settings.pdf.title {
            documentAttributes?[PDFDocumentAttribute.titleAttribute] = title
        } else if settings.plotter.title.hasContent {
            documentAttributes?[PDFDocumentAttribute.titleAttribute] = settings.plotter.title
        }
    }
}

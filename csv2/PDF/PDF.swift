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

        let box = NSRect(x: 0, y: 0, width: settings.intValue(.width), height: settings.intValue(.height))
        page.setBounds(box, for: .mediaBox)

        if let bg = settings.colourValue(.backgroundColour) {
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

        let author = settings.stringValue(.author, in: .pdf)
        if author.hasContent {
            documentAttributes?[PDFDocumentAttribute.authorAttribute] = author
        }

        let keywords = settings.stringValue(.keywords, in: .pdf)
        if keywords.hasContent {
            documentAttributes?[PDFDocumentAttribute.keywordsAttribute] = keywords
        }

        let subject = settings.stringValue(.subject, in: .pdf)
        if subject.hasContent {
            documentAttributes?[PDFDocumentAttribute.subjectAttribute] = subject
        }

        var title = settings.stringValue(.title, in: .pdf)
        if title.isEmpty { title = settings.stringValue(.title) }
        if title.hasContent {
            documentAttributes?[PDFDocumentAttribute.titleAttribute] = title
        }
    }
}

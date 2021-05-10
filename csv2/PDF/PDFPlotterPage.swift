//
//  PDFPlotterPage.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-10.
//

import Foundation
import PDFKit

class PDFPlotterPage: PDFPage {
    var actions: [PDFActions] = []

    override init() {
        super.init()
    }

    override func draw(with box: PDFDisplayBox, to context: CGContext) {
        print(box, to: &standardError)
    }

    func add(action: PDFActions) { actions.append(action) }
}

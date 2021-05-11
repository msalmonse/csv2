//
//  PDFsettings.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-11.
//

import Foundation

extension Settings {
    struct PDF {
        // see PDFDocumentAttribute for meanings
        let author: String?
        let keywords: String?
        let producer: String?
        let subject: String?
        let title: String?
    }

    static func jsonPDF(from container: KeyedDecodingContainer<CodingKeys>?, defaults: Defaults) -> PDF {
        return PDF(
            author: optionalKeyedStringValue(from: container, forKey: .author),
            keywords: optionalKeyedStringValue(from: container, forKey: .keywords),
            producer: optionalKeyedStringValue(from: container, forKey: .producer),
            subject: optionalKeyedStringValue(from: container, forKey: .subject),
            title: optionalKeyedStringValue(from: container, forKey: .title)
        )
    }
}

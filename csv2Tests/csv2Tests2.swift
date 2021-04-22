//
//  csv2Tests2.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-22.
//

import XCTest
@testable import csv2

extension csv2Tests {
    func testLookup() {
        XCTAssertEqual(ColourTranslate.lookup("#12345678", or: .clear), RGBAu8(r: 18, g: 52, b: 86, a: 120))
        XCTAssertEqual(ColourTranslate.lookup("#123456", or: .clear), RGBAu8(r: 18, g: 52, b: 86, a: 255))
        XCTAssertEqual(ColourTranslate.lookup("#123", or: .clear), RGBAu8(r: 17, g: 34, b: 51, a: 255))
        XCTAssertNil(ColourTranslate.lookup("#123456789"))

        XCTAssertEqual(ColourTranslate.lookup("rgb(1,2,3)"), RGBAu8(r: 1, g: 2, b: 3, a: 255))
        XCTAssertEqual(ColourTranslate.lookup("rgba(1,2,3,0.4)"), RGBAu8(r: 1, g: 2, b: 3, a: 102))
    }
}

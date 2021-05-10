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
        XCTAssertEqual(ColourTranslate.lookup("black")!, .black)
        XCTAssertEqual(RGBAu8("clearblack"), RGBAu8(r: 0, g: 0, b: 0, a: 127))
        XCTAssertEqual(RGBAu8("clear-black"), RGBAu8(r: 0, g: 0, b: 0, a: 127))
        XCTAssertEqual(RGBAu8("clear-clear-black"), RGBAu8(r: 0, g: 0, b: 0, a: 63))

        XCTAssertEqual(RGBAu8("#12345678", or: .clear), RGBAu8(r: 18, g: 52, b: 86, a: 120))
        XCTAssertEqual(RGBAu8("#123456", or: .clear), RGBAu8(r: 18, g: 52, b: 86, a: 255))
        XCTAssertEqual(RGBAu8("#123a", or: .clear), RGBAu8(r: 17, g: 34, b: 51, a: 170))
        XCTAssertEqual(RGBAu8("#123", or: .clear), RGBAu8(r: 17, g: 34, b: 51, a: 255))
        XCTAssertNil(RGBAu8("#123456789"))

        XCTAssertEqual(RGBAu8("RGB( 1,2, 3)"), RGBAu8(r: 1, g: 2, b: 3, a: 255))
        XCTAssertEqual(RGBAu8("rgba(1 ,2,3,0. )"), RGBAu8(r: 1, g: 2, b: 3, a: 0))
        XCTAssertEqual(RGBAu8("rgba(1, 2,3 , 1.)"), RGBAu8(r: 1, g: 2, b: 3, a: 255))
        XCTAssertEqual(RGBAu8("rgba(1,2 ,3,0.4)"), RGBAu8(r: 1, g: 2, b: 3, a: 102))
        XCTAssertEqual(RGBAu8("rgba(1,2,3, 4)"), RGBAu8(r: 1, g: 2, b: 3, a: 4))
        XCTAssertNil(RGBAu8("rgba(1,2,3,1.000001)"))
    }

    func testDoIf() {
        var val = 5
        doIf(true) { val += 1 }
        XCTAssertEqual(val, 6)
        doIf(false) { val += 1 }
        XCTAssertEqual(val, 6)
    }

    func testOptionSet() {
        var options = PlotOptions()

        XCTAssertFalse(options[.bold])
        options[.bold] = true
        XCTAssertFalse((options & .pointed)[.bold])
        XCTAssertTrue(options[.bold])

        options[.pointed] = true
        XCTAssertTrue(options.isAny(of: [.bold, .italic]))
        XCTAssertFalse(options.isAny(of: [.italic, .scattered]))
        XCTAssertTrue(options.isAll(of: [.bold, .pointed]))
        XCTAssertFalse(options.isAll(of: [.bold, .pointed, .italic]))
        XCTAssertFalse(options.isOnly([.bold]))
        XCTAssertTrue((options & .bold).isOnly([.bold]))
    }

    func testPDF() {
        let settings = try? Settings.load(settingsJSON(true))
        let pdf = PDF(settings!)
        XCTAssertNotNil(pdf.doc.dataRepresentation())
        let string = pdf.doc.string
        XCTAssertNotNil(string)
    }
}

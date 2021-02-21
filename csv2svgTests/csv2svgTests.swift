//
//  csv2svgTests.swift
//  csv2svgTests
//
//  Created by Michael Salmon on 2021-02-21.
//

import XCTest
@testable import csv2svg

class csv2svgTests: XCTestCase {

    func testSettings() throws {
        let tmpJson = FileManager.default.temporaryDirectory.appendingPathComponent("test.json")
        do {
            try settingsJSON.write(to: tmpJson, atomically: true, encoding: .utf8)
        } catch {
            XCTFail("Error writing to file: \(error)")
            return
        }

        let settings = try? Settings.load(tmpJson.path)
        
        XCTAssertNotNil(settings)
        XCTAssertEqual(settings!.index, 1)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}

let settingsJSON = """
{
    "index": 1,
    "height": 499,
    "width": 501,
    "title": "Test title"
}
"""

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
        XCTAssertEqual(settings!.index, testIndex)
        XCTAssertEqual(settings!.height, testHeight)
        XCTAssertEqual(settings!.title, testTitle)
        XCTAssertEqual(settings!.width, testWidth)
        XCTAssertNil(settings!.xMax)
        XCTAssertEqual(settings!.yMax, testYMax)
    }

    func testCSV() throws {
        let tmpCsv = FileManager.default.temporaryDirectory.appendingPathComponent("test.csv")
        do {
            try csvData.write(to: tmpCsv, atomically: true, encoding: .utf8)
        } catch {
            XCTFail("Error writing to file: \(error)")
            return
        }

        let csv = try? CSV(tmpCsv.path)
        
        XCTAssertNotNil(csv)
        XCTAssertEqual(csv!.data.count, 4)
        for row in csv!.data {
            XCTAssertEqual(row.count, 4)
        }
        
        let (min, max) = csv!.columnMinMax(3)
        XCTAssertEqual(min, 110.1)
        XCTAssertEqual(max, 5220.6)
    }

    func testSettingsPerformance() throws {
        measure {
            try? testSettings()
        }
    }
    
    func testCSVperformance() throws {
        measure {
            try? testCSV()
        }
    }

}

// Values for JSON tests
let testIndex = 1
let testHeight = 499
let testTitle = "Test title"
let testWidth = 501
let testYMax = 25000.25

// JSON string for tests
let settingsJSON = """
{
    "index": \(testIndex),
    "height": \(testHeight),
    "width": \(testWidth),
    "title": "\(testTitle)",
    "yMax": \(testYMax)
}
"""

// CSV string for tests
let csvData = """
n,Array,Iterative,Recursive
1,100.1,120.4,110.1
9,100.1,129.9,5220.6
32,100.1,152.7,
"""

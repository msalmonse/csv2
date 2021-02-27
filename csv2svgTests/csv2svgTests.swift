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
        let settings = try? Settings.load(settingsJSON)
        
        XCTAssertNotNil(settings)
        XCTAssertEqual(settings!.index, testIndex)
        XCTAssertEqual(settings!.height, testHeight)
        XCTAssertEqual(settings!.title, testTitle)
        XCTAssertEqual(settings!.width, testWidth)
        XCTAssertNil(settings!.xMax)
        XCTAssertEqual(settings!.yMax, testYMax)
    }

    func testCSV() throws {
        let csv = CSV(csvData)
    
        XCTAssertEqual(csv.data.count, 4)
        for row in csv.data {
            XCTAssertEqual(row.count, 4)
        }
        
        let (min, max) = csv.columnMinMax(3)
        XCTAssertEqual(min, -110.1)
        XCTAssertEqual(max, 5220.6)
    }
    
    func testSvgPath() {
        let path = SVG.svgPath(pathPoints)
        XCTAssertEqual(path, pathTag)
    }
    
    func testSvgSides() {
        let csv = CSV(csvData)
        var svg = try? SVG(csv, Settings.load(settingsJSON))
        XCTAssertNotNil(svg)
        XCTAssertEqual(svg!.edges.top, testYMax)
        XCTAssertEqual(svg!.edges.bottom, -110.1)
        XCTAssertEqual(svg!.edges.left, 1)
        XCTAssertEqual(svg!.edges.right, 32)
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
1,100.1,120.4,-110.1
9,100.1,129.9,5220.6
32,100.1,152.7,
"""

// SVG path
let pathPoints = [
    SVG.PathCommand.moveTo(x: 0, y: 1),
    SVG.PathCommand.lineTo(x: 1, y: 2),
    SVG.PathCommand.lineTo(x: 2, y: 4),
    SVG.PathCommand.horizTo(x: 3.0),
    SVG.PathCommand.vertTo(y: 8.0),
    SVG.PathCommand.moveTo(x: 4, y: 16),
    SVG.PathCommand.lineTo(x: 5, y: 32)
]

let pathTag = "<path d=\" M 0.0,1.0 L 1.0,2.0 L 2.0,4.0 H 3.0 V 8.0 M 4.0,16.0 L 5.0,32.0 \" />"

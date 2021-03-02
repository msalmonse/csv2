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
        XCTAssertEqual(settings?.colours.count, 3)
        XCTAssertEqual(settings!.index, testIndex)
        XCTAssertEqual(settings!.height, testHeight)
        XCTAssertEqual(settings!.names[1], testName)
        XCTAssertEqual(settings!.title, testTitle)
        XCTAssertEqual(settings!.width, testWidth)
        XCTAssertNil(settings!.xMax)
        XCTAssertEqual(settings!.yMax, testYMax)
    }

    func testCSV() throws {
        let csv = CSV(csvData)
    
        XCTAssertEqual(csv.data.count, 4)
        for row in csv.data {
            XCTAssertEqual(row.count, 5)
        }
        
        let (min, max) = csv.columnMinMax(3)
        XCTAssertEqual(min, -110.1)
        XCTAssertEqual(max, 5220.6)
    }
    
    func testSVG() throws {
        let csv = CSV(csvData)
        let svg = try? SVG(csv, Settings.load(settingsJSON))
        
        XCTAssertNotNil(svg)
        XCTAssertEqual(svg?.names[4], testName)
    }
    
    func testSvgPath() {
        let path = SVG.svgPath(pathPoints, stroke: "black")
        XCTAssertEqual(path, pathTag)
    }

    func testSvgTransScale() {
        let from = SVG.Plane(top: 1000, bottom: 0, left: -1000, right: 1000)
        let to = SVG.Plane(top: 0, bottom: 1000, left: 0, right: 1000)
        let ts = SVG.TransScale(from: from, to: to)

        XCTAssertEqual(ts.xpos(0), 500)
        XCTAssertEqual(ts.ypos(500), 500)

        XCTAssertEqual(ts.xpos(-1000), 0)
        XCTAssertEqual(ts.ypos(0), 1000)

        XCTAssertEqual(ts.xpos(1000), 1000)
        XCTAssertEqual(ts.ypos(1000), 0)
    }

    func testSvgSides() {
        let csv = CSV(csvData)
        let svg = try? SVG(csv, Settings.load(settingsJSON))
        XCTAssertNotNil(svg)
        XCTAssertEqual(svg!.dataEdges.top, testYMax)
        XCTAssertEqual(svg!.dataEdges.bottom, -110.1)
        XCTAssertEqual(svg!.dataEdges.left, 0)
        XCTAssertEqual(svg!.dataEdges.right, 32)
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
let testName = "Ozzymandis"
let testTitle = "Test title"
let testWidth = 501
let testYMax = 25000.25

// JSON string for tests
let settingsJSON = """
{
    "colours": [ "silver", "red", "green" ],
    "headerRows": 1,
    "index": \(testIndex),
    "height": \(testHeight),
    "names": [ "a", "\(testName)", "c" ],
    "width": \(testWidth),
    "title": "\(testTitle)",
    "yMax": \(testYMax)
}
"""

// CSV string for tests
let csvData = """
n,Array,Iterative,Recursive,"\(testName)"
1,100.1,120.4, -110.1,0.0
9,100.1,129.9,5220.6 ,0.0
32,100.1,152.7,,
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

let pathTag = """
<path d=" M 0.0,1.0 L 1.0,2.0 L 2.0,4.0 H 3.0 V 8.0 M 4.0,16.0 L 5.0,32.0 " style="stroke: black; fill: none" />
"""

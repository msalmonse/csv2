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
        var settings = try? Settings.load(settingsJSON(true))
        XCTAssertNotNil(settings)
        XCTAssertEqual(settings!.colours.count, 3)
        XCTAssertTrue(settings!.inColumns)
        XCTAssertFalse(settings!.inRows)
        XCTAssertFalse(settings!.rowGrouping)
        XCTAssertEqual(settings!.index, testIndex)
        XCTAssertEqual(settings!.height, testHeight)
        XCTAssertEqual(settings!.names[1], testName)
        XCTAssertEqual(settings!.title, testTitle)
        XCTAssertEqual(settings!.width, testWidth)
        XCTAssertEqual(settings!.xMax, Defaults.maxDefault)
        XCTAssertEqual(settings!.yMax, testYMax)

        settings = try? Settings.load(settingsJSON(false))
        XCTAssertNotNil(settings)
        XCTAssertFalse(settings!.inColumns)
        XCTAssertTrue(settings!.inRows)
        XCTAssertTrue(settings!.rowGrouping)

        Defaults.rowGrouping = true
        settings = try? Settings.load(settingsJSON(true))
        XCTAssertNotNil(settings)
        XCTAssertTrue(settings!.inColumns)
        XCTAssertFalse(settings!.inRows)
        XCTAssertFalse(settings!.rowGrouping)
    }

    func testCSV() throws {
        let csv = CSV(csvData)

        XCTAssertEqual(csv.data.count, 5)
        for row in csv.data {
            XCTAssertEqual(row.count, 5)
        }

        var (min, max) = csv.columnMinMax(3)
        XCTAssertEqual(min, -110.1)
        XCTAssertEqual(max, 5220.6)

        (min, max) = csv.columnMinMax(2, from: 2)
        XCTAssertEqual(min, 129.9)
        XCTAssertEqual(max, 152.7)

        (min, max) = csv.rowMinMax(0, min: 0.0, max: 1000.0)
        XCTAssertEqual(min, -1.0)
        XCTAssertEqual(max, 1000.0)

        (min, max) = csv.rowMinMax(3, from: 1)
        XCTAssertEqual(min, 100.1)
        XCTAssertEqual(max, 152.7)
    }

    func testSVG() throws {
        let csv = CSV(csvData)
        var svg = try? SVG(csv, Settings.load(settingsJSON(true)))

        XCTAssertNotNil(svg)
        XCTAssertEqual(svg?.names[4], testName)

        svg = try? SVG(csv, Settings.load(settingsJSON(false)))

        XCTAssertNotNil(svg)
        XCTAssertEqual(svg?.names[4], testName)

        let csvPlot = CSV(plotData)

        SVG.Colours.reset()
        svg = try? SVG(csvPlot, Settings.load(settingsJSON(true)))
        XCTAssertNotNil(svg)
        let colPlot = svg!.gen()

        SVG.Colours.reset()
        svg = try? SVG(csvPlot, Settings.load(settingsJSON(false)))
        XCTAssertNotNil(svg)
        let rowPlot = svg!.gen()

        XCTAssertEqual(colPlot, rowPlot)

        /*
        print(colPlot.difference(from: rowPlot))
        if colPlot.count == rowPlot.count {
            for i in 0..<colPlot.count {
                print("Index: \(i)")
                print(colPlot[i].difference(from: rowPlot[i]))
            }
        }
        */
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

        var svg = try? SVG(csv, Settings.load(settingsJSON(true)))
        XCTAssertNotNil(svg)
        XCTAssertEqual(svg!.dataEdges.top, testYMax)
        XCTAssertEqual(svg!.dataEdges.bottom, -110.1)
        XCTAssertEqual(svg!.dataEdges.left, 0)
        XCTAssertEqual(svg!.dataEdges.right, 32)

        svg = try? SVG(csv, Settings.load(settingsJSON(false)))
        XCTAssertNotNil(svg)
        XCTAssertEqual(svg!.dataEdges.top, testYMax)
        XCTAssertEqual(svg!.dataEdges.bottom, -110.1)
        XCTAssertEqual(svg!.dataEdges.left, -1.0)
        XCTAssertEqual(svg!.dataEdges.right, 35.0)
    }

    func testFormats() {
        XCTAssertEqual((10.0/3.0).e(2), "3.33e+00")
        XCTAssertEqual((10.0/3.0).f(2), "3.33")
        XCTAssertEqual((10.0/3.0).f(0), "3")
        XCTAssertEqual((10.0/3.0).g(3), "3.33")
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
func settingsJSON(_ cols: Bool) -> String {
    return """
        {
            "colours": [ "silver", "red", "green" ],
            "headerColumns": 1,
            "headerRows": 1,
            "rowGrouping": \(!cols),
            "index": \(testIndex),
            "height": \(testHeight),
            "names": [ "a", "\(testName)", "c" ],
            "width": \(testWidth),
            "title": "\(testTitle)",
            "yMax": \(testYMax)
        }
        """
}

// CSV string for tests
let csvData = """
1,-1,9,35,"\(testName)"
1,100.1,120.4, -110.1,0.0
9,100.1,129.9,5220.6 ,0.0
32,100.1,152.7,,
"\(testName)",,,,0.0
"""

// CSV data for plot test
let plotData = """
1,2,3,4,5
2,1,5,8,12
3,5,6,11,19
4,8,11,,11
5,12,19,11,20
"""

// SVG path
let pathPoints = [
    SVG.PathCommand.moveTo(x: 0, y: 1),
    SVG.PathCommand.lineTo(x: 1, y: 2),
    SVG.PathCommand.lineTo(x: 2, y: 4),
    SVG.PathCommand.horizTo(x: 3.0),
    SVG.PathCommand.vertTo(y: 8.0),
    SVG.PathCommand.moveTo(x: 4, y: 16),
    SVG.PathCommand.lineTo(x: 5, y: 32),
    SVG.PathCommand.moveBy(dx: -2, dy: -2),
    SVG.PathCommand.circle(r: 3)
]

// swiftlint:disable line_length
let pathTag = """
<path d=" M 0.0,1.0 L 1.0,2.0 L 2.0,4.0 H 3.0 V 8.0 M 4.0,16.0 L 5.0,32.0 m -2.0,-2.0 m 0.0,-3.0 a 3.0,3.0,0.0,1,1,0.0,6.0 a 3.0,3.0,0.0,1,1,0.0,-6.0 m 0.0,3.0 " style="stroke: black; fill: none; stroke-width: 1; stroke-linecap: round" />
"""

//
//  csv2svgTests.swift
//  csv2svgTests
//
//  Created by Michael Salmon on 2021-02-21.
//

import XCTest
import ArgumentParser
@testable import csv2svg

let defaults = Defaults.global

class csv2svgTests: XCTestCase {

    func testSettings() throws {
        var settings = try? Settings.load(settingsJSON(true))
        XCTAssertNotNil(settings)
        XCTAssertEqual(settings!.plot.bezier, Defaults.global.bezier)
        XCTAssertEqual(settings!.plot.colours.count, 3)
        XCTAssertTrue(settings!.inColumns)
        XCTAssertFalse(settings!.inRows)
        XCTAssertFalse(settings!.csv.rowGrouping)
        XCTAssertEqual(settings!.csv.index, testIndex - 1)
        XCTAssertEqual(settings!.dim.height, testHeight)
        XCTAssertEqual(settings!.plot.names[1], testName)
        XCTAssertEqual(settings!.svg.title, testTitle)
        XCTAssertEqual(settings!.dim.width, testWidth)
        XCTAssertEqual(settings!.dim.xMax, Defaults.maxDefault)
        XCTAssertEqual(settings!.dim.yMax, testYMax)

        settings = try? Settings.load(settingsJSON(false))
        XCTAssertNotNil(settings)
        XCTAssertFalse(settings!.inColumns)
        XCTAssertTrue(settings!.inRows)
        XCTAssertTrue(settings!.csv.rowGrouping)

        settings = try? Settings.load(settingsJSON(true))
        XCTAssertNotNil(settings)
        XCTAssertTrue(settings!.inColumns)
        XCTAssertFalse(settings!.inRows)
        XCTAssertFalse(settings!.csv.rowGrouping)
    }

    func testCSV() throws {
        let csv = CSV(csvData)

        XCTAssertEqual(csv.data.count, 5)
        for row in csv.data {
            XCTAssertEqual(row.count, 5)
        }

        // Check for embedded space and trailing cr
        XCTAssertNil(csv.values[0][3], "embedded space")
        XCTAssertEqual(csv.data[0][3], "3 \" 5", "embedded spaces and double quote")
        XCTAssertNotNil(csv.values[1][3], "leading space")
        XCTAssertNotNil(csv.values[2][1], "trailing space")
        XCTAssertNotNil(csv.values[1][4], "trailing cr")

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

        let csvTab = CSV(csvData.replacingOccurrences(of: ",", with: "\t"), separatedBy: "\t")
        XCTAssertEqual(csv, csvTab)
    }

    func testBigCsv() {
        var bigCsvData: [String] = []

        for _ in 0..<1000 {
            var row: [String] = []
            for _ in 0..<1000 {
                row.append(Int.random(in: -500...500).d(4))
            }
            bigCsvData.append(row.joined(separator: ","))
        }

        let csv = CSV(bigCsvData)
        XCTAssertNotNil(csv)
        let svg = try? SVG(csv, Settings.load("{ \"labels\":false }"))
        XCTAssertNotNil(svg)
        XCTAssertFalse(svg!.gen().isEmpty)
    }

    func testSVG() throws {
        let csv = CSV(csvData)
        var svg = try? SVG(csv, Settings.load(settingsJSON(true)))

        XCTAssertNotNil(svg)
        XCTAssertEqual(svg?.propsList[4].name, testName)
        XCTAssertEqual(svg?.subTitle, rowTestSubTitle)

        svg = try? SVG(csv, Settings.load(settingsJSON(false)))

        XCTAssertNotNil(svg)
        XCTAssertEqual(svg?.propsList[4].name, testName)
        XCTAssertEqual(svg?.subTitle, colTestSubTitle)

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

    func testEmptyCSV() {
        let svg = try? SVG(CSV([]), Settings.load(settingsJSON(true)))
        XCTAssertNotNil(svg)
    }

    func testSvgPath() {
        let path = SVG.path(pathPoints, cssClass: "test")
        print(path.difference(from: pathTag))
        XCTAssertEqual(path, pathTag)
    }

    func testPoint() {
        let start = Point(x: 100, y: 500)
        let end = Point(x: 40, y: 420)
        XCTAssertEqual(start.partWay(end, part: 0.4), Point(x: 76, y: 468))
        XCTAssertEqual(end.partWay(start, part: 0.6), Point(x: 76, y: 468))
    }

    func testSvgTransScale() {
        let from = Plane(top: 1000, bottom: 0, left: -1000, right: 1000)
        let to = Plane(top: 0, bottom: 1000, left: 0, right: 1000)
        let ts = SVG.TransScale(from: from, to: to)

        XCTAssertEqual(ts.xpos(0), 500)
        XCTAssertEqual(ts.ypos(500), 500)

        XCTAssertEqual(ts.xpos(-1000), 0)
        XCTAssertEqual(ts.ypos(0), 1000)

        XCTAssertEqual(ts.xpos(1000), 1000)
        XCTAssertEqual(ts.ypos(1000), 0)

        let fromLog = Plane(top: 10000, bottom: 1, left: 10, right: 100000)
        let toLog = Plane(top: 0, bottom: 1000, left: 0, right: 1000)
        let tsLog = SVG.TransScale(from: fromLog, to: toLog, logx: true, logy: true)

        XCTAssertEqual(tsLog.xpos(10), 0)
        XCTAssertEqual(tsLog.xpos(1000), 500)
        XCTAssertEqual(tsLog.xpos(100000), 1000)
        XCTAssertEqual(tsLog.ypos(1), 1000)
        XCTAssertEqual(tsLog.ypos(100), 500)
        XCTAssertEqual(tsLog.ypos(10000), 0)
    }

    func testSvgSides() {
        let csv = CSV(csvData)

        var svg = try? SVG(csv, Settings.load(settingsJSON(true)))
        XCTAssertNotNil(svg)
        XCTAssertEqual(svg!.dataPlane.top, testYMax)
        XCTAssertEqual(svg!.dataPlane.bottom, -110.1)
        XCTAssertEqual(svg!.dataPlane.left, 0)
        XCTAssertEqual(svg!.dataPlane.right, 32)

        svg = try? SVG(csv, Settings.load(settingsJSON(false)))
        XCTAssertNotNil(svg)
        XCTAssertEqual(svg!.dataPlane.top, testYMax)
        XCTAssertEqual(svg!.dataPlane.bottom, -110.1)
        XCTAssertEqual(svg!.dataPlane.left, -1.0)
        XCTAssertEqual(svg!.dataPlane.right, 9.0)
    }

    func testFormats() {
        XCTAssertEqual((10.0/3.0).e(2), "3.33e+00")
        XCTAssertEqual((10.0/3.0).f(2), "3.33")
        XCTAssertEqual((10.0/3.0).f(0), "3")
        XCTAssertEqual((10.0/3.0).g(3), "3.33")
    }

    func testShapes() {
        XCTAssertEqual(SVG.Shape.lookup("circle"), SVG.Shape.circle)
        XCTAssertNil(SVG.Shape.lookup("nothing"))
    }

    func testBitmap() {
        XCTAssertEqual(bitmap([]), 0)
        XCTAssertEqual(bitmap([64]), 0)
        XCTAssertEqual(bitmap([0]), 0)
        XCTAssertEqual(bitmap([1,3,5]), 21)
        XCTAssertEqual(bitmap([1,1,1]), 1)
    }

    func testSearchPath() {
        _ = [ "/usr/bin", "/usr/local/bin", "/bin" ].map {
            SearchPath.add(URL(fileURLWithPath: $0, isDirectory: true))
        }
        let url = SearchPath.search("bash")
        XCTAssertNotNil(url)
        XCTAssertEqual(url!.path, "/bin/bash")
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
let rowTestSubTitle = "1 -1 9 3 \" 5 \(testName)"
let colTestSubTitle = "1 1 9 32 \(testName)"
let testTitle = "Test title"
let testWidth = 501
let testYMax = 25000.25

// JSON string for tests
func settingsJSON(_ cols: Bool) -> String {
    return """
        {
            "bezier": 0.500001,
            "colours": [ "silver", "red", "green" ],
            "cssID": "test",
            "headerColumns": 1,
            "headerRows": 1,
            "rowGrouping": \(!cols),
            "index": \(testIndex),
            "height": \(testHeight),
            "names": [ "a", "\(testName)", "c" ],
            "width": \(testWidth),
            "subTitleHeader": 1,
            "title": "\(testTitle)",
            "yMax": \(testYMax)
        }
        """
}

// CSV string for tests
let csvData = """
1,-1,9,3 " 5,"\(testName)"\r
1,100.1,120.4, -110.1,0.0\r
9,100.1 ,129.9,5220.6 ,0.0\r
32,100.1,152.7,,\r
"\(testName)",,,,0.0\r
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
<path class="test" d=" M 0.0,1.0 L 1.0,2.0 L 2.0,4.0 H 3.0 V 8.0 M 4.0,16.0 L 5.0,32.0 m -2.0,-2.0 m 0.0,-3.0 a 3.0,3.0,0.0,1,1,0.0,6.0 a 3.0,3.0,0.0,1,1,0.0,-6.0 m 0.0,3.0 " />
"""
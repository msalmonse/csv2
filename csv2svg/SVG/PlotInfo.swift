//
//  SVG/PlotInfo.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-10.
//

import Foundation

extension SVG {

    /// Generate a list of colours for the plots
    /// - Parameters:
    ///   - settings: settings for plot
    ///   - ct: number of plots
    /// - Returns: list of colours

    static func plotColours(_ settings: Settings, _ ct: Int) -> [String] {
        var colours: [String] = []
        for i in 0..<ct {
            if i < settings.colours.count && settings.colours[i] != "" {
                colours.append(settings.colours[i])
            } else if settings.black {
                colours.append("black")
            } else {
                colours.append(Colours.nextColour())
            }
        }

        return colours
    }

    /// Generate a list of names for the plots
    /// - Parameters:
    ///   - settings: settings for plot
    ///   - ct: number of plots
    /// - Returns: list of names

    static func plotNames(_ settings: Settings, _ csv: CSV, _ ct: Int) -> [String] {
        var names: [String] = []
        for i in 0..<ct {
            if i < settings.names.count && settings.names[i] != "" {
                names.append(settings.names[i])
            } else if settings.headers > 0 {
                names.append(SVG.headerText(i, csv: csv, inColumns: settings.inColumns))
            } else {
                names.append(SVG.headerText(i, csv: nil, inColumns: settings.inColumns))
            }
        }

        return names
    }

    /// Generate a list of names for the plots
    /// - Parameters:
    ///   - settings: settings for plot
    ///   - ct: number of plots
    /// - Returns: list of names

    static func plotShapes(_ settings: Settings, _ ct: Int) -> [Shape?] {
        var shapes: [Shape?] = []
        for i in 0..<ct {
            if !settings.scattered(i) {
                shapes.append(nil)
            } else {
                if i < settings.shapes.count && settings.shapes[i] != "" {
                    shapes.append(
                        Shape.lookup(settings.shapes[i]) ?? Shape.nextShape()
                    )
                } else {
                    shapes.append(Shape.nextShape())
                }
            }
        }

        return shapes
    }
}

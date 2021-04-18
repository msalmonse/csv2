//
//  PNGPlotter.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-18.
//

import Foundation

extension PNG {
    func plotClipStart(plotPlane: Plane) {
        return
    }

    func plotClipEnd() {
        return
    }

    func plotHead(positions: Positions, plotPlane: Plane, propsList: PropertiesList) {
        return
    }

    func plotPrint() {
        return
    }

    func plotRect(_ plane: Plane, rx: Double, props: Properties) {
        return
    }

    func plotTail() {
        return
    }

    func plotWrite(to url: URL) throws {
        if let pngData = image.pngData() {
            do {
                try pngData.write(to: url)
            } catch {
                throw(error)
            }
        }
    }
}

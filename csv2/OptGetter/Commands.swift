//
//  Commands.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-09.
//

import Foundation
import OptGetter

enum PlotterType: OptGetterTag {
    case canvas, help, helpCanvas, helpPdf, helpPng, helpSvg, pdf, png, svg

    func plotter(settings: Settings) -> Plotter {
        switch self {
        case .canvas: return Canvas(settings)
        case .pdf: return PDF(settings)
        case .png: return PNG(settings)
        case .svg: return SVG(settings)
        default:
            return SVG(settings)
        }
    }
}

let cmds: [CmdToGet] = [
    CmdToGet(["canvas"], tag: PlotterType.canvas),
    CmdToGet(["help", "canvas"], tag: PlotterType.helpCanvas),
    CmdToGet(["help", "pdf"], tag: PlotterType.helpPdf),
    CmdToGet(["help", "png"], tag: PlotterType.helpPng),
    CmdToGet(["help", "svg"], tag: PlotterType.helpSvg),
    CmdToGet(["help"], tag: PlotterType.help),
    CmdToGet(["pdf"], tag: PlotterType.pdf),
    CmdToGet(["png"], tag: PlotterType.png),
    CmdToGet(["svg"], tag: PlotterType.svg)
]

func getCommand() -> PlotterType {
    return .help
}

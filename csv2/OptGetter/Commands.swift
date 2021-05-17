//
//  Commands.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-09.
//

import Foundation
import OptGetter

enum CommandType: OptGetterTag {
    case canvas, help, helpCanvas, helpPdf, helpPng, helpSvg, pdf, png, svg

    var isHelp: Bool {
        switch self {
        case .help, .helpCanvas, .helpPdf, .helpPng, .helpSvg:
            return true
        default:
            return false
        }
    }

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

private let cmds: [CmdToGet] = [
    CmdToGet(["canvas"], tag: CommandType.canvas),
    CmdToGet(["help", "canvas"], tag: CommandType.helpCanvas),
    CmdToGet(["help", "pdf"], tag: CommandType.helpPdf),
    CmdToGet(["help", "png"], tag: CommandType.helpPng),
    CmdToGet(["help", "svg"], tag: CommandType.helpSvg),
    CmdToGet(["help"], tag: CommandType.help),
    CmdToGet(["pdf"], tag: CommandType.pdf),
    CmdToGet(["png"], tag: CommandType.png),
    CmdToGet(["svg"], tag: CommandType.svg)
]

func getCommand() -> CommandType {
    // Check first for empty command line
    if CommandLine.arguments.count == 1 { return .help }
    // svg is the default plotter
    return OptGetter.cmdGetter(cmds, args: CommandLine.arguments)?.tag as? CommandType ?? .svg
}

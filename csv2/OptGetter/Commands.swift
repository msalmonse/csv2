//
//  Commands.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-09.
//

import Foundation
import OptGetter

enum CommandType: OptGetterTag {
    case canvas, canvastag, help, helpCanvas, helpPdf, helpPng, helpSvg, helpUsage, pdf, png, svg, unspec

    /// Is this a help command?
    var isHelp: Bool {
        switch self {
        case .help, .helpCanvas, .helpPdf, .helpPng, .helpSvg, .helpUsage:
            return true
        default:
            return false
        }
    }

    /// What is the first argument to parse
    var optStart: Int {
        switch self {
        case .unspec: return 1
        case .canvas, .pdf, .png, .svg, .help:
            return 2
        case .canvastag, .helpCanvas, .helpPdf, .helpPng, .helpSvg, .helpUsage:
            return 3
        }
    }

    /// Create a plotter object
    /// - Parameter settings: chart settings
    /// - Returns: plotter object

    func plotter(settings: Settings) -> Plotter {
        switch self {
        case .canvas: return Canvas(settings)
        case .canvastag: return CanvasTag(settings: settings)
        case .pdf: return PDF(settings)
        case .png: return PNG(settings)
        case .svg: return SVG(settings)
        default:
            return SVG(settings)
        }
    }
}

private let cmds: [CmdToGet] = [
    CmdToGet(["canvas", "tag"], tag: CommandType.canvastag),
    CmdToGet(["canvas"], tag: CommandType.canvas),
    CmdToGet(["help", "canvas"], tag: CommandType.helpCanvas),
    CmdToGet(["help", "pdf"], tag: CommandType.helpPdf),
    CmdToGet(["help", "png"], tag: CommandType.helpPng),
    CmdToGet(["help", "svg"], tag: CommandType.helpSvg),
    CmdToGet(["help", "usage"], tag: CommandType.helpUsage),
    CmdToGet(["help"], tag: CommandType.help),
    CmdToGet(["pdf"], tag: CommandType.pdf),
    CmdToGet(["png"], tag: CommandType.png),
    CmdToGet(["svg"], tag: CommandType.svg)
]

func getCommand(_ args: [String] = CommandLine.arguments) -> CommandType {
    // Check first for empty command line
    if args.count == 1 { return .help }
    // svg is the default plotter
    return OptGetter.cmdGetter(cmds, args: args)?.tag as? CommandType ?? .unspec
}

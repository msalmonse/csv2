//
//  Commands.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-09.
//

import Foundation
import OptGetter

enum CommandType: OptGetterTag {
    case
        bitmap,
        canvas, canvasColours, canvasColourNames, canvasDashes, canvasShape,
        canvastag, canvastagColours, canvastagColourNames, canvastagDashes, canvastagShape,
        listColourNames, listShapes,
        help, helpCanvas, helpPdf, helpPng, helpSvg, helpUsage,
        pdf, pdfColours, pdfColourNames, pdfDashes, pdfShape,
        png, pngColours, pngColourNames, pngDashes, pngShape,
        svg, svgColours, svgColourNames, svgDashes, svgShape,
        unspec, version

    /// Is this a help command?
    var isHelp: Bool {
        switch self {
        case .bitmap, .help, .helpCanvas, .helpPdf, .helpPng, .helpSvg, .helpUsage, .version:
            return true
        default:
            return false
        }
    }

    /// What is the first argument to parse
    var optStart: Int {
        switch self {
        case .unspec, .version:
            return 1
        case .bitmap, .canvas, .pdf, .png, .svg, .help:
            return 2
        case .listColourNames, .listShapes:
            return 3
        case .canvastag, .helpCanvas, .helpPdf, .helpPng, .helpSvg, .helpUsage:
            return 3
        case .canvasColourNames, .canvasColours, .canvasDashes, .canvasShape,
             .pdfColourNames, .pdfColours, .pdfDashes, .pdfShape,
             .pngColourNames, .pngColours, .pngDashes, .pngShape,
             .svgColourNames, .svgColours, .svgDashes, .svgShape:
            return 4
        case .canvastagColourNames, .canvastagColours, .canvastagDashes, .canvastagShape:
            return 5
        }
    }

    /// Create a plotter object
    /// - Parameter settings: chart settings
    /// - Returns: plotter object

    func plotter(settings: Settings) -> Plotter {
        switch self {
        case .canvas, .canvasColourNames, .canvasColours, .canvasDashes, .canvasShape:
            return Canvas(settings)
        case .canvastag, .canvastagColourNames, .canvastagColours, .canvastagDashes, .canvastagShape:
            return CanvasTag(settings: settings)
        case .pdf, .pdfColourNames, .pdfColours, .pdfDashes, .pdfShape:
            return PDF(settings)
        case .png, .pngColourNames, .pngColours, .pngDashes, .pngShape:
            return PNG(settings)
        case .svg, .svgColourNames, .svgColours, .svgDashes, .svgShape:
            return SVG(settings)
        default:
            return SVG(settings)
        }
    }
}

private let cmds: [CmdToGet] = [
    CmdToGet(["bitmap"], tag: CommandType.bitmap),
    CmdToGet(["canvas", "tag", "show", "colournames"], tag: CommandType.canvastagColourNames),
    CmdToGet(["canvas", "tag", "show", "colours"], tag: CommandType.canvastagColours),
    CmdToGet(["canvas", "tag", "show", "dashes"], tag: CommandType.canvastagDashes),
    CmdToGet(["canvas", "tag", "show"], tag: CommandType.canvastagDashes),
    CmdToGet(["canvas", "tag"], tag: CommandType.canvastag),
    CmdToGet(["canvas", "show", "colournames"], tag: CommandType.canvasColourNames),
    CmdToGet(["canvas", "show", "colours"], tag: CommandType.canvasColours),
    CmdToGet(["canvas", "show", "dashes"], tag: CommandType.canvasDashes),
    CmdToGet(["canvas", "show"], tag: CommandType.canvasDashes),
    CmdToGet(["canvas"], tag: CommandType.canvas),
    CmdToGet(["help", "canvas"], tag: CommandType.helpCanvas),
    CmdToGet(["help", "pdf"], tag: CommandType.helpPdf),
    CmdToGet(["help", "png"], tag: CommandType.helpPng),
    CmdToGet(["help", "svg"], tag: CommandType.helpSvg),
    CmdToGet(["help", "usage"], tag: CommandType.helpUsage),
    CmdToGet(["help"], tag: CommandType.help),
    CmdToGet(["list", "colournames"], tag: CommandType.listColourNames),
    CmdToGet(["list", "shapes"], tag: CommandType.listShapes),
    CmdToGet(["pdf", "show", "colournames"], tag: CommandType.pdfColourNames),
    CmdToGet(["pdf", "show", "colours"], tag: CommandType.pdfColours),
    CmdToGet(["pdf", "show", "dashes"], tag: CommandType.pdfDashes),
    CmdToGet(["pdf", "show"], tag: CommandType.pdfShape),
    CmdToGet(["pdf"], tag: CommandType.pdf),
    CmdToGet(["png", "show", "colournames"], tag: CommandType.pngColourNames),
    CmdToGet(["png", "show", "colours"], tag: CommandType.pngColours),
    CmdToGet(["png", "show", "dashes"], tag: CommandType.pngDashes),
    CmdToGet(["png", "show"], tag: CommandType.pngShape),
    CmdToGet(["png"], tag: CommandType.png),
    CmdToGet(["svg", "show", "colournames"], tag: CommandType.svgColourNames),
    CmdToGet(["svg", "show", "colours"], tag: CommandType.svgColours),
    CmdToGet(["svg", "show", "dashes"], tag: CommandType.svgDashes),
    CmdToGet(["svg", "show"], tag: CommandType.svgShape),
    CmdToGet(["svg"], tag: CommandType.svg),
    CmdToGet(["version"], tag: CommandType.version)
]

func getCommand(_ args: [String] = CommandLine.arguments) -> CommandType {
    // Check first for empty command line
    if args.count == 1 { return .help }
    // svg is the default plotter
    return OptGetter.cmdGetter(cmds, args: args)?.tag as? CommandType ?? .unspec
}

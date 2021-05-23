//
//  Commands.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-09.
//

import Foundation
import OptGetter

enum CommandType {
    case helpCommand(help: HelpCommandType)
    case listCommand(list: ListCommandType)
    case plotCommand(main: MainCommandType, sub: SubCommandType)
}

enum HelpCommandType: OptGetterTag {
    case bitmap, help, helpCanvas, helpCommands, helpPdf, helpPng, helpSvg, helpUsage
}

enum ListCommandType: OptGetterTag {
    case bitmap, listColourNames, listShapes, version
}

enum MainCommandType: OptGetterTag {
    case canvas, canvastag,  pdf,  png,  svg, unspec

    // number of arguments taken including path name
    var count: Int {
        switch self {
        case .unspec: return 1
        default: return 2
        }
    }

    func plotter(settings: Settings) -> Plotter {
        switch self {
        case .canvas: return Canvas(settings)
        case .canvastag: return CanvasTag(settings)
        case .pdf: return PDF(settings)
        case .png: return PNG(settings)
        case .svg: return SVG(settings)
        case .unspec: return SVG(settings)
        }
    }
}

enum SubCommandType: OptGetterTag {
    case colourNames, colours, dashes, shapes(name: String), none

    // number of arguments taken after main
    var count: Int {
        switch self {
        case .none: return 0
        default: return 2
        }
    }
}

private let plotCmds: [CmdToGet] = [
    CmdToGet(["canvas"], tag: MainCommandType.canvas),
    CmdToGet(["canvastag"], tag: MainCommandType.canvastag),
    CmdToGet(["pdf"], tag: MainCommandType.pdf),
    CmdToGet(["png"], tag: MainCommandType.png),
    CmdToGet(["svg"], tag: MainCommandType.svg)
]

private let plotSubCmds: [CmdToGet] = [
    CmdToGet(["show", "colournames"], tag: SubCommandType.colourNames),
    CmdToGet(["show", "colours"], tag: SubCommandType.colours),
    CmdToGet(["show", "dashes"], tag: SubCommandType.dashes)
]

private let listCmds: [CmdToGet] = [
    CmdToGet(["bitmap"], tag: ListCommandType.bitmap),
    CmdToGet(["list", "colournames"], tag: ListCommandType.listColourNames),
    CmdToGet(["list", "shapes"], tag: ListCommandType.listShapes),
    CmdToGet(["version"], tag: ListCommandType.version)
]
private let helpCmds: [CmdToGet] = [
    CmdToGet(["help", "canvas"], tag: HelpCommandType.helpCanvas),
    CmdToGet(["help", "pdf"], tag: HelpCommandType.helpPdf),
    CmdToGet(["help", "png"], tag: HelpCommandType.helpPng),
    CmdToGet(["help", "svg"], tag: HelpCommandType.helpSvg),
    CmdToGet(["help", "usage"], tag: HelpCommandType.helpUsage),
    CmdToGet(["help"], tag: HelpCommandType.help)
]

func getCommand(_ args: [String]) -> CommandType {
    // Check first for empty command line
    if args.count == 1 { return .helpCommand(help: .help) }

    if let main = (OptGetter.cmdGetter(plotCmds, args: args)?.tag as? MainCommandType) {
        let start = main.count
        var cmds = plotSubCmds
        let name = args.hasIndex(start + 1) ? args[start + 1] : ""
        cmds.append(CmdToGet(["show"], tag: SubCommandType.shapes(name: name)))

        let sub = OptGetter.cmdGetter(cmds, args: args, start)?.tag as? SubCommandType ?? .none
        return .plotCommand(main: main, sub: sub)
    }
    if let list = (OptGetter.cmdGetter(listCmds, args: args)?.tag as? ListCommandType) {
        return .listCommand(list: list)
    }
    if let help = (OptGetter.cmdGetter(helpCmds, args: args)?.tag as? HelpCommandType) {
        return .helpCommand(help: help)
    }

    return .plotCommand(main: .unspec, sub: .none)
}

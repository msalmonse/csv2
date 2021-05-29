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
    case help, helpCanvas, helpCommands, helpList, helpPdf, helpPng, helpShow, helpSvg, helpUsage

    var count: Int {
        switch self {
        case .help: return 2
        default: return 3
        }
    }

}

enum ListCommandType: OptGetterTag {
    case bitmap, listColourNames, listJSON, listShapes, version
}

enum MainCommandType: OptGetterTag {
    case canvas, help,  pdf,  png,  svg, unspec

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
        case .help: return SVG(settings)
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

let plotCmds: [CmdToGet] = [
    CmdToGet(["canvas"], tag: MainCommandType.canvas,
             usage: "Generate javascript to draw the chart on a HTML5 canvas."),
    CmdToGet(["pdf"], tag: MainCommandType.pdf,
             usage: "Generate a PDF chart."),
    CmdToGet(["png"], tag: MainCommandType.png,
             usage: "Generate a PNG chart."),
    CmdToGet(["svg"], tag: MainCommandType.svg,
             usage: "Generate an SVG chart.")
]

let plotSubCmds: [CmdToGet] = [
    CmdToGet(["show", "colournames"], tag: SubCommandType.colourNames,
             usage: "Create a chart of all of the colours known to this program."),
    CmdToGet(["show", "colours"], tag: SubCommandType.colours,
             usage: "Create a chart of the colours that are user defined as well as those internally defined."),
    CmdToGet(["show", "dashes"], tag: SubCommandType.dashes,
             usage: "Create a chart of the dashes that are user defined as well as those internally defined.")
]

let listCmds: [CmdToGet] = [
    CmdToGet(["bitmap"], tag: ListCommandType.bitmap,
             usage: "Take a list of rows or columns and print the corresponding bitmap"),
    CmdToGet(["list", "colournames"], tag: ListCommandType.listColourNames,
             usage: "List the colour names known to the program"),
    CmdToGet(["list", "json"], tag: ListCommandType.listJSON,
             usage: "Like 'help usage' but with the output in JSON"),
    CmdToGet(["list", "shapes"], tag: ListCommandType.listShapes,
             usage: "List the shape names defined internally"),
    CmdToGet(["version"], tag: ListCommandType.version,
             usage: "List the version")
]
let helpCmds: [CmdToGet] = [
    CmdToGet(["help", "canvas"], tag: HelpCommandType.helpCanvas,
             usage: "Show help for the canvas chart type."),
    CmdToGet(["help", "commands"], tag: HelpCommandType.helpCommands,
             usage: "Show help on the available commands."),
    CmdToGet(["help", "list"], tag: HelpCommandType.helpList,
             usage: "Show help on list commands"),
    CmdToGet(["help", "pdf"], tag: HelpCommandType.helpPdf,
             usage: "Show help for the PDF chart type."),
    CmdToGet(["help", "png"], tag: HelpCommandType.helpPng,
             usage: "Show help for the PNG chart type."),
    CmdToGet(["help", "show"], tag: HelpCommandType.helpShow,
             usage: "Show help on list commands"),
    CmdToGet(["help", "svg"], tag: HelpCommandType.helpSvg,
             usage: "Show help for the SVG chart type."),
    CmdToGet(["help", "usage"], tag: HelpCommandType.helpUsage,
             usage: "Show help on options."),
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

func plotUsage() -> String { return cmdUsage(plotCmds) }

func listUsage() -> String { return cmdUsage(listCmds) }

func showUsage() -> String { return cmdUsage(plotSubCmds) }

func helpUsage() -> String { return cmdUsage(helpCmds) }

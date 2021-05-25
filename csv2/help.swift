//
//  help.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-16.
//

import Foundation

/// Print the usage for the options specific to a command
/// - Parameters:
///   - chartType: name for command
///   - optText: optional usage text

func printSpecificUsage(for chartType: String, _ optText: String?) {
    let indent = String(repeating: " ", count: UsageLeftRight.leftMargin)
    optText.map {
        print("""
            \(indent)\(chartType) specific options:
            \($0)

            """,
              to: &standardError
        )
    }

}

/// Main help text
/// - Parameter execName: programs executable name

func helpMain(_ execName: String) {
    let help = [
            "",
            """
            \(execName) takes a CSV encoded data file, formating options and generates an image.
            It can generate images in four formats: canvas, pdf, png, svg
            """,
            "",
            """
            More help is available on each, e.g. help canvas or on the options with help usage.
            \u{11}See also: https://github.com/msalmonse/csv2/blob/main/README.md
            """,
            ""
        ]
    print(textWrap(help), to: &standardError)
}

/// Help for canvas chart type
/// - Parameter execName: programs executable name

func helpCanvas(_ execName: String) {
    let help = [
        "",
        """
        \(execName) can generate the JavaScript to create a chart in an HTML canvas.
        It must be told the id of the tag as well as the size for it to work correctly.
        The --tag option take the id and size defined and prints out the
        corresponding canvas tag.
        """,
        ""
    ]
    print(textWrap(help), to: &standardError)
    printSpecificUsage(for: "Canvas", canvasUsage())
}

/// Help on main commands
/// - Parameter execName: programs executable name

func helpCommands(_ execName: String) {
    let help = [
            "",
            """
            The first argument on the command line is the main command.
            It can optionally be followed by a show sub-command but normally isn't,
            see "help show" for details.
            """,
            ""
        ]
    print(textWrap(help), to: &standardError)
    print(plotUsage(), "\n", to: &standardError)
}

/// Help for pdf chart type
/// - Parameter execName: programs executable name

func helpPDF(_ execName: String) {
    let help = [
        "",
        """
        \(execName) can generate a PDF chart. Several PDF properties can be set via the
        JSON file.
        """,
        ""
    ]
    print(textWrap(help), to: &standardError)
    printSpecificUsage(for: "PDF", pdfUsage())
}

/// Help for png chart type
/// - Parameter execName: programs executable name

func helpPNG(_ execName: String) {
    let help = [
        "",
        """
        \(execName) can generate a PNG image that has the same layout as the others.
        As it is a pixel format there isn't the same smooth scaling as the vector formats.
        """,
        ""
    ]
    print(textWrap(help), to: &standardError)
    printSpecificUsage(for: "PNG", pngUsage())
}

func helpSVG(_ execName: String) {
    let help = [
        "",
        """
        \(execName) can generate an SVG image that plots the data as SVG paths. It is very
        flexible in formatting and styling but isn't supported everywhere.
        """,
        ""
    ]
    print(textWrap(help), to: &standardError)
    printSpecificUsage(for: "SVG", svgUsage())
}

/// Help for option usage
/// - Parameter execName: programs executable name

func helpUsage(_ execName: String) {
    let indent = String(repeating: " ", count: UsageLeftRight.leftMargin)
    print("""

        \(textWrap("Generate a Canvas, PDF, PNG or SVG using data from a CSV file and settings from a JSON file."))

        \(indent)\(execName) <canvas|pdf|png|svg> [options] [csv file [json file [output file]]]

        \(indent)Arguments:
        \(positionalUsage() ?? "")

        \(indent)Common options:
        \(commonUsage() ?? "")

        """,
          to: &standardError
    )
    printSpecificUsage(for: "Canvas", canvasUsage())
    printSpecificUsage(for: "PDF", pdfUsage())
    printSpecificUsage(for: "PNG", pngUsage())
    printSpecificUsage(for: "SVG", svgUsage())
    print("""

        \(indent)  ¹ <bitmap> means an integer where each bit has a specific meaning

        """,
          to: &standardError
    )
}

/// Help director
/// - Parameter command: help command entered
func help(_ command: HelpCommandType) {
    switch command {
    case .helpCanvas: helpCanvas(execName())
    case .helpCommands: helpCommands(execName())
    case .helpPdf: helpPDF(execName())
    case .helpPng: helpPNG(execName())
    case .helpSvg: helpSVG(execName())
    case .helpUsage: helpUsage(execName())
    default:
        helpMain(execName())
    }
}

/// lookup executable basename
/// - Returns: executables basename

func execName() -> String {
    if CommandLine.arguments.isEmpty { return AppInfo.name }
    return CommandLine.arguments[0].components(separatedBy: "/").last ?? AppInfo.name
}

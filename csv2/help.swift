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

func printSpecificUsage(for chartType: String, _ optText: String?, _ afterText: String = "") {
    let indent = String(repeating: " ", count: UsageLeftRight.leftMargin)
    optText.map {
        print("""
            \(indent)\(chartType) specific options:
            \($0)
            \(afterText)
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
            More help is available on each, e.g. "help canvas" or on the options with "help usage",
            or why not "help help".
            \u{11}See also: https://github.com/msalmonse/csv2/blob/main/README.md
            """,
            ""
        ]
    print(textWrap(help), to: &standardError)
    printSpecificUsage(for: "Help", helpOptsUsage())
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
    printSpecificUsage(for: "Canvas", canvasOptsUsage())
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

/// Help on list commands et al.
/// - Parameter execName: programs executable name

func helpList(_ execName: String) {
    let help = [
        "",
        """
        As well as the chart main commands there are a few commands that provide
        information without generating a chart. These commands print internal
        information to help with settings.
        """,
        ""
    ]
    print(textWrap(help), to: &standardError)
    print(listUsage(), "\n", to: &standardError)
}

/// Help on list commands et al.
/// - Parameter execName: programs executable name

func helpHelp(_ execName: String) {
    let help = [
        "",
        """
        There is help to be found on several topics, here is a list of what is available:
        """,
        ""
    ]
    print(textWrap(help), to: &standardError)
    print(helpUsage(), "\n", to: &standardError)
    printSpecificUsage(for: "Help", helpOptsUsage())
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
    printSpecificUsage(for: "PDF", pdfOptsUsage())
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
    printSpecificUsage(for: "PNG", pngOptsUsage())
}

/// Help on show sub commands
/// - Parameter execName: programs executable name

func helpShow(_ execName: String) {
    let help = [
        "",
        """
        There are a number of sub-commands that follow the main chart commands the generate
        charts using internal information rather than from CSV data. They are intended
        to help with deciding amongst formatting options.
        """,
        ""
    ]
    print(textWrap(help), to: &standardError)
    print(showUsage(), "\n", to: &standardError)
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
    printSpecificUsage(for: "SVG", svgOptsUsage())
}

/// Help for option usage
/// - Parameters
///   - execName: programs executable name
///   - ticks: put back ticks between sections

func helpUsage(_ execName: String, _ markdown: Bool) {
    let indent = String(repeating: " ", count: UsageLeftRight.leftMargin)
    let backTicks = markdown ? #"```"# : ""
    let backTicks2 = markdown ? "\(backTicks)\n\n\(backTicks)" : ""
    if markdown { print("## \(execName)", to: &standardError) }
    print("""
        \(backTicks)
        \(textWrap("Generate a Canvas, PDF, PNG or SVG using data from a CSV file and settings from a JSON file."))

        \(indent)\(execName) <canvas|pdf|png|svg> [options] [csv file [json file [output file]]]
        \(backTicks2)
        \(indent)Arguments:
        \(positionalArgsUsage() ?? "")
        \(backTicks2)
        \(indent)Common options:
        \(commonOptsUsage() ?? "")
        \(backTicks2)
        """,
          to: &standardError
    )
    printSpecificUsage(for: "Canvas", canvasOptsUsage(), backTicks2)
    printSpecificUsage(for: "PDF", pdfOptsUsage(), backTicks2)
    printSpecificUsage(for: "PNG", pngOptsUsage(), backTicks2)
    printSpecificUsage(for: "SVG", svgOptsUsage(), backTicks2)
    printSpecificUsage(for: "Help", helpOptsUsage(), backTicks2)
    let bitmap = [
        "¹ <bitmap> means a list of plot numbers like '1 2 3 4' corresponding to the rows or columns. " +
        "Negative numbers form the upper bound on a range, i.e. '1 -4' is the same as '1 2 3 4'. " +
        "The first number is initially 1 so in fact '-4' suffices.",
        "The word 'all' means all i.e. '1 -64', only on the command line though.",
        "The list must be terminated by a '--', either as a long argument or a literal '--'.",
        ""
    ]
    print(indentedTextWrap(bitmap), to: &standardError)
    print(backTicks, to: &standardError)
}

/// Help director
/// - Parameter command: help command entered
func help(_ command: HelpCommandType, _ options: Options) {
    switch command {
    case .helpCanvas: helpCanvas(execName())
    case .helpCommands: helpCommands(execName())
    case .helpHelp: helpHelp(execName())
    case .helpList: helpList(execName())
    case .helpPdf: helpPDF(execName())
    case .helpPng: helpPNG(execName())
    case .helpShow: helpShow(execName())
    case .helpSvg: helpSVG(execName())
    case .helpUsage: helpUsage(execName(), options.markdown)
    default:
        helpMain(execName())
    }
}

/// lookup executable basename
/// - Returns: executables basename

func execName() -> String {
    if CommandLine.arguments.isEmpty { return AppInfo.name }
    return (CommandLine.arguments[0] as NSString).lastPathComponent
}

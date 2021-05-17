//
//  help.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-16.
//

import Foundation

func printSpecificUsage(for chartType: String, _ optText: String?) {
    if let text = optText {
        print("""
            \(chartType) specific options:
            \(text)

            """,
              to: &standardError
        )
    }

}
func helpMain(_ execName: String) {
    let help = """

        \(execName) takes a CSV encoded data file, formating options and generates an image.
        It can generate images in four formats:
            canvas, pdf, png, svg
        More help is available on each, e.g. help canvas or on the options with help usage

        """
    print(help, to: &standardError)
    return
}

func helpCanvas(_ execName: String) {
    return
}

func helpPDF(_ execName: String) {
    return
}

func helpPNG(_ execName: String) {
    return
}

func helpSVG(_ execName: String) {
    return
}

func helpUsage(_ execName: String) {
    print("""

        \(execName) <canvas|pdf|png|svg> [options] [csv file [json file [output file]]]

          <csv file>          CSV data file name or - for stdin
          <json file>         JSON settings file name
          <output file>       Output file name, use stdout if omitted for canvas and svg

        Common options:
        \(commonUsage() ?? "")

        """,
          to: &standardError
    )
    printSpecificUsage(for: "Canvas", canvasUsage())
    printSpecificUsage(for: "PDF", pdfUsage())
    printSpecificUsage(for: "PNG", pngUsage())
    printSpecificUsage(for: "SVG", svgUsage())
    print("""

          * <bitmap> means an integer where each bit has a specific meaning

        """,
          to: &standardError
    )
}

func help(_ command: CommandType) {
    switch command {
    case .helpCanvas: helpCanvas(execName())
    case .helpPdf: helpPDF(execName())
    case .helpPng: helpPNG(execName())
    case .helpSvg: helpSVG(execName())
    case .helpUsage: helpUsage(execName())
    default:
        helpMain(execName())
    }
    return
}

func execName() -> String {
    if CommandLine.arguments.isEmpty { return AppInfo.name }
    return CommandLine.arguments[0].components(separatedBy: "/").last ?? AppInfo.name
}

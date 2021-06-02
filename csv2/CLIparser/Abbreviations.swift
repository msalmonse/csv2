//
//  Abbreviations.swift
//  csv2
//
//  Created by Michael Salmon on 2021-06-02.
//

import Foundation
import CLIparser

#if DEBUG
extension Options {
    static private func printCommon(plus: OptsToGet) {
        print(ArgumentList.abbreviations(commonOpts + plus))
    }

    static func abbrPrint(for command: AbbrCommandType) {
        switch command {
        case .abbr: printCommon(plus: [])
        case .abbrCanvas: printCommon(plus: canvasOpts)
        case .abbrPDF: printCommon(plus: [])
        case .abbrPNG: printCommon(plus: [])
        case .abbrSVG: printCommon(plus: svgOpts)
        }
    }
}
#else
extension Options {
    static func abbrPrint(for command: AbbrCommandType) {
        return
    }
}
#endif

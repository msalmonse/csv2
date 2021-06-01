//
//  Encodable.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-27.
//

import Foundation
import CLIparser

struct OptGetterEncodable: Encodable {
    enum CodingKeys: CodingKey { case commands, arguments, options }

    let commands: [String: CmdsToGet] = [
        "main": plotCmds,
        "show": plotSubCmds,
        "list": listCmds,
        "help": helpCmds
    ]
    let arguments = Options.positionalOpts
    let options: [String: OptsToGet] = [
        "canvas": Options.canvasOpts,
        "common": Options.commonOpts,
        "help": Options.helpOpts,
        "svg": Options.svgOpts
    ]

    /// Encode commands, arguments and options
    /// - Parameter encoder: encoder for e.g. JSON
    /// - Throws: Encoder errrors

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(commands, forKey: .commands)
        try container.encode(arguments, forKey: .arguments)
        try container.encode(options, forKey: .options)
    }
}

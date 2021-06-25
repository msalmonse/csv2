//
//  main.swift
//  csv2
//
//  Created by Michael Salmon on 2021-02-16.
//

import Foundation

var defaults: Defaults

var options = Options()
let command = options.getCommand()
switch command {
case let .abbrCommand(abbr):
    Options.abbrPrint(for: abbr)
case let .helpCommand(helpCommand):
    options.getOptsOrExit(for: .help)
    help(helpCommand, options)
case let .listCommand(listCommand):
    list(listCommand)
case let .plotCommand(main, sub):
    options.getOptsOrExit(for: main)
    defaults = options.defaults()
    if options.debug != 0 {
        print(options, to: &standardError)
    }
    execCommand(main, sub, options)
}

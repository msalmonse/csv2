//
//  main.swift
//  csv2
//
//  Created by Michael Salmon on 2021-02-16.
//

import Foundation

var defaults: Defaults

var options = Options()
let command = options.getCommand(CommandLine.arguments)
switch command {
case .abbrCommand(let abbr):
    Options.abbrPrint(for: abbr)
case .helpCommand(let helpCommand):
    options.getOptsOrExit(for: .help)
    help(helpCommand)
case .listCommand(let listCommand):
    list(listCommand)
case .plotCommand(let main, let sub):
    options.getOptsOrExit(for: main)
    defaults = options.defaults()
    if options.debug != 0 {
        print(options, to: &standardError)
    }
    execCommand(main, sub, options)
}

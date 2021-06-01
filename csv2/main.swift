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
case .helpCommand(let helpCommand):
    options.getOptsOrExit(for: .help)
    help(helpCommand)
    exit(0)
case .listCommand(let listCommand):
    list(listCommand)
    exit(0)
case .plotCommand(let main, let sub):
    options.getOptsOrExit(for: main)
    defaults = options.defaults()
    if options.debug != 0 {
        print(options, to: &standardError)
    }
    execCommand(main, sub, options)
}

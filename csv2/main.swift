//
//  main.swift
//  csv2
//
//  Created by Michael Salmon on 2021-02-16.
//

import Foundation

var defaults: Defaults

let command = getCommand(CommandLine.arguments)
switch command {
case .helpCommand(let helpCommand):
    _ = getOptsOrExit(for: .help, helpCommand.count)
    help(helpCommand)
    exit(0)
case .listCommand(let listCommand):
    list(listCommand)
    exit(0)
case .plotCommand(let main, let sub):
    let start = main.count + sub.count
    let options = getOptsOrExit(for: main, start)

    defaults = options.defaults()

    if options.debug != 0 {
        print(options, to: &standardError)
    }

    execCommand(main, sub, options)
}

//
//  main.swift
//  csv2
//
//  Created by Michael Salmon on 2021-02-16.
//

import Foundation

let command = getCommand()
if command.isHelp {
    help(command)
    exit(0)
}

var options = Options()
do {
    try options.getOpts(for: command)
} catch {
    print(error, to: &standardError)
    exit(1)
}

var defaults = options.defaults()

if options.debug != 0 {
    print(options, to: &standardError)
}

execCommand(command, options)

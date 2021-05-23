//
//  List.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-23.
//

import Foundation

func list(_ command: ListCommandType) {
    switch command {
    case .bitmap:
        if CommandLine.arguments.count > 2 {
            print(bitmap(Array(CommandLine.arguments[2...])))
        }
    case .listColourNames:
        print(colourNames())
    case .listShapes:
        print(Shape.allNames())
    case .version:
        print("""
            \(AppInfo.name): \(AppInfo.version) (\(AppInfo.branch):\(AppInfo.build)) Built at \(AppInfo.builtAt)
            """,
            to: &standardError
        )
    }
}

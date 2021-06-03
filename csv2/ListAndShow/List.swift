//
//  List.swift
//  csv2
//
//  Created by Michael Salmon on 2021-05-23.
//

import Foundation

/// Handle the list commands
/// - Parameter command: Which list command

func list(_ command: ListCommandType) {
    switch command {
    case .listColourNames:
        print(colourNames())
    case .listJSON:
        print(jsonList())
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

/// Generate a JSON string with all usage
/// - Returns: JSON string

func jsonList() -> String {
    let encoder = JSONEncoder()
    let encodable = OptGetterEncodable()
    if let data = (try? encoder.encode(encodable)), let dataString = String(data: data, encoding: .utf8) {
        return dataString
    }
    return ""
}

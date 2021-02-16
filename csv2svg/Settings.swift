//
//  Settings.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-16.
//

import Foundation

class Settings {
    let plistURL: URL
    
    init(_ name: String) {
        plistURL = URL(fileURLWithPath: name)
    }
}

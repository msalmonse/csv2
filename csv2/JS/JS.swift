//
//  JS.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-07.
//

import Foundation

class JS: Plotter {
    let settings: Settings

    var ctx = CTX()

    init(_ settings: Settings) {
        self.settings = settings
    }
}

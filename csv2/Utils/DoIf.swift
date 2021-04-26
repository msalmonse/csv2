//
//  DoIf.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-26.
//

import Foundation

func doIf(_ cond: Bool, _ closure: () -> Void) {
    if cond {
        closure()
    }
}

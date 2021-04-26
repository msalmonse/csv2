//
//  Constraints.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-26.
//

import Foundation

extension Options {

    mutating func pieContraints() {
        xtick = -1
        ytick = -1
    }

    func constrained() -> Options {
        var defaults = self
        if pie { defaults.pieContraints() }
        return defaults
    }
}

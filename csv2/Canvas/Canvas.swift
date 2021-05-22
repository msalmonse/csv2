//
//  JS.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-07.
//

import Foundation

class Canvas: Plotter {
    // Canvas data
    var data = Data()

    let settings: Settings

    var ctx = CTX()

    var comment: String { """
            //  \(settings.comment)

        """
    }

    init(_ settings: Settings) {
        self.settings = settings
    }
}

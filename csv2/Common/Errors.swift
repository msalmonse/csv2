//
//  Errors.swift
//  csv2
//
//  Created by Michael Salmon on 2021-06-04.
//

import Foundation

struct ErrorMessage: LocalizedError {
    let message: String

    var errorDescription: String { return message }
}

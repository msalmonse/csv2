//
//  Path.swift
//  csv2
//
//  Created by Michael Salmon on 2021-04-21.
//

import Foundation

/// A list of PathComponent

struct Path {
    private(set) var components: [PathComponent]

    var count: Int { components.count }
    var isEmpty: Bool { components.isEmpty }
    var path: String { components.map { $0.path }.joined(separator: " ") }

    /// init with empty components

    init () {
        components = []
    }

    /// init with components
    /// - Parameter components: list of components

    init(_ components: [PathComponent]) {
        self.components = components
    }

    /// Add to path
    /// - Parameter component: component to add

    mutating func append(_ component: PathComponent) {
        components.append(component)
    }

    /// Add 2 path's
    /// - Parameters:
    ///   - left: first path
    ///   - right: second path
    /// - Returns: path sum

    static func + (left: Path, right: Path) -> Path {
        return Path(left.components + right.components)
    }
}

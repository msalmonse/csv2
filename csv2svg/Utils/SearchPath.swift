//
//  SearchPath.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-31.
//

import Foundation

extension URL {
    /// little sugar
    var exists: Bool {
        return FileManager.default.fileExists(atPath: self.path)
    }

    /// little sugar
    var isDirectory: Bool {
        var isDir: ObjCBool = false
        let exists = FileManager.default.fileExists(atPath: self.path, isDirectory: &isDir)
        return exists && isDir.boolValue
    }
}

struct SearchPath {
    static private var paths: [URL] = []

    /// Add url to search path
    /// - Parameter url: directory to search

    static func add(_ url: URL) {
        if url.isDirectory {
            paths.append(url)
        } else {
            paths.append(url.deletingLastPathComponent())
        }
    }

    /// Add url to search path
    /// - Parameter url: directory to search

    static func add(_ name: String) {
        add(URL(fileURLWithPath: name))
    }

    static func search(_ name: String) -> URL? {
        var url = URL(fileURLWithPath: name)
        if url.exists { return url }

        for path in paths {
            url = path.appendingPathComponent(name, isDirectory: false)
            if url.exists { return url }
        }

        return nil
    }
}

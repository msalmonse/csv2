//
//  BundledData.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-03-03.
//

import Foundation

// swiftlint:disable force_cast

/// Look upd data in info dictionary
/// - Parameter key: key to dictionary
/// - Returns: String from dictionary

func bundledData(key: String) -> String? {
    guard let object = Bundle.main.object(forInfoDictionaryKey: key) else { return nil }
    if object is String { return object as? String }
    if object is Int { return String(object as! Int) }

    return nil
}

/// Lookup keys in dictionary
/// - Returns: List of keys

func bundleKeys() -> [String]? {
    let info = Bundle.main.infoDictionary
    let list = info?.keys.sorted()

    return list
}

let appName = bundledData(key: "CFBundleName") ?? "csv2svg"
let appVersion = bundledData(key: "CFBundleShortVersionString") ?? ""
let appBuild = bundledData(key: "CFBundleVersion") ?? ""

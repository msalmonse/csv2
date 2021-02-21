//
//  Settings.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-16.
//

import Foundation

class Settings: Codable {
    // svg width and height
    let height: Int
    let width: Int
    
    // svg title
    let title: String
    
    // Index for x values in csv data
    let index: Int

    // convenience function to decode a keyed Int
    private static func keyedIntValue(
        from container: KeyedDecodingContainer<CodingKeys>?,
        forKey key: CodingKeys,
        defaultValue: Int
    ) -> Int {
        if (container == nil) { return defaultValue }
        return (try? container!.decodeIfPresent(Int.self, forKey: key)) ?? defaultValue
    }

    // convenience function to decode a keyed Int
    private static func keyedStringValue(
        from container: KeyedDecodingContainer<CodingKeys>?,
        forKey key: CodingKeys,
        defaultValue: String
    ) -> String {
        if (container == nil) { return defaultValue }
        return (try? container!.decodeIfPresent(String.self, forKey: key)) ?? defaultValue
    }

    required init(from decoder: Decoder) {
        let container = try? decoder.container(keyedBy: CodingKeys.self)

        height = Settings.keyedIntValue(from: container, forKey: .height, defaultValue: 500)
        index = Settings.keyedIntValue(from: container, forKey: .index, defaultValue: 0)
        title = Settings.keyedStringValue(from: container, forKey: .title, defaultValue: "")
        width = Settings.keyedIntValue(from: container, forKey: .width, defaultValue: 500)
    }

    static func load(_ name: String) throws -> Settings {
        let url = URL(fileURLWithPath: name)
        let data = (try? Data(contentsOf: url)) ?? Data()
        let decoder = JSONDecoder()
        let settings = try decoder.decode(Settings.self, from: data)
        return settings
    }
}

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
    
    // Header rows and columns
    let headerColumns: Int
    let headerRows: Int
    
    // Index for x values in csv data
    let index: Int

    // minimum and maximum for x and y axes
    // nil means not specified
    let xMax: Double?
    let xMin: Double?
    let yMax: Double?
    let yMin: Double?

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

        headerColumns = Self.keyedIntValue(from: container, forKey: .headerColumns, defaultValue: 0)
        headerRows = Self.keyedIntValue(from: container, forKey: .headerRows, defaultValue: 0)
        height = Self.keyedIntValue(from: container, forKey: .height, defaultValue: 500)
        index = Self.keyedIntValue(from: container, forKey: .index, defaultValue: 0)
        title = Self.keyedStringValue(from: container, forKey: .title, defaultValue: "")
        width = Self.keyedIntValue(from: container, forKey: .width, defaultValue: 500)
        xMax = try? container?.decodeIfPresent(Double.self, forKey: .xMax)
        xMin = try? container?.decodeIfPresent(Double.self, forKey: .xMin)
        yMax = try? container?.decodeIfPresent(Double.self, forKey: .yMax)
        yMin = try? container?.decodeIfPresent(Double.self, forKey: .yMin)
    }

    static func load(_ name: String) throws -> Settings {
        let url = URL(fileURLWithPath: name)
        let data = (try? Data(contentsOf: url)) ?? Data()
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(Settings.self, from: data)
        } catch {
            print(error)
            throw error
        }
    }
}

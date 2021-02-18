//
//  Settings.swift
//  csv2svg
//
//  Created by Michael Salmon on 2021-02-16.
//

import Foundation

// Default values for Settings
private struct Default {
    // svg width and height
    static let height = 500
    static let width = 500
    
    // svg title
    static let title = ""
}

class Settings: Codable {
    // svg width and height
    let height: Int
    let width: Int
    
    // svg title
    let title: String
    
    required init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            height = (try? container.decodeIfPresent(Int.self, forKey: .height)) ?? Default.height
            width = (try? container.decodeIfPresent(Int.self, forKey: .width)) ?? Default.width
            title = (try? container.decodeIfPresent(String.self, forKey: .title)) ?? Default.title
        } catch {
            print(error)
            throw(error)
        }
    }

    static func load(_ name: String) throws -> Settings {
        let url = URL(fileURLWithPath: name)
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let settings = try decoder.decode(Settings.self, from: data)
            return settings
        } catch {
            throw(error)
        }
    }
}

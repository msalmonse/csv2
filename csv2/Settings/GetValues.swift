//
//  GetValues.swift
//  csv2
//
//  Created by Michael Salmon on 2021-06-04.
//

import Foundation

extension Settings {
    static func getValues(from decoder: Decoder) throws -> SettingsValues {
        let container = try? decoder.container(keyedBy: CodingKeys.self)

        // Although this is a Defaults property it can be loaded from the JSON file
        defaults.bounded = Self.keyedBoolValue(from: container, forKey: .bounded, defaults: defaults)

        var values = SettingsValues()
        for key in CodingKeys.allCases {
            switch key.codingType {
            case .isBool:
                let val = Self.keyedBoolSettingsValue(from: container, forKey: key, defaults: defaults)
                values.setValue(key, val, in: key.domain)
            case .isDouble:
                let val = Self.keyedDoubleSettingsValue(from: container, forKey: key, defaults: defaults,
                                                        in: key.doubleBounds)
                values.setValue(key, val, in: key.domain)
            case .isInt:
                let val = Self.keyedIntSettingsValue(from: container, forKey: key, defaults: defaults,
                                                     in: key.intBounds)
                values.setValue(key, val, in: key.domain)
            case .isInt1:
                let val = Self.keyedInt1SettingsValue(from: container, forKey: key, defaults: defaults,
                                                      in: key.intBounds)
                values.setValue(key, val, in: key.domain)
            case .isString:
                let val = Self.keyedStringSettingsValue(from: container, forKey: key, defaults: defaults)
                values.setValue(key, val, in: key.domain)
            case .isStringArray:
                let val = Self.keyedStringArraySettingsValue(from: container, forKey: key, defaults: defaults)
                values.setValue(key, val, in: key.domain)
            case .isNone: break
            }
        }
        Self.loadForeground(from: container, defaults: defaults, into: &values)
        Self.loadPDF(from: container, defaults: defaults, into: &values)

        return values
    }
}

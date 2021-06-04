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

        do {
            var values = SettingsValues()
            for key in CodingKeys.allCases {
                switch key.codingType {
                case .isBitMap:
                    let val = try getBitMap(from: container, for: key, defaults: defaults)
                    values.setValue(key, .bitmapValue(val: val), in: key.domain)
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
        } catch {
            throw error
        }
    }
}

extension Settings {
    static func getBitMap(
        from container: KeyedDecodingContainer<CodingKeys>?,
        for key: CodingKeys,
        defaults: Defaults
    ) throws -> BitMap {
        // First check the defaults
        if container == nil || defaults.isOnCLI(key) {
            return defaults.bitmapValue(key)
        }

        let intValues = Self.keyedIntArray(from: container, forKey: key, defaults: defaults)
        var bitmap = BitMap.none
        var prev = 0
        for i in intValues {
            if bitmap.okWithOffset.contains(i) {
                bitmap.append(i)
                prev = 0
            } else if bitmap.okWithOffset.contains(-i) {
                for j in (prev + 1)...(-i) {
                    bitmap.append(j)
                }
                prev = -i
            } else {
                throw ErrorMessage(message: "Value \(i) is out of range for key: \(key.stringValue)")
            }
        }
        return bitmap
    }
}

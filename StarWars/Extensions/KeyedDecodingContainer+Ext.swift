//
//  KeyedDecodingContainer+Ext.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 17/03/2023.
//

import Foundation

extension KeyedDecodingContainer where Key: CodingKey {
    func decodeIntoClosedIntegerRange(_ type: String.Type, forKey key: Key) throws -> ClosedRange<Int> {
        let stringValue = try decode(type, forKey: key)
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: ",", with: "")

        if !stringValue.contains("-") {
            guard let integerValue = Int(stringValue) else {
                throw DecodingError.typeMismatch(
                    ClosedRange<Int>.self,
                    .init(codingPath: [key], debugDescription: "Failed to convert \(stringValue) to ClosedRange<Int>")
                )
            }

            return integerValue ... integerValue
        }

        guard let stringLowerBound = stringValue.split(separator: "-").first,
              let stringUpperBound = stringValue.split(separator: "-").last,
              let lowerBound = Int(stringLowerBound),
              let upperBound = Int(stringUpperBound) else {
            throw DecodingError.typeMismatch(
                ClosedRange<Int>.self,
                .init(codingPath: [key], debugDescription: "Failed to convert \(stringValue) to ClosedRange<Int>")
            )
        }

        return lowerBound ... upperBound
    }

    func decodeIntoFloat(_ type: String.Type, forKey key: Key) throws -> Float {
        let stringValue = try decode(type, forKey: key)
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: ",", with: "")

        guard let floatValue = Float(stringValue) else {
            throw DecodingError.typeMismatch(
                Float.self,
                .init(codingPath: [key], debugDescription: "Failed to convert \(stringValue) to Float")
            )
        }

        return floatValue
    }

    func decodeIntoDate(_ type: String.Type, forKey key: Key, using dateFormatter: DateFormatter) throws -> Date {
        let stringValue = try decode(type, forKey: key)

        guard let date = dateFormatter.date(from: stringValue) else {
            throw DecodingError.typeMismatch(
                Date.self,
                .init(codingPath: [key], debugDescription: "Failed to convert \(stringValue) to Date")
            )
        }

        return date
    }
}

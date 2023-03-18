//
//  KeyedEncodingContainer+Ext.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 18/03/2023.
//

import Foundation

extension KeyedEncodingContainer where Key: CodingKey {
    mutating func encodeIntoString(_ value: ClosedRange<Int>?, forKey key: Key) throws {
        guard let value = value else { try encode("unknown", forKey: key); return }
        let stringValue = "\(value.lowerBound)-\(value.upperBound)"
        try encode(stringValue, forKey: key)
    }
    
    mutating func encodeIntoString(_ value: (any LosslessStringConvertible)?, forKey key: Key) throws {
        guard let value = value else { try encode("unknown", forKey: key); return }
        let stringValue = String(value)
        try encode(stringValue, forKey: key)
    }
    
    mutating func encodeIntoString(_ value: Date?, forKey key: Key, using dateFormatter: DateFormatter) throws {
        guard let value = value else { try encode("unknown", forKey: key); return }
        let stringValue = dateFormatter.string(from: value)
        try encode(stringValue, forKey: key)
    }
}

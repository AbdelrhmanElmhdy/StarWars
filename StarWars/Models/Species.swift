//
//  Species.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 17/03/2023.
//

import Foundation

struct Species: Identifiable, Equatable {
    var id: Int { 1 }

    let name: String
    let classification: String
    let designation: String
    let averageHeight: Float?
    let skinColors: String
    let hairColors: String
    let eyeColors: String
    let averageLifespan: Float?
    let homeWorld: URL?
    let language: String
    let people: [URL]
    let films: [URL]
    let created: Date
    let edited: Date
    let url: URL
}

extension Species: Cacheable {
    var cacheKey: NSString { NSString(string: url.absoluteString) }
}

// Custom Codable conformance to take care of type conversions and snake-cased names.
extension Species: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case classification
        case designation
        case averageHeight = "average_height"
        case skinColors = "skin_colors"
        case hairColors = "hair_colors"
        case eyeColors = "eye_colors"
        case averageLifespan = "average_lifespan"
        case homeWorld = "homeworld"
        case language
        case people
        case films
        case created
        case edited
        case url
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decode(String.self, forKey: .name)
        classification = try container.decode(String.self, forKey: .classification)
        designation = try container.decode(String.self, forKey: .designation)
        averageHeight = try? container.decodeIntoFloat(String.self, forKey: .averageHeight)
        skinColors = try container.decode(String.self, forKey: .skinColors)
        hairColors = try container.decode(String.self, forKey: .hairColors)
        eyeColors = try container.decode(String.self, forKey: .eyeColors)
        averageLifespan = try? container.decodeIntoFloat(String.self, forKey: .averageLifespan)
        homeWorld = try container.decodeIfPresent(URL.self, forKey: .homeWorld)
        language = try container.decode(String.self, forKey: .language)
        people = try container.decode([URL].self, forKey: .people)
        films = try container.decode([URL].self, forKey: .films)
        created = try container.decodeIntoDate(String.self, forKey: .created, using: .iso8601)
        edited = try container.decodeIntoDate(String.self, forKey: .edited, using: .iso8601)
        url = try container.decode(URL.self, forKey: .url)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(name, forKey: .name)
        try container.encode(classification, forKey: .classification)
        try container.encode(designation, forKey: .designation)
        try container.encodeIntoString(averageHeight, forKey: .averageHeight)
        try container.encode(skinColors, forKey: .skinColors)
        try container.encode(hairColors, forKey: .hairColors)
        try container.encode(eyeColors, forKey: .eyeColors)
        try container.encodeIntoString(averageLifespan, forKey: .averageLifespan)
        try container.encode(homeWorld, forKey: .homeWorld)
        try container.encode(language, forKey: .language)
        try container.encode(people, forKey: .people)
        try container.encode(films, forKey: .films)
        try container.encodeIntoString(created, forKey: .created, using: DateFormatter.iso8601)
        try container.encodeIntoString(edited, forKey: .edited, using: DateFormatter.iso8601)
        try container.encode(url, forKey: .url)
    }
}

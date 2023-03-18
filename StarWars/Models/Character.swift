//
//  Character.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Foundation

struct Character: Identifiable, Equatable {
    var id: String { url.lastPathComponent }
    let name: String
    let height: Float?
    let mass: Float?
    let hairColor: String
    let skinColor: String
    let eyeColor: String
    let birthYear: String
    let gender: String
    let homeWorld: URL?
    let films: [URL]
    let species: [URL]
    let vehicles: [URL]
    let starships: [URL]
    let created: Date
    let edited: Date
    let url: URL
}

extension Character: Cacheable {
    var cacheKey: NSString { NSString(string: url.absoluteString) }
}

// Custom Codable conformance to take care of type conversions and snake-cased names.
extension Character: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case height
        case mass
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case gender
        case homeWorld = "homeworld"
        case films
        case species
        case vehicles
        case starships
        case created
        case edited
        case url
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decode(String.self, forKey: .name)
        height = try? container.decodeIntoFloat(String.self, forKey: .height)
        mass = try? container.decodeIntoFloat(String.self, forKey: .mass)
        hairColor = try container.decode(String.self, forKey: .hairColor)
        skinColor = try container.decode(String.self, forKey: .skinColor)
        eyeColor = try container.decode(String.self, forKey: .eyeColor)
        birthYear = try container.decode(String.self, forKey: .birthYear)
        gender = try container.decode(String.self, forKey: .gender)
        homeWorld = try container.decodeIfPresent(URL.self, forKey: .homeWorld)
        films = try container.decode([URL].self, forKey: .films)
        species = try container.decode([URL].self, forKey: .species)
        vehicles = try container.decode([URL].self, forKey: .vehicles)
        starships = try container.decode([URL].self, forKey: .starships)
        created = try container.decodeIntoDate(String.self, forKey: .created, using: .iso8601)
        edited = try container.decodeIntoDate(String.self, forKey: .edited, using: .iso8601)
        url = try container.decode(URL.self, forKey: .url)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(name, forKey: .name)
        try container.encodeIntoString(height, forKey: .height)
        try container.encodeIntoString(mass, forKey: .mass)
        try container.encode(hairColor, forKey: .hairColor)
        try container.encode(skinColor, forKey: .skinColor)
        try container.encode(eyeColor, forKey: .eyeColor)
        try container.encode(birthYear, forKey: .birthYear)
        try container.encode(gender, forKey: .gender)
        try container.encode(homeWorld, forKey: .homeWorld)
        try container.encode(films, forKey: .films)
        try container.encode(species, forKey: .species)
        try container.encode(vehicles, forKey: .vehicles)
        try container.encode(starships, forKey: .starships)
        try container.encodeIntoString(created, forKey: .created, using: DateFormatter.iso8601)
        try container.encodeIntoString(edited, forKey: .edited, using: DateFormatter.iso8601)
        try container.encode(url, forKey: .url)
    }
}

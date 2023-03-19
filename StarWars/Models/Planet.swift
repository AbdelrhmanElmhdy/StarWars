//
//  Planet.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Foundation
import UIKit

struct Planet: Identifiable, Equatable {
    var id: String { url.lastPathComponent }
    var image: UIImage?
    let name: String
    let rotationPeriod: String
    let orbitalPeriod: String
    let diameter: Float?
    let climate: String
    let gravity: String
    let terrain: String
    let surfaceWater: Float?
    let population: Int?
    let residents: [URL]
    let films: [URL]
    let created: Date
    let edited: Date
    let url: URL
}

extension Planet: CardPresentable {
    static let title = "Planets".localized
    var title: String { name }

    var referencedCards: [CardsReference] {
        [
            CardsReference(referenceTitle: Character.title, ids: residents.compactMap { Int($0.lastPathComponent) }),
            CardsReference(referenceTitle: Film.title, ids: films.compactMap { Int($0.lastPathComponent) }),
        ]
    }

    var info: [String: String] {
        var info = [
            "Name".localized: name,
            "Rotation Period".localized: rotationPeriod,
            "Orbital Period".localized: orbitalPeriod,
            "Climate".localized: climate,
            "Gravity".localized: gravity,
            "Terrain".localized: terrain,
        ]

        if let diameter = diameter {
            info["Diameter".localized] = String(diameter)
        }

        if let surfaceWater = surfaceWater {
            info["Surface Water".localized] = String(surfaceWater)
        }

        if let population = population {
            info["Population".localized] = String(population)
        }

        return info
    }
}

extension Planet: Cacheable {
    var cacheKey: NSString { NSString(string: url.absoluteString) }
}

// Custom Codable conformance to take care of type conversions and snake-cased names.
extension Planet: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter
        case climate
        case gravity
        case terrain
        case surfaceWater = "surface_water"
        case population
        case residents
        case films
        case created
        case edited
        case url
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decode(String.self, forKey: .name)
        rotationPeriod = try container.decode(String.self, forKey: .rotationPeriod)
        orbitalPeriod = try container.decode(String.self, forKey: .orbitalPeriod)
        diameter = try? container.decodeIntoFloat(String.self, forKey: .diameter)
        climate = try container.decode(String.self, forKey: .climate)
        gravity = try container.decode(String.self, forKey: .gravity)
        terrain = try container.decode(String.self, forKey: .terrain)
        surfaceWater = try? container.decodeIntoFloat(String.self, forKey: .surfaceWater)
        population = try? Int(container.decodeIntoFloat(String.self, forKey: .population))
        residents = try container.decode([URL].self, forKey: .residents)
        films = try container.decode([URL].self, forKey: .films)
        created = try container.decodeIntoDate(String.self, forKey: .created, using: .iso8601)
        edited = try container.decodeIntoDate(String.self, forKey: .edited, using: .iso8601)
        url = try container.decode(URL.self, forKey: .url)

        if let id = Int(id) {
            image = .getPlanetImage(ofID: id)
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(name, forKey: .name)
        try container.encode(rotationPeriod, forKey: .rotationPeriod)
        try container.encode(orbitalPeriod, forKey: .orbitalPeriod)
        try container.encodeIntoString(diameter, forKey: .diameter)
        try container.encode(climate, forKey: .climate)
        try container.encode(gravity, forKey: .gravity)
        try container.encode(terrain, forKey: .terrain)
        try container.encodeIntoString(surfaceWater, forKey: .surfaceWater)
        try container.encodeIntoString(population, forKey: .population)
        try container.encode(residents, forKey: .residents)
        try container.encode(films, forKey: .films)
        try container.encodeIntoString(created, forKey: .created, using: DateFormatter.iso8601)
        try container.encodeIntoString(edited, forKey: .edited, using: DateFormatter.iso8601)
        try container.encode(url, forKey: .url)
    }
}

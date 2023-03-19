//
//  Address.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Foundation
import UIKit

struct Film: Identifiable, Equatable {
    var id: String { url.lastPathComponent }
    var image: UIImage?
    let title: String
    let episodeId: Int
    let openingCrawl: String
    let director: String
    let producer: String
    let releaseDate: Date
    let characters: [URL]
    let planets: [URL]
    let starships: [URL]
    let vehicles: [URL]
    let species: [URL]
    let created: Date
    let edited: Date
    let url: URL
}

extension Film: CardPresentable {
    static let title = "Films".localized

    var referencedCards: [CardsReference] {
        [
            CardsReference(referenceTitle: Character.title, ids: characters.compactMap { Int($0.lastPathComponent) }),
            CardsReference(referenceTitle: Planet.title, ids: planets.compactMap { Int($0.lastPathComponent) }),
            CardsReference(referenceTitle: Species.title, ids: species.compactMap { Int($0.lastPathComponent) }),
            CardsReference(referenceTitle: Vehicle.title, ids: vehicles.compactMap { Int($0.lastPathComponent) }),
            CardsReference(referenceTitle: Spaceship.title, ids: starships.compactMap { Int($0.lastPathComponent) }),
        ]
    }

    var info: [String: String] {
        let info = [
            "Title".localized: title,
            "Episode Id".localized: String(episodeId),
            "Opening Crawl".localized: openingCrawl,
            "Director".localized: director,
            "Producer".localized: producer,
            "Release Date".localized: DateFormatter.localizedString(from: releaseDate, dateStyle: .medium, timeStyle: .none),
        ]

        return info
    }
}

extension Film: Cacheable {
    var cacheKey: NSString { NSString(string: url.absoluteString) }
}

// Custom Codable conformance to take care of type conversions and snake-cased names.
extension Film: Codable {
    enum CodingKeys: String, CodingKey {
        case title
        case episodeId = "episode_id"
        case openingCrawl = "opening_crawl"
        case director
        case producer
        case releaseDate = "release_date"
        case characters
        case planets
        case starships
        case vehicles
        case species
        case created
        case edited
        case url
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        title = try container.decode(String.self, forKey: .title)
        episodeId = try container.decode(Int.self, forKey: .episodeId)
        openingCrawl = try container.decode(String.self, forKey: .openingCrawl)
        director = try container.decode(String.self, forKey: .director)
        producer = try container.decode(String.self, forKey: .producer)
        releaseDate = try container.decodeIntoDate(String.self,
                                                   forKey: .releaseDate,
                                                   using: .yearMonthDayDateFormatter)
        characters = try container.decode([URL].self, forKey: .characters)
        planets = try container.decode([URL].self, forKey: .planets)
        starships = try container.decode([URL].self, forKey: .starships)
        vehicles = try container.decode([URL].self, forKey: .vehicles)
        species = try container.decode([URL].self, forKey: .species)
        created = try container.decodeIntoDate(String.self, forKey: .created, using: .iso8601)
        edited = try container.decodeIntoDate(String.self, forKey: .edited, using: .iso8601)
        url = try container.decode(URL.self, forKey: .url)

        if let id = Int(id) {
            image = .getFilmImage(ofID: id)
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(title, forKey: .title)
        try container.encode(episodeId, forKey: .episodeId)
        try container.encode(openingCrawl, forKey: .openingCrawl)
        try container.encode(director, forKey: .director)
        try container.encode(producer, forKey: .producer)
        try container.encodeIntoString(releaseDate, forKey: .releaseDate, using: DateFormatter.yearMonthDayDateFormatter)
        try container.encode(characters, forKey: .characters)
        try container.encode(planets, forKey: .planets)
        try container.encode(starships, forKey: .starships)
        try container.encode(vehicles, forKey: .vehicles)
        try container.encode(species, forKey: .species)
        try container.encodeIntoString(created, forKey: .created, using: DateFormatter.iso8601)
        try container.encodeIntoString(edited, forKey: .edited, using: DateFormatter.iso8601)
        try container.encode(url, forKey: .url)
    }
}

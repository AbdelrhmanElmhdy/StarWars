//
//  Spaceship.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Foundation
import UIKit

struct Spaceship: Identifiable, Equatable {
    var id: String { url.lastPathComponent }
    var image: UIImage?
    let name: String
    let model: String
    let manufacturer: String
    let costInCredits: Float?
    let length: Float?
    let maxAtmospheringSpeed: String
    let crew: ClosedRange<Int>?
    let passengers: Int?
    let cargoCapacity: Float?
    let consumables: String
    let hyperdriveRating: Float?
    let MGLT: Int?
    let starshipClass: String
    let pilots: [URL]
    let films: [URL]
    let created: Date
    let edited: Date
    let url: URL
}

extension Spaceship: CardPresentable {
    static let title = "Spaceships".localized
    var title: String { name }

    var referencedCards: [CardsReference] {
        [
            CardsReference(referenceTitle: Character.title, ids: pilots.compactMap { Int($0.lastPathComponent) }),
            CardsReference(referenceTitle: Film.title, ids: films.compactMap { Int($0.lastPathComponent) }),
        ]
    }

    var info: [String: String] {
        var info = [
            "Name".localized: name,
            "Model".localized: model,
            "Manufacturer".localized: manufacturer,
            "Max Atmosphering Speed".localized: maxAtmospheringSpeed,
            "Consumables".localized: consumables,
            "Vehicle Class".localized: starshipClass,
        ]

        if let costInCredits = costInCredits {
            info["CostInCredits".localized] = String(costInCredits)
        }

        if let crew = crew {
            let stringCrew: String
            if crew.lowerBound == crew.upperBound {
                stringCrew = String(crew.lowerBound)
            } else {
                stringCrew = "\(crew.lowerBound)-\(crew.upperBound)"
            }
            info["Crew".localized] = stringCrew
        }

        if let cargoCapacity = cargoCapacity {
            info["Cargo Capacity".localized] = String(cargoCapacity)
        }

        if let passengers = passengers {
            info["Passengers".localized] = String(passengers)
        }

        if let hyperdriveRating = hyperdriveRating {
            info["Hyperdrive Rating".localized] = String(hyperdriveRating)
        }

        if let MGLT = MGLT {
            info["MGLT".localized] = String(MGLT)
        }

        return info
    }
}

extension Spaceship: Cacheable {
    var cacheKey: NSString { NSString(string: url.absoluteString) }
}

// Custom Codable conformance to take care of type conversions and snake-cased names.
extension Spaceship: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case model
        case manufacturer
        case costInCredits = "cost_in_credits"
        case length
        case maxAtmospheringSpeed = "max_atmosphering_speed"
        case crew
        case passengers
        case cargoCapacity = "cargo_capacity"
        case consumables
        case hyperdriveRating = "hyperdrive_rating"
        case MGLT
        case starshipClass = "starship_class"
        case pilots
        case films
        case created
        case edited
        case url
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decode(String.self, forKey: .name)
        model = try container.decode(String.self, forKey: .model)
        manufacturer = try container.decode(String.self, forKey: .manufacturer)
        costInCredits = try? container.decodeIntoFloat(String.self, forKey: .costInCredits)
        length = try? container.decodeIntoFloat(String.self, forKey: .length)
        maxAtmospheringSpeed = try container.decode(String.self, forKey: .maxAtmospheringSpeed)
        crew = try? container.decodeIntoClosedIntegerRange(String.self, forKey: .crew)
        passengers = try? Int(container.decodeIntoFloat(String.self, forKey: .passengers))
        cargoCapacity = try? container.decodeIntoFloat(String.self, forKey: .cargoCapacity)
        consumables = try container.decode(String.self, forKey: .consumables)
        hyperdriveRating = try? container.decodeIntoFloat(String.self, forKey: .hyperdriveRating)
        MGLT = try? Int(container.decodeIntoFloat(String.self, forKey: .MGLT))
        starshipClass = try container.decode(String.self, forKey: .starshipClass)
        pilots = try container.decode([URL].self, forKey: .pilots)
        films = try container.decode([URL].self, forKey: .films)
        created = try container.decodeIntoDate(String.self, forKey: .created, using: .iso8601)
        edited = try container.decodeIntoDate(String.self, forKey: .edited, using: .iso8601)
        url = try container.decode(URL.self, forKey: .url)

        if let id = Int(id) {
            image = .getSpaceshipImage(ofID: id)
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(name, forKey: .name)
        try container.encode(model, forKey: .model)
        try container.encode(manufacturer, forKey: .manufacturer)
        try container.encodeIntoString(costInCredits, forKey: .costInCredits)
        try container.encodeIntoString(length, forKey: .length)
        try container.encode(maxAtmospheringSpeed, forKey: .maxAtmospheringSpeed)
        try container.encodeIntoString(crew, forKey: .crew)
        try container.encode(passengers, forKey: .passengers)
        try container.encodeIntoString(cargoCapacity, forKey: .cargoCapacity)
        try container.encode(consumables, forKey: .consumables)
        try container.encodeIntoString(hyperdriveRating, forKey: .hyperdriveRating)
        try container.encodeIntoString(MGLT, forKey: .MGLT)
        try container.encode(starshipClass, forKey: .starshipClass)
        try container.encode(pilots, forKey: .pilots)
        try container.encode(films, forKey: .films)
        try container.encodeIntoString(created, forKey: .created, using: DateFormatter.iso8601)
        try container.encodeIntoString(edited, forKey: .edited, using: DateFormatter.iso8601)
        try container.encode(url, forKey: .url)
    }
}

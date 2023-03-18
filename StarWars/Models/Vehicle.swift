//
//  Vehicle.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 17/03/2023.
//

import Foundation

struct Vehicle: Identifiable, Equatable {
    var id: Int { 1 }

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
    let vehicleClass: String
    let pilots: [URL]
    let films: [URL]
    let created: Date
    let edited: Date
    let url: URL
}

extension Vehicle: Cacheable {
    var cacheKey: NSString { NSString(string: url.absoluteString) }
}

// Custom Codable conformance to take care of type conversions and snake-cased names.
extension Vehicle: Codable {
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
        case vehicleClass = "vehicle_class"
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
        vehicleClass = try container.decode(String.self, forKey: .vehicleClass)
        pilots = try container.decode([URL].self, forKey: .pilots)
        films = try container.decode([URL].self, forKey: .films)
        created = try container.decodeIntoDate(String.self, forKey: .created, using: .iso8601)
        edited = try container.decodeIntoDate(String.self, forKey: .edited, using: .iso8601)
        url = try container.decode(URL.self, forKey: .url)
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
        try container.encode(vehicleClass, forKey: .vehicleClass)
        try container.encode(pilots, forKey: .pilots)
        try container.encode(films, forKey: .films)
        try container.encodeIntoString(created, forKey: .created, using: DateFormatter.iso8601)
        try container.encodeIntoString(edited, forKey: .edited, using: DateFormatter.iso8601)
        try container.encode(url, forKey: .url)
    }
}

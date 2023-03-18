//
//  SWAPIEndpoint.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Foundation

enum SWAPIEndpoint: RemoteEndpoint {
    case planets(page: Int = 1)
    case planet(id: Int)

    case spaceships(page: Int = 1)
    case spaceship(id: Int)

    case vehicles(page: Int = 1)
    case vehicle(id: Int)

    case people(page: Int = 1)
    case person(id: Int)

    case films(page: Int = 1)
    case film(id: Int)

    case species(page: Int = 1)
    case oneSpecies(id: Int)

    var baseUrl: URL { URL(string: "https://swapi.dev/api/")! }

    var path: String {
        switch self {
        case .planets: return "planets/"
        case let .planet(id): return "planets/\(id)"

        case .spaceships: return "starships/"
        case let .spaceship(id): return "starships/\(id)"

        case .vehicles: return "vehicles/"
        case let .vehicle(id): return "vehicles/\(id)"

        case .people: return "people/"
        case let .person(id): return "people/\(id)"

        case .films: return "films/"
        case let .film(id): return "films/\(id)"

        case .species: return "species/"
        case let .oneSpecies(id): return "species/\(id)"
        }
    }

    var httpMethod: HTTPMethod { .get }

    var bodyParameters: RequestParameters? { nil }

    var urlParameters: RequestParameters? {
        switch self {
        case let .planets(page),
             let .spaceships(page),
             let .vehicles(page),
             let .people(page),
             let .films(page),
             let .species(page):
            return ["page": page]
        default: return nil
        }
    }

    var headers: HTTPHeaders? { ["Content-Type": "application/json"] }

    var connectedCachePolicy: URLRequest.CachePolicy {
        .reloadRevalidatingCacheData
    }

    var noConnectionCachePolicy: URLRequest.CachePolicy {
        .returnCacheDataElseLoad
    }
}

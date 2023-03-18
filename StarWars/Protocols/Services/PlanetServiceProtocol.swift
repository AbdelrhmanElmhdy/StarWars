//
//  PlanetServiceProtocol.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Combine

/// Handles all services related to the `Planet` type
protocol PlanetServiceProtocol: IdtenfiableNetworkFetchingService,
    PaginatedNetworkFetchingService,
    CachingService,
    AutoMockable {
    associatedtype ServicedType = Planet
}

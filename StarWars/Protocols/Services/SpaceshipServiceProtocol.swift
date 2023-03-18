//
//  SpaceshipServiceProtocol.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Combine

/// Handles all services related to the `Spaceship` type
protocol SpaceshipServiceProtocol: IdtenfiableNetworkFetchingService,
    PaginatedNetworkFetchingService,
    CachingService,
    AutoMockable {
    associatedtype ServicedType = Spaceship
}

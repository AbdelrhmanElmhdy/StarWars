//
//  VehicleServiceProtocol.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Combine

/// Handles all services related to the `Vehicle` type
protocol VehicleServiceProtocol: IdtenfiableNetworkFetchingService,
    PaginatedNetworkFetchingService,
    CachingService,
    AutoMockable {
    associatedtype ServicedType = Vehicle
}

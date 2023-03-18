//
//  FilmServiceProtocol.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Combine

/// Handles all services related to the `FilmServiceProtocol` type
protocol FilmServiceProtocol: IdtenfiableNetworkFetchingService,
    PaginatedNetworkFetchingService,
    CachingService,
    AutoMockable {
    associatedtype ServicedType = Film
}

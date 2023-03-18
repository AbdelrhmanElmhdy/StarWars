//
//  PlanetService.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Combine
import Foundation

class PlanetService: PlanetServiceProtocol {
    let cache: NSCache<NSString, NSData>
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol, cache: NSCache<NSString, NSData>) {
        self.networkManager = networkManager
        self.cache = cache
    }

    func fetchFromServer(withID id: Int) -> AnyPublisher<Planet, NetworkRequestError> {
        networkManager.executeRequest(SWAPIEndpoint.planet(id: id))
            .map { [weak self] in self?.storeInCache($0); return $0 }.eraseToAnyPublisher()
    }

    func fetchAllFromServer(inPage page: Int = 1) -> AnyPublisher<PaginatedResponse<Planet>, NetworkRequestError> {
        let publisher: AnyPublisher<PaginatedResponse<Planet>, NetworkRequestError> = networkManager.executeRequest(SWAPIEndpoint.planets(page: page))

        return publisher.map { [weak self] in
            for planet in $0.results {
                self?.storeInCache(planet)
            }
            return $0
        }.eraseToAnyPublisher()
    }
}

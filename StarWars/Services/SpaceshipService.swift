//
//  SpaceshipService.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Combine
import Foundation

class SpaceshipService: SpaceshipServiceProtocol {
    let cache: NSCache<NSString, NSData>
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol, cache: NSCache<NSString, NSData>) {
        self.networkManager = networkManager
        self.cache = cache
    }

    func fetchFromServer(withID id: Int) -> AnyPublisher<Spaceship, NetworkRequestError> {
        networkManager.executeRequest(SWAPIEndpoint.spaceship(id: id))
            .map { [weak self] in self?.storeInCache($0); return $0 }.eraseToAnyPublisher()
    }

    func fetchAllFromServer(inPage page: Int = 1) -> AnyPublisher<PaginatedResponse<Spaceship>, NetworkRequestError> {
        let publisher: AnyPublisher<PaginatedResponse<Spaceship>, NetworkRequestError> = networkManager.executeRequest(SWAPIEndpoint.spaceships(page: page))

        return publisher.map { [weak self] in
            for spaceship in $0.results {
                self?.storeInCache(spaceship)
            }
            return $0
        }.eraseToAnyPublisher()
    }
}

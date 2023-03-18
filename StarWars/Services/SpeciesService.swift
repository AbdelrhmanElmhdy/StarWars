//
//  SpeciesService.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Combine
import Foundation

class SpeciesService: SpeciesServiceProtocol {
    let cache: NSCache<NSString, NSData>
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol, cache: NSCache<NSString, NSData>) {
        self.networkManager = networkManager
        self.cache = cache
    }

    func fetchFromServer(withID id: Int) -> AnyPublisher<Species, NetworkRequestError> {
        networkManager.executeRequest(SWAPIEndpoint.oneSpecies(id: id))
            .map { [weak self] in self?.storeInCache($0); return $0 }.eraseToAnyPublisher()
    }

    func fetchAllFromServer(inPage page: Int = 1) -> AnyPublisher<PaginatedResponse<Species>, NetworkRequestError> {
        let publisher: AnyPublisher<PaginatedResponse<Species>, NetworkRequestError> = networkManager.executeRequest(SWAPIEndpoint.species(page: page))

        return publisher.map { [weak self] in
            for species in $0.results {
                self?.storeInCache(species)
            }
            return $0
        }.eraseToAnyPublisher()
    }
}

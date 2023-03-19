//
//  FilmService.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Combine
import Foundation

class FilmService: FilmServiceProtocol {
    let cache: NSCache<NSString, NSData>
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol, cache: NSCache<NSString, NSData>) {
        self.networkManager = networkManager
        self.cache = cache
    }

    func fetchFromServer(withID id: Int) -> AnyPublisher<Film, NetworkRequestError> {
//        return networkManager.executeRequest(SWAPIEndpoint.film(id: id))
        let endpoint = SWAPIEndpoint.film(id: id)

        // If the object of the specified ID is already cached in memory return the cached response.
        if let urlString = endpoint.url?.absoluteString,
           let cachedResponse = fetchFromCache(forKey: NSString(string: urlString)) {
            let passThroughSubject = PassthroughSubject<Film, NetworkRequestError>()
            let publisher = passThroughSubject.eraseToAnyPublisher()
            passThroughSubject.send(cachedResponse)

            return publisher
        }

        return networkManager.executeRequest(endpoint)
            .map { [weak self] in
                self?.storeInCache($0)
                return $0
            }.eraseToAnyPublisher()
    }

    func fetchAllFromServer(inPage page: Int = 1) -> AnyPublisher<PaginatedResponse<Film>, NetworkRequestError> {
        let publisher: AnyPublisher<PaginatedResponse<Film>, NetworkRequestError> = networkManager.executeRequest(SWAPIEndpoint.films(page: page))

        return publisher.map { [weak self] in
            for film in $0.results {
                self?.storeInCache(film)
            }
            return $0
        }.eraseToAnyPublisher()
    }
}

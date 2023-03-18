//
//  CharacterService.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Combine
import Foundation

class CharacterService: CharacterServiceProtocol {
    let cache: NSCache<NSString, NSData>

    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol, cache: NSCache<NSString, NSData>) {
        self.networkManager = networkManager
        self.cache = cache
    }

    func fetchFromServer(withID id: Int) -> AnyPublisher<Character, NetworkRequestError> {
        networkManager.executeRequest(SWAPIEndpoint.person(id: id))
            .map { [weak self] in self?.storeInCache($0); return $0 }.eraseToAnyPublisher()
    }

    func fetchAllFromServer(inPage page: Int = 1) -> AnyPublisher<PaginatedResponse<Character>, NetworkRequestError> {
        let publisher: AnyPublisher<PaginatedResponse<Character>, NetworkRequestError> = networkManager.executeRequest(SWAPIEndpoint.people(page: page))

        return publisher.map { [weak self] in
            for character in $0.results {
                self?.storeInCache(character)
            }
            return $0
        }.eraseToAnyPublisher()
    }
}

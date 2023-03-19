//
//  CharacterServiceProtocol.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Combine
import Foundation

/// Handles all services related to the `Character` type
protocol CharacterServiceProtocol: IdtenfiableNetworkFetchingService,
    PaginatedNetworkFetchingService,
    CachingService,
    AutoMockable {
    associatedtype ServicedType = Character
//    func fetchFromServer(withID id: Int) -> AnyPublisher<Character, NetworkRequestError>
//    func fetchAllFromServer(inPage page: Int) -> AnyPublisher<PaginatedResponse<Character>, NetworkRequestError>
//    func fetchFromCache(forKey key: NSString) -> Character?
//    func storeInCache(_ value: Character)
}

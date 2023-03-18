//
//  NetworkFetchingService.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 16/03/2023.
//

import Combine
import Foundation

protocol IdtenfiableNetworkFetchingService {
    associatedtype ServicedType: Identifiable, Decodable

    func fetchFromServer(withID id: Int) -> AnyPublisher<ServicedType, NetworkRequestError>
}

protocol PaginatedNetworkFetchingService {
    associatedtype ServicedType: Codable

    func fetchAllFromServer(inPage page: Int) -> AnyPublisher<PaginatedResponse<ServicedType>, NetworkRequestError>
}

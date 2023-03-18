//
//  VehicleService.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Combine
import Foundation

class VehicleService: VehicleServiceProtocol {
    let cache: NSCache<NSString, NSData>
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol, cache: NSCache<NSString, NSData>) {
        self.networkManager = networkManager
        self.cache = cache
    }

    func fetchFromServer(withID id: Int) -> AnyPublisher<Vehicle, NetworkRequestError> {
        networkManager.executeRequest(SWAPIEndpoint.vehicle(id: id))
            .map { [weak self] in self?.storeInCache($0); return $0 }.eraseToAnyPublisher()
    }

    func fetchAllFromServer(inPage page: Int = 1) -> AnyPublisher<PaginatedResponse<Vehicle>, NetworkRequestError> {
        let publisher: AnyPublisher<PaginatedResponse<Vehicle>, NetworkRequestError> = networkManager.executeRequest(SWAPIEndpoint.vehicles(page: page))

        return publisher.map { [weak self] in
            for vehicle in $0.results {
                self?.storeInCache(vehicle)
            }
            return $0
        }.eraseToAnyPublisher()
    }
}

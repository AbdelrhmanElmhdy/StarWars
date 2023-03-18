//
//  NetworkManagerProtocol.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Combine

protocol NetworkManagerProtocol: AutoMockable {
    func executeRequest<T: Decodable>(_ target: any RemoteEndpoint) -> AnyPublisher<T, NetworkRequestError>
}

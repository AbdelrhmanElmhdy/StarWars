//
//  NetworkManagerFactory.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Foundation

class NetworkManagerFactory {
    static func make(context: ENV.Context? = nil) -> NetworkManagerProtocol {
        let context = context ?? ENV.context
        return context == .test
        ? NetworkManager()
        : NetworkManager()
    }
}

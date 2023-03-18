//
//  UserDefaultsManagerFactory.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Foundation

class UserDefaultsManagerFactory {
    static func make(context: ENV.Context? = nil) -> UserDefaultsManagerProtocol {
        let context = context ?? ENV.context
        return context == .test ? UserDefaultsManagerMock() : UserDefaultsManager()
    }
}

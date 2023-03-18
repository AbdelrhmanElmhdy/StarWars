//
//  UserDefaultsManagerMock.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Foundation

/// Replaces user defaults persistence with in-memory persistence
class UserDefaultsManagerMock: UserDefaultsManagerProtocol {
    var userPreferences = UserPreferences.defaultPreferences
}

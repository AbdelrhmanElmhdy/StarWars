//
//  UserPreferencesService.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import UIKit

class UserPreferencesService: UserPreferencesServiceProtocol {
    var userDefaultsManager: UserDefaultsManagerProtocol

    var userPreferences: UserPreferences

    init(userDefaultsManager: UserDefaultsManagerProtocol) {
        self.userDefaultsManager = userDefaultsManager
        userPreferences = userDefaultsManager.userPreferences
    }

    func updateUserInterfaceStyle(with state: UIUserInterfaceStyle) {
        userPreferences.userInterfaceStyle = state
        saveChanges()
    }

    func saveChanges() {
        userDefaultsManager.userPreferences = userPreferences
    }
}

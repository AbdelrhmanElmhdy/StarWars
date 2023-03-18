//
//  SettingsViewModel.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import UIKit

class SettingsViewModel {
    private let userPreferencesService: UserPreferencesServiceProtocol

    init(userPreferencesService: UserPreferencesServiceProtocol) {
        self.userPreferencesService = userPreferencesService
    }

    func selectUserInterfaceStyle(_ selectedStyle: UIUserInterfaceStyle?) {
        guard let selectedStyle = selectedStyle else { return }
        userPreferencesService.updateUserInterfaceStyle(with: selectedStyle)

        guard let window = UIApplication.shared.keyWindow else { return }

        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve) {
            window.overrideUserInterfaceStyle = selectedStyle
        }
    }
}

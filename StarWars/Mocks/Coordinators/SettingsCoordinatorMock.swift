//
//  SettingsStackCoordinatorMock.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import UIKit

class SettingsStackCoordinatorMock: Coordinator, DisclosingSettings {
    var children = [Coordinator]()
    let navigationController = UINavigationController()

    func start() {
    }

    func disclose(_ settingsDisclosureOption: SettingsDisclosureOption) {
    }
}

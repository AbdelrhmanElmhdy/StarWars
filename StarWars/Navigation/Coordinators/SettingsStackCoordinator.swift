//
//  SettingsStackCoordinator.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import UIKit

class SettingsStackCoordinator: Coordinator, DisclosingSettings {
    var children = [Coordinator]()
    let navigationController: UINavigationController
    let viewControllersFactory: ViewControllersFactory
    private let parentCoordinator: Coordinator

    init(navigationController: UINavigationController,
         viewControllersFactory: ViewControllersFactory,
         parentCoordinator: Coordinator) {
        self.navigationController = navigationController
        self.viewControllersFactory = viewControllersFactory
        self.parentCoordinator = parentCoordinator
    }

    func start() {
        let viewController = viewControllersFactory.makeSettingsViewController(for: self, settingsSections: nil)
        viewController.title = .ui.settings
        navigationController.pushViewController(viewController, animated: false)
    }

    func disclose(_ settingsDisclosureOption: SettingsDisclosureOption) {
        guard !settingsDisclosureOption.children.isEmpty else { return }

        let settingsSections = settingsDisclosureOption.children
        let viewController = viewControllersFactory.makeSettingsViewController(for: self, settingsSections: settingsSections)
        viewController.title = settingsDisclosureOption.label
        viewController.hidesBottomBarWhenPushed = true

        navigationController.pushViewController(viewController, animated: true)
    }
}

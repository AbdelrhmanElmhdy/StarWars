//
//  TabBarCoordinator.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import UIKit

class TabBarCoordinator: Coordinator {
    var children = [Coordinator]()
    let navigationController: UINavigationController
    let viewControllersFactory: ViewControllersFactory
    var rootTabBarController: RootTabBarController!

    init(navigationController: UINavigationController, viewControllersFactory: ViewControllersFactory) {
        self.navigationController = navigationController
        self.viewControllersFactory = viewControllersFactory
        rootTabBarController = RootTabBarController(coordinator: self)
    }

    func start() {
        let (homeNavigationController, settingsNavigationController) = createNavControllersForTabs()

        rootTabBarController.viewControllers = [
            homeNavigationController,
            settingsNavigationController,
        ]

        let homeStackCoordinator = HomeStackCoordinator(navigationController: homeNavigationController,
                                                        viewControllersFactory: viewControllersFactory,
                                                        parentCoordinator: self)

        let settingsStackCoordinator = SettingsStackCoordinator(navigationController: settingsNavigationController,
                                                                viewControllersFactory: viewControllersFactory,
                                                                parentCoordinator: self)

        startChild(homeStackCoordinator)
        startChild(settingsStackCoordinator)

        navigationController.pushViewController(rootTabBarController, animated: false)
    }

    /// Instantiate and customize a navigation controller for each tab.
    private func createNavControllersForTabs() -> (
        homeNavigationController: UINavigationController,
        settingsNavigationController: UINavigationController
    ) {
        let homeNavigationController = UINavigationController()
        homeNavigationController.tabBarItem = UITabBarItem(
            title: .ui.home,
            image: .homeIcon,
            tag: 0
        )

        let settingsNavigationController = UINavigationController()
        settingsNavigationController.tabBarItem = UITabBarItem(
            title: .ui.settings,
            image: .gear,
            tag: 1
        )

        return (homeNavigationController, settingsNavigationController)
    }
}

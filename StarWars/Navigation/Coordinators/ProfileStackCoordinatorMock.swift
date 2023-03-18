//
//  HomeStackCoordinator.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import UIKit

class HomeStackCoordinator: Coordinator {
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
        let viewController = viewControllersFactory.makeHomeViewController(for: self)
        navigationController.pushViewController(viewController, animated: false)
    }
}

//
//  HomeStackCoordinator.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import UIKit

class HomeStackCoordinator: Coordinator, ViewingCard, ViewingAllCards {
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

    func viewCard(_ card: CardPresentable, referencesFetcher: @escaping GenericCardReferencesFetcher) {
        let viewController = viewControllersFactory.makeCardDetailsViewController(
            for: self,
            card: card,
            referencesFetcher: referencesFetcher
        )
        navigationController.pushViewController(viewController, animated: true)
    }

    func viewAllCards(
        _ cards: [CardPresentable],
        pageFetcher: @escaping CardPageFetcher,
        referencesFetcher: @escaping GenericCardReferencesFetcher
    ) {
        let viewController = viewControllersFactory.makeCardsCollectionViewController(
            for: self,
            cards: cards,
            pageFetcher: pageFetcher,
            referencesFetcher: referencesFetcher
        )
        navigationController.pushViewController(viewController, animated: true)
    }
}

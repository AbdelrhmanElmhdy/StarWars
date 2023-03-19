//
//  MainViewControllersFactory.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import UIKit

class MainViewControllersFactory {
    let dependencyContainer: DependencyContainer

    lazy var settingsSectionFactory = SettingsSectionsFactory(
        userPreferences: dependencyContainer.userDefaultsManager.userPreferences
    )

    init(dependencyContainer: DependencyContainer) {
        self.dependencyContainer = dependencyContainer
    }
}

extension MainViewControllersFactory: HomeViewControllersFactory {
    func makeHomeViewController(for coordinator: ViewingCard & ViewingAllCards) -> HomeViewController {
        let viewModel = HomeViewModel(
            characterService: dependencyContainer.characterService,
            filmService: dependencyContainer.filmService,
            planetService: dependencyContainer.planetService,
            spaceshipService: dependencyContainer.spaceshipService,
            speciesService: dependencyContainer.speciesService,
            vehicleService: dependencyContainer.vehicleService
        )
        return HomeViewController(coordinator: coordinator, viewModel: viewModel)
    }

    func makeCardDetailsViewController(
        for coordinator: ViewingCard,
        card: CardPresentable,
        referencesFetcher: @escaping GenericCardReferencesFetcher
    ) -> CardDetailsViewController {
        let viewModel = CardDetailsViewModel(card: card, cardReferencesFetcher: referencesFetcher)
        return CardDetailsViewController(coordinator: coordinator, viewModel: viewModel)
    }

    func makeCardsCollectionViewController(
        for coordinator: ViewingCard,
        cards: [CardPresentable],
        pageFetcher: @escaping CardPageFetcher,
        referencesFetcher: @escaping GenericCardReferencesFetcher
    ) -> CardsCollectionViewController {
        let viewModel = CardsViewModel(cards: cards,
                                       pageFetcher: pageFetcher,
                                       referencesFetcher: referencesFetcher)
        return CardsCollectionViewController(coordinator: coordinator, viewModel: viewModel)
    }
}

extension MainViewControllersFactory: SettingsViewControllersFactory {
    func makeSettingsViewController(for coordinator: DisclosingSettings,
                                    settingsSections: [SettingsSection]? = nil) -> SettingsViewController {
        let viewModel = SettingsViewModel(userPreferencesService: dependencyContainer.userPreferencesService)
        let viewController = SettingsViewController(coordinator: coordinator, viewModel: viewModel)

        let settingsSections = settingsSections ?? settingsSectionFactory.createRootSettingsSections(forViewController: viewController)

        let dataSource = SettingsDataSource(settingsSections: settingsSections)
        viewController.datasource = dataSource

        return viewController
    }
}

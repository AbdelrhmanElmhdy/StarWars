//
//  ViewControllersFactory.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Foundation

protocol HomeViewControllersFactory: AnyObject {
    func makeHomeViewController(for coordinator: ViewingCard & ViewingAllCards) -> HomeViewController

    func makeCardDetailsViewController(
        for coordinator: ViewingCard,
        card: CardPresentable,
        referencesFetcher: @escaping GenericCardReferencesFetcher
    ) -> CardDetailsViewController

    func makeCardsCollectionViewController(
        for coordinator: ViewingCard,
        cards: [CardPresentable],
        pageFetcher: @escaping CardPageFetcher,
        referencesFetcher: @escaping GenericCardReferencesFetcher
    ) -> CardsCollectionViewController
}

protocol SettingsViewControllersFactory: AnyObject {
    func makeSettingsViewController(for coordinator: DisclosingSettings,
                                    settingsSections: [SettingsSection]?) -> SettingsViewController
}

typealias ViewControllersFactory = HomeViewControllersFactory & SettingsViewControllersFactory

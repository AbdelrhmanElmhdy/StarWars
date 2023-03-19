//
//  HomeStackCoordinatorMock.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import UIKit

class HomeStackCoordinatorMock: Coordinator, ViewingCard, ViewingAllCards {
    var children = [Coordinator]()
    let navigationController = UINavigationController()

    func start() {
    }

    func viewCard(_ card: CardPresentable, referencesFetcher: @escaping GenericCardReferencesFetcher) {
    }

    func viewAllCards(
        _ cards: [CardPresentable],
        pageFetcher: @escaping CardPageFetcher,
        referencesFetcher: @escaping GenericCardReferencesFetcher
    ) {
    }
}

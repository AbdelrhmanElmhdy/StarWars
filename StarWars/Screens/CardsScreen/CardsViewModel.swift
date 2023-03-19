//
//  CardsViewModel.swift
//  MyCards
//
//  Created by Abdelrhman Elmahdy on 06/02/2023.
//

import Combine
import Foundation

class CardsViewModel {
    // MARK: State

    private let pageFetcher: CardPageFetcher
    let referencesFetcher: GenericCardReferencesFetcher
    @Published var nextPage: Int? = 2
    @Published var cards: [CardPresentable] = []
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""

    // MARK: Initialization

    init(cards: [CardPresentable],
         pageFetcher: @escaping CardPageFetcher,
         referencesFetcher: @escaping GenericCardReferencesFetcher
    ) {
        self.cards = cards
        self.pageFetcher = pageFetcher
        self.referencesFetcher = referencesFetcher
    }

    // MARK: Logic

    func fetchMoreCards() {
        guard let nextPage = nextPage else { return }

        isLoading = true

        pageFetcher(nextPage) { [weak self] cards, nextPage in
            self?.cards += cards
            self?.isLoading = false
            self?.nextPage = nextPage
        }
    }
}

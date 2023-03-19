//
//  CardDetailsViewModel.swift
//  MyCards
//
//  Created by Abdelrhman Elmahdy on 06/02/2023.
//

import Foundation
import Combine

class CardDetailsViewModel {
    // MARK: State

    let card: CardPresentable
    let cardReferencesFetcher: GenericCardReferencesFetcher

    @Published var referencedCardsByTitle: [String: [CardPresentable]] = [:]
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""

    // MARK: Initialization

    init(card: CardPresentable, cardReferencesFetcher: @escaping GenericCardReferencesFetcher) {
        self.card = card
        self.cardReferencesFetcher = cardReferencesFetcher
        for referencedCard in card.referencedCards where !referencedCard.ids.isEmpty {
            referencedCardsByTitle[referencedCard.referenceTitle] = []
        }
        fetchReferencedCards()
    }

    // MARK: Logic

    func fetchReferencedCards() {
        isLoading = true
        for reference in card.referencedCards {
            cardReferencesFetcher(reference) { [weak self] cards in
                if !cards.isEmpty {
                    self?.referencedCardsByTitle[reference.referenceTitle] = cards
                }
            }
        }
    }
}

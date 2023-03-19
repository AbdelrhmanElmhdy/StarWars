//
//  HomeStackCoordination.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import UIKit

protocol ViewingCard: AnyObject {
    func viewCard(_ card: CardPresentable, referencesFetcher: @escaping GenericCardReferencesFetcher)
}

protocol ViewingAllCards: AnyObject {
    func viewAllCards(_ cards: [CardPresentable], pageFetcher: @escaping CardPageFetcher, referencesFetcher: @escaping GenericCardReferencesFetcher)
}

/// Pops a card that is currently being peaked at.
protocol PopOpeningPreviewedCard: AnyObject {
    /// Pop the card that is currently being peaked at.
    func popOpenCard(inPreviewedViewController previewedViewController: UIViewController)
}

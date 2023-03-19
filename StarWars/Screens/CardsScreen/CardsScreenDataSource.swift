//
//  CardsCollectionViewDataSource.swift
//  MyCards
//
//  Created by Abdelrhman Elmahdy on 06/02/2023.
//

import Foundation

import UIKit
import SkeletonView

class CardsScreenDataSource: NSObject, SkeletonCollectionViewDataSource {
    // MARK: Properties

    var isInfiniteScrollEnabled = false
    lazy var cards: [CardPresentable] = []
    var filteredCards: [CardPresentable] = []

    var searchText = "" {
        didSet {
            filteredCards = cards.filter({ (card: CardPresentable) -> Bool in
                card.title.lowercased().contains(searchText.lowercased())
            })
        }
    }

    var isFiltering: Bool { !searchText.isEmpty }

    // MARK: DataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard !isFiltering else { return 1 }

        return isInfiniteScrollEnabled ? 2 : 1
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        switch indexPath.section {
        case 0: return CardCell.reuseIdentifier
        default: return LoadingCell.reuseIdentifier
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard !isFiltering else { return filteredCards.count }

        switch section {
        case 0: return cards.count
        default: return 2 // loading cells
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: LoadingCell.reuseIdentifier, for: indexPath)
        }

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CardCell.reuseIdentifier,
            for: indexPath
        ) as! CardCell // swiftlint:disable:this force_cast

        let card = isFiltering ? filteredCards[indexPath.row] : cards[indexPath.row]

        cell.image = card.image
        cell.title = card.title

        return cell
    }
}

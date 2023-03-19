//
//  HorizontalCardsViewController.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 19/03/2023.
//

import Combine
import Foundation
import UIKit

class HorizontalCardsViewController: UIViewController {
    let cardsView: CardsView
    let dataSource: CardsScreenDataSource

    var passThroughSubject = PassthroughSubject<CardPresentable, Never>()
    lazy var itemSelectionPublisher = passThroughSubject.eraseToAnyPublisher()

    init(title: String, dataSource: CardsScreenDataSource) {
        cardsView = CardsView(title: title)
        self.dataSource = dataSource
        super.init(nibName: nil, bundle: nil)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: LifeCycle

    override func loadView() {
        view = cardsView
    }

    func setup() {
        cardsView.cardsCollectionView.isSkeletonable = true
        cardsView.cardsCollectionView.delegate = self
        cardsView.cardsCollectionView.dataSource = dataSource
        cardsView.cardsCollectionView.register(CardCell.self,
                                               forCellWithReuseIdentifier: CardCell.reuseIdentifier)
        cardsView.cardsCollectionView.register(LoadingCell.self,
                                               forCellWithReuseIdentifier: LoadingCell.reuseIdentifier)
    }
}

extension HorizontalCardsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 2.5, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(
            top: 0,
            left: view.safeAreaInsets.left + 20,
            bottom: 0,
            right: view.safeAreaInsets.right + 20
        )
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let card = dataSource.cards[indexPath.row]
        passThroughSubject.send(card)
    }
}

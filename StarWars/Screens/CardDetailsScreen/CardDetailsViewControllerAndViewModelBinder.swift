//
//  CardDetailsViewControllerAndViewModelBinder.swift
//  MyCards
//
//  Created by Abdelrhman Elmahdy on 07/02/2023.
//

import Combine
import Foundation

// swiftlint:disable:next type_name
class CardDetailsViewControllerAndViewModelBinder: ViewControllerAndViewModelBinder<CardDetailsViewController, CardDetailsViewModel> {
    override func setupBindings() {
        viewModel.$referencedCardsByTitle.sink { [weak self] in
            for (title, cards) in $0 {
                self?.viewController.dataSourcesByTitle[title]?.cards = cards
                self?.viewController.collectionViewsByTitle[title]?.reloadData()
            }
        }.store(in: &subscriptions)
    }
}

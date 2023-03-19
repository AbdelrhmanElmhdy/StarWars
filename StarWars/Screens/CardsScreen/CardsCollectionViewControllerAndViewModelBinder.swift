//
//  CardsCollectionViewControllerAndViewModelBinder.swift
//  MyCards
//
//  Created by Abdelrhman Elmahdy on 07/02/2023.
//

import Foundation
import Combine

// swiftlint:disable:next type_name
class CardsCollectionViewControllerAndViewModelBinder: ViewControllerAndViewModelBinder<CardsCollectionViewController, CardsViewModel> {

	override func setupBindings() {
		// photos

		viewModel.$cards
			.sink { [weak self] in
				self?.viewController.dataSource.cards = $0
				self?.viewController.collectionView.reloadData()
			}
			.store(in: &subscriptions)

        viewModel.$nextPage
            .map { $0 != nil }
            .assign(to: \.isInfiniteScrollEnabled, on: viewController.dataSource)
            .store(in: &subscriptions)

		viewController.navigationItem.searchController?.searchBar.textPublisher
			.debounce(for: 0.15, scheduler: DispatchQueue.main) // Debouncing for a short period, since the search operation is inexpensive.
			.sink { [weak self] searchText in
                let searchText = searchText ?? ""
				self?.viewModel.searchText = searchText
				self?.viewController.dataSource.searchText = searchText
				self?.viewController.collectionView.reloadData()
			}
			.store(in: &subscriptions)
	}

}

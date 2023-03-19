//
//  HomeViewControllerAndViewModelBinder.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Combine
import UIKit

class HomeViewControllerAndViewModelBinder: ViewControllerAndViewModelBinder<HomeViewController, HomeViewModel> {
    override func setupBindings() {
        setupDataSourceBindings()
        setupLoadingStateBinding()
    }

    private func setupDataSourceBindings() {
        viewModel.$characters
            .sink { [weak self] in
                self?.viewController.characterCardsDataSource.cards = $0
                self?.viewController.characterCardsChildViewController.cardsView.cardsCollectionView.reloadData()
            }
            .store(in: &subscriptions)

        viewModel.$films
            .sink { [weak self] in
                self?.viewController.filmCardsDataSource.cards = $0
                self?.viewController.filmCardsChildViewController.cardsView.cardsCollectionView.reloadData()
            }
            .store(in: &subscriptions)

        viewModel.$planets
            .sink { [weak self] in
                self?.viewController.planetCardsDataSource.cards = $0
                self?.viewController.planetCardsChildViewController.cardsView.cardsCollectionView.reloadData()
            }
            .store(in: &subscriptions)

        viewModel.$spaceships
            .sink { [weak self] in
                self?.viewController.spaceshipCardsDataSource.cards = $0
                self?.viewController.spaceshipCardsChildViewController.cardsView.cardsCollectionView.reloadData()
            }
            .store(in: &subscriptions)

        viewModel.$species
            .sink { [weak self] in
                self?.viewController.speciesCardsDataSource.cards = $0
                self?.viewController.speciesCardsChildViewController.cardsView.cardsCollectionView.reloadData()
            }
            .store(in: &subscriptions)

        viewModel.$vehicles
            .sink { [weak self] in
                self?.viewController.vehicleCardsDataSource.cards = $0
                self?.viewController.vehicleCardsChildViewController.cardsView.cardsCollectionView.reloadData()
            }
            .store(in: &subscriptions)
    }

    private func setupLoadingStateBinding() {
        viewModel.$loadingState
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink(receiveValue: { loadingState in
                if loadingState == .loading {
                    self.resetTableView()
                    self.showAnimatedSkeleton()
                    return
                }

                self.hideAnimatedSkeleton()
                self.viewController.controlledView.scrollView.restoreFromError()

                if loadingState == .noConnection {
                    self.viewController.controlledView.scrollView.didReceiveError(
                        error: NetworkRequestError.failedToConnectToInternet(),
                        recoveryButtonTitle: .ui.tryAgain,
                        recoverySuggestionHandler: #selector(HomeViewController.didRefresh),
                        handlerTarget: self.viewController
                    )
                }
            })
            .store(in: &subscriptions)
    }

    private func resetTableView() {
        viewModel.characters = []
        viewModel.films = []
        viewModel.planets = []
        viewModel.spaceships = []
        viewModel.species = []
        viewModel.vehicles = []
        viewController.controlledView.scrollView.restoreFromError()
    }

    private func showAnimatedSkeleton() {
        for cardsView in viewController.controlledView.cardViews {
            cardsView.cardsCollectionView.showAnimatedSkeleton(usingColor: .systemGray5)
        }
    }

    private func hideAnimatedSkeleton() {
        for cardsView in viewController.controlledView.cardViews {
            cardsView.cardsCollectionView.stopSkeletonAnimation()
            cardsView.cardsCollectionView.hideSkeleton()
        }
    }
}

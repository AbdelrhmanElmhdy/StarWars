//
//  HomeViewController.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Combine
import UIKit

class HomeViewController: UIViewController {
    // MARK: Properties

    lazy var characterCardsChildViewController =
        HorizontalCardsViewController(title: "Characters".localized, dataSource: characterCardsDataSource)

    lazy var filmCardsChildViewController =
        HorizontalCardsViewController(title: "Films".localized, dataSource: filmCardsDataSource)

    lazy var planetCardsChildViewController =
        HorizontalCardsViewController(title: "Planets".localized, dataSource: planetCardsDataSource)

    lazy var speciesCardsChildViewController =
        HorizontalCardsViewController(title: "Species".localized, dataSource: speciesCardsDataSource)

    lazy var vehicleCardsChildViewController =
        HorizontalCardsViewController(title: "Vehicles".localized, dataSource: vehicleCardsDataSource)

    lazy var spaceshipCardsChildViewController =
        HorizontalCardsViewController(title: "Spaceships".localized, dataSource: spaceshipCardsDataSource)

    lazy var controlledView = HomeView(cardViews: [
        characterCardsChildViewController.cardsView,
        filmCardsChildViewController.cardsView,
        planetCardsChildViewController.cardsView,
        speciesCardsChildViewController.cardsView,
        vehicleCardsChildViewController.cardsView,
        spaceshipCardsChildViewController.cardsView,
    ])

    private unowned let coordinator: ViewingCard & ViewingAllCards
    private let viewModel: HomeViewModel

    let characterCardsDataSource = CardsScreenDataSource()
    let filmCardsDataSource = CardsScreenDataSource()
    let planetCardsDataSource = CardsScreenDataSource()
    let speciesCardsDataSource = CardsScreenDataSource()
    let vehicleCardsDataSource = CardsScreenDataSource()
    let spaceshipCardsDataSource = CardsScreenDataSource()

    private lazy var dataBinder = HomeViewControllerAndViewModelBinder(viewController: self, viewModel: viewModel)
    var cardSelectionSubscription: AnyCancellable?

    // MARK: Initialization

    init(coordinator: ViewingCard & ViewingAllCards, viewModel: HomeViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle

    override func loadView() {
        view = controlledView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildViewControllers()
        dataBinder.setupBindings()
        viewModel.fetchData()
    }

    fileprivate func setupChildViewControllers() {
        controlledView.backgroundColor = .systemBackground

        let cardSelectionPublishers = [
            characterCardsChildViewController.itemSelectionPublisher,
            filmCardsChildViewController.itemSelectionPublisher,
            planetCardsChildViewController.itemSelectionPublisher,
            speciesCardsChildViewController.itemSelectionPublisher,
            vehicleCardsChildViewController.itemSelectionPublisher,
            spaceshipCardsChildViewController.itemSelectionPublisher,
        ]

        cardSelectionSubscription = Publishers.MergeMany(cardSelectionPublishers).sink(receiveValue: didSelectCard)

        setupCardsChildViewController(characterCardsChildViewController,
                                      dataSource: characterCardsDataSource,
                                      showAllButtonHandler: #selector(didPressShowAllCharacters))

        setupCardsChildViewController(filmCardsChildViewController,
                                      dataSource: filmCardsDataSource,
                                      showAllButtonHandler: #selector(didPressShowAllFilms))

        setupCardsChildViewController(planetCardsChildViewController,
                                      dataSource: planetCardsDataSource,
                                      showAllButtonHandler: #selector(didPressShowAllPlanets))

        setupCardsChildViewController(speciesCardsChildViewController,
                                      dataSource: speciesCardsDataSource,
                                      showAllButtonHandler: #selector(didPressShowAllSpecies))

        setupCardsChildViewController(vehicleCardsChildViewController,
                                      dataSource: spaceshipCardsDataSource,
                                      showAllButtonHandler: #selector(didPressShowAllSpaceships))

        setupCardsChildViewController(spaceshipCardsChildViewController,
                                      dataSource: vehicleCardsDataSource,
                                      showAllButtonHandler: #selector(didPressShowAllVehicles))
    }

    func setupCardsChildViewController(
        _ cardsViewController: HorizontalCardsViewController,
        dataSource: UICollectionViewDataSource,
        showAllButtonHandler: Selector
    ) {
        addChild(cardsViewController)
        cardsViewController.didMove(toParent: self)
        cardsViewController.cardsView.cardsCollectionView.dataSource = dataSource
        cardsViewController.cardsView.header.showAllButton.addTarget(
            self,
            action: showAllButtonHandler,
            for: .touchUpInside
        )
    }

    @objc func didRefresh() {
        viewModel.fetchData()
    }

    func didSelectCard(_ card: CardPresentable) {
        coordinator.viewCard(card, referencesFetcher: viewModel.genericCardReferencesFetcher)
    }

    @objc func didPressShowAllCharacters() {
        let pageFetcher = viewModel.charactersPageFetcher
        let refFetcher = viewModel.genericCardReferencesFetcher
        let cards = characterCardsDataSource.cards
        coordinator.viewAllCards(cards, pageFetcher: pageFetcher, referencesFetcher: refFetcher)
    }

    @objc func didPressShowAllPlanets() {
        let pageFetcher = viewModel.planetPageFetcher
        let refFetcher = viewModel.genericCardReferencesFetcher
        let cards = characterCardsDataSource.cards
        coordinator.viewAllCards(cards, pageFetcher: pageFetcher, referencesFetcher: refFetcher)
    }

    @objc func didPressShowAllFilms() {
        let pageFetcher = viewModel.filmsPageFetcher
        let refFetcher = viewModel.genericCardReferencesFetcher
        let cards = filmCardsDataSource.cards
        coordinator.viewAllCards(cards, pageFetcher: pageFetcher, referencesFetcher: refFetcher)
    }

    @objc func didPressShowAllSpaceships() {
        let pageFetcher = viewModel.spaceshipsPageFetcher
        let refFetcher = viewModel.genericCardReferencesFetcher
        let cards = spaceshipCardsDataSource.cards
        coordinator.viewAllCards(cards, pageFetcher: pageFetcher, referencesFetcher: refFetcher)
    }

    @objc func didPressShowAllVehicles() {
        let pageFetcher = viewModel.vehiclePageFetcher
        let refFetcher = viewModel.genericCardReferencesFetcher
        let cards = vehicleCardsDataSource.cards
        coordinator.viewAllCards(cards, pageFetcher: pageFetcher, referencesFetcher: refFetcher)
    }

    @objc func didPressShowAllSpecies() {
        let pageFetcher = viewModel.speciesPageFetcher
        let refFetcher = viewModel.genericCardReferencesFetcher
        let cards = speciesCardsDataSource.cards
        coordinator.viewAllCards(cards, pageFetcher: pageFetcher, referencesFetcher: refFetcher)
    }
}

// MARK: Preview

#if canImport(SwiftUI) && DEBUG
    import SwiftUI

    @available(iOS 13.0, *)
    struct HomeViewController_Preview: PreviewProvider { // swiftlint:disable:this type_name
        static var previews: some View {
            ForEach(DEVICE_NAMES, id: \.self) { deviceName in
                UIViewControllerPreview {
                    AppDelegate.shared.viewControllersFactory.makeHomeViewController(for: HomeStackCoordinatorMock())
                }.previewDevice(PreviewDevice(rawValue: deviceName))
                    .previewDisplayName(deviceName)
            }
        }
    }
#endif

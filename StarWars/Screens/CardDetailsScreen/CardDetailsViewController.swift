//
//  CardDetailsViewController.swift
//  MyCards
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import Combine
import UIKit

class CardDetailsViewController: UIViewController {
    // MARK: Properties

    private unowned let coordinator: ViewingCard
    private let viewModel: CardDetailsViewModel

    private lazy var dataBinder = CardDetailsViewControllerAndViewModelBinder(viewController: self, viewModel: viewModel)
    let controlledView = CardDetailsView()

    var dataSourcesByTitle: [String: CardsScreenDataSource] = [:]
    var collectionViewsByTitle: [String: UICollectionView] = [:]
    private var cardSelectionPublishers: [AnyPublisher<CardPresentable, Never>] = []
    private var cardSelectionSubscription: AnyCancellable?

    // MARK: Initialization

    init(coordinator: ViewingCard, viewModel: CardDetailsViewModel) {
        self.viewModel = viewModel
        self.coordinator = coordinator
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
        view.backgroundColor = .systemBackground
        setupView()
        setupReferencedCardsChildViewControllers()
        dataBinder.setupBindings()
    }

    // MARK: Setups

    func setupView() {
        controlledView.imageView.image = viewModel.card.image
        controlledView.infoLabel.attributedText = String.attributedStringFromDictionary(
            viewModel.card.info,
            keyColor: .secondaryLabel,
            valueColor: .cyan
        )
    }

    func setupReferencedCardsChildViewControllers() {
        for (title, cards) in viewModel.referencedCardsByTitle {
            appendCardsChildViewController(title: title, cards: cards)
        }

        cardSelectionSubscription = Publishers.MergeMany(cardSelectionPublishers).sink(receiveValue: didSelectCard)
    }

    func appendCardsChildViewController(title: String, cards: [CardPresentable]) {
        let dataSource = CardsScreenDataSource()
        dataSource.cards = cards

        let cardsViewController = HorizontalCardsViewController(title: title, dataSource: dataSource)

        addChild(cardsViewController)
        controlledView.appendCardsView(cardsViewController.cardsView)
        cardsViewController.didMove(toParent: self)
        cardsViewController.cardsView.cardsCollectionView.dataSource = dataSource
        cardsViewController.cardsView.header.showAllButton.isHidden = true

        cardSelectionPublishers.append(cardsViewController.itemSelectionPublisher)

        dataSourcesByTitle[title] = dataSource
        collectionViewsByTitle[title] = cardsViewController.cardsView.cardsCollectionView
    }

    func didSelectCard(_ card: CardPresentable) {
        coordinator.viewCard(card, referencesFetcher: viewModel.cardReferencesFetcher)
    }
}

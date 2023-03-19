//
//  CardsCollectionViewController.swift
//  MyCards
//
//  Created by Abdelrhman Elmahdy on 05/02/2023.
//

import SkeletonView
import UIKit

class CardsCollectionViewController: UICollectionViewController {
    // MARK: Properties

    private unowned let coordinator: ViewingCard
    private let viewModel: CardsViewModel

    let dataSource = CardsScreenDataSource()
    private(set) lazy var dataBinder = CardsCollectionViewControllerAndViewModelBinder(viewController: self,
                                                                                       viewModel: viewModel)
    private let searchController = UISearchController(searchResultsController: nil)

    fileprivate var numberOfCardsPerRow: CGFloat { isFiltering ? 3 : 1 }
    fileprivate let cardsSpacing: CGFloat = 35
    fileprivate var sectionInsets: UIEdgeInsets {
        UIEdgeInsets(
            top: cardsSpacing / 2,
            left: view.safeAreaInsets.left + 10,
            bottom: cardsSpacing / 2,
            right: view.safeAreaInsets.right + 10
        )
    }

    var isFiltering: Bool {
        searchController.isActive && !searchBarIsEmpty
    }

    private var searchBarIsEmpty: Bool {
        searchController.searchBar.text?.isEmpty ?? true
    }

    // MARK: Initialization

    init(coordinator: ViewingCard, viewModel: CardsViewModel) {
        self.viewModel = viewModel
        self.coordinator = coordinator

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        super.init(collectionViewLayout: layout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        setupCollectionView()
        setupSearchController()
        dataBinder.setupBindings()
    }

    // MARK: Setups

    private func setupViewController() {
        view.backgroundColor = .systemBackground
        definesPresentationContext = true
    }

    private func setupCollectionView() {
        collectionView.isSkeletonable = true
        collectionView.dataSource = dataSource
        collectionView.register(CardCell.self, forCellWithReuseIdentifier: CardCell.reuseIdentifier)
        collectionView.register(LoadingCell.self, forCellWithReuseIdentifier: LoadingCell.reuseIdentifier)
    }

    private func setupSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: UICollectionViewDelegate

extension CardsCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let card = dataSource.isFiltering ? dataSource.filteredCards[indexPath.row] : dataSource.cards[indexPath.row]
        coordinator.viewCard(card, referencesFetcher: viewModel.referencesFetcher)
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension CardsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        cardsSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let paddingSpace = sectionInsets.left + sectionInsets.right
        let availableWidth = collectionView.frame.width - paddingSpace
        let availableHeight = view.frame.height - view.safeAreaInsets.bottom - view.safeAreaInsets.top
        let itemWidth = (availableWidth / numberOfCardsPerRow) - 5
        let itemHeight = min(itemWidth * 1.2, availableHeight * 0.95)

        return CGSize(width: itemWidth, height: itemHeight)
    }

    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row >= dataSource.cards.count - 10,
           !viewModel.isLoading,
           viewModel.nextPage != nil,
           !isFiltering {
            viewModel.fetchMoreCards()
        }
    }
}

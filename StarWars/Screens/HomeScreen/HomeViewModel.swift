//
//  HomeViewModel.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Combine
import Foundation

typealias CardPageFetcher = (_ page: Int,
                             @escaping (_ pageContent: [CardPresentable], _ nextPage: Int?) -> Void) -> Void

typealias GenericCardReferencesFetcher = (_ cardsReference: CardsReference,
                                          @escaping (_ referencedCards: [CardPresentable]) -> Void) -> Void

typealias CardReferencesFetcher = (_ cardsReferenceIDs: [Int],
                                   @escaping (_ referencedCards: [CardPresentable]) -> Void) -> Void

class HomeViewModel {
    enum LoadingState {
        case loading, noConnection, loaded
    }

    private let characterService: CharacterService
    private let filmService: FilmService
    private let planetService: PlanetService
    private let spaceshipService: SpaceshipService
    private let speciesService: SpeciesService
    private let vehicleService: VehicleService

    private var pageFetcherSubscription: AnyCancellable?
    private var referencesFetcherSubscriptions = Set<AnyCancellable>()
    private var filmReferencesFetcherSubscriptions: AnyCancellable?
    private var dataRefreshSubscription: AnyCancellable?

    lazy var charactersPageFetcher: CardPageFetcher = { [weak self] page, completion in
        self?.pageFetcherSubscription = self?.characterService.fetchAllFromServer(inPage: page)
            .sink(receiveCompletion: { _ in }, receiveValue: { completion($0.results, $0.nextPage) })
    }

    lazy var filmsPageFetcher: CardPageFetcher = { [weak self] page, completion in
        self?.pageFetcherSubscription = self?.filmService.fetchAllFromServer(inPage: page)
            .sink(receiveCompletion: { _ in }, receiveValue: { completion($0.results, $0.nextPage) })
    }

    lazy var spaceshipsPageFetcher: CardPageFetcher = { [weak self] page, completion in
        self?.pageFetcherSubscription = self?.spaceshipService.fetchAllFromServer(inPage: page)
            .sink(receiveCompletion: { _ in }, receiveValue: { completion($0.results, $0.nextPage) })
    }

    lazy var speciesPageFetcher: CardPageFetcher = { [weak self] page, completion in
        self?.pageFetcherSubscription = self?.speciesService.fetchAllFromServer(inPage: page)
            .sink(receiveCompletion: { _ in }, receiveValue: { completion($0.results, $0.nextPage) })
    }

    lazy var planetPageFetcher: CardPageFetcher = { [weak self] page, completion in
        self?.pageFetcherSubscription = self?.planetService.fetchAllFromServer(inPage: page)
            .sink(receiveCompletion: { _ in }, receiveValue: { completion($0.results, $0.nextPage) })
    }

    lazy var vehiclePageFetcher: CardPageFetcher = { [weak self] page, completion in
        self?.pageFetcherSubscription = self?.vehicleService.fetchAllFromServer(inPage: page)
            .sink(receiveCompletion: { _ in }, receiveValue: { completion($0.results, $0.nextPage) })
    }

    lazy var genericCardReferencesFetcher: GenericCardReferencesFetcher = { [weak self] cardsReference, completion in
        switch cardsReference.referenceTitle {
        case Character.title: self?.charactersReferencesFetcher(cardsReference.ids, completion)
        case Film.title: self?.filmsReferencesFetcher(cardsReference.ids, completion)
        case Spaceship.title: self?.spaceshipsReferencesFetcher(cardsReference.ids, completion)
        case Species.title: self?.speciesReferencesFetcher(cardsReference.ids, completion)
        case Planet.title: self?.planetReferencesFetcher(cardsReference.ids, completion)
        case Vehicle.title: self?.vehicleReferencesFetcher(cardsReference.ids, completion)
        default: break
        }
    }

    lazy var charactersReferencesFetcher: CardReferencesFetcher = { [weak self] referenceIDs, completion in
        guard let self = self else { return }
        let publishers = referenceIDs.compactMap { self.characterService.fetchFromServer(withID: $0) }
        let downStream = Publishers.MergeMany(publishers).collect()
        downStream.sink(receiveCompletion: { _ in }, receiveValue: completion).store(in: &self.referencesFetcherSubscriptions)
    }

    lazy var filmsReferencesFetcher: CardReferencesFetcher = { [weak self] referenceIDs, completion in
        guard let self = self else { return }
        let publishers = referenceIDs.compactMap { self.filmService.fetchFromServer(withID: $0) }
        let downStream = Publishers.MergeMany(publishers).collect()
        downStream.sink(receiveCompletion: { _ in }, receiveValue: completion).store(in: &self.referencesFetcherSubscriptions)
    }

    lazy var spaceshipsReferencesFetcher: CardReferencesFetcher = { [weak self] referenceIDs, completion in
        guard let self = self else { return }
        let publishers = referenceIDs.compactMap { self.spaceshipService.fetchFromServer(withID: $0) }
        let downStream = Publishers.MergeMany(publishers).collect()
        downStream.sink(receiveCompletion: { _ in }, receiveValue: completion).store(in: &self.referencesFetcherSubscriptions)
    }

    lazy var speciesReferencesFetcher: CardReferencesFetcher = { [weak self] referenceIDs, completion in
        guard let self = self else { return }
        let publishers = referenceIDs.compactMap { self.speciesService.fetchFromServer(withID: $0) }
        let downStream = Publishers.MergeMany(publishers).collect()
        downStream.sink(receiveCompletion: { _ in }, receiveValue: completion).store(in: &self.referencesFetcherSubscriptions)
    }

    lazy var planetReferencesFetcher: CardReferencesFetcher = { [weak self] referenceIDs, completion in
        guard let self = self else { return }
        let publishers = referenceIDs.compactMap { self.planetService.fetchFromServer(withID: $0) }
        let downStream = Publishers.MergeMany(publishers).collect()
        downStream.sink(receiveCompletion: { _ in }, receiveValue: completion).store(in: &self.referencesFetcherSubscriptions)
    }

    lazy var vehicleReferencesFetcher: CardReferencesFetcher = { [weak self] referenceIDs, completion in
        guard let self = self else { return }
        let publishers = referenceIDs.compactMap { self.vehicleService.fetchFromServer(withID: $0) }
        let downStream = Publishers.MergeMany(publishers).collect()
        downStream.sink(receiveCompletion: { _ in }, receiveValue: completion).store(in: &self.referencesFetcherSubscriptions)
    }

    // MARK: State

    @Published var characters: [Character] = []
    @Published var films: [Film] = []
    @Published var planets: [Planet] = []
    @Published var spaceships: [Spaceship] = []
    @Published var species: [Species] = []
    @Published var vehicles: [Vehicle] = []

    @Published var loadingState = LoadingState.loaded

    // MARK: Initialization

    init(
        characterService: CharacterService,
        filmService: FilmService,
        planetService: PlanetService,
        spaceshipService: SpaceshipService,
        speciesService: SpeciesService,
        vehicleService: VehicleService
    ) {
        self.characterService = characterService
        self.filmService = filmService
        self.planetService = planetService
        self.spaceshipService = spaceshipService
        self.speciesService = speciesService
        self.vehicleService = vehicleService
    }

    func fetchData() {
        loadingState = .loading

        let characterRefreshSubscription = characterService.fetchAllFromServer(inPage: 1)
        let filmRefreshSubscription = filmService.fetchAllFromServer(inPage: 1)
        let planetRefreshSubscription = planetService.fetchAllFromServer(inPage: 1)
        let spaceshipRefreshSubscription = spaceshipService.fetchAllFromServer(inPage: 1)
        let speciesRefreshSubscription = speciesService.fetchAllFromServer(inPage: 1)
        let vehicleRefreshSubscription = vehicleService.fetchAllFromServer(inPage: 1)

        dataRefreshSubscription = Publishers.CombineLatest(
            Publishers.CombineLatest3(characterRefreshSubscription,
                                      filmRefreshSubscription,
                                      planetRefreshSubscription),

            Publishers.CombineLatest3(spaceshipRefreshSubscription,
                                      speciesRefreshSubscription,
                                      vehicleRefreshSubscription)
        )
        .delay(for: 0.1, scheduler: DispatchQueue.main) // To show to the user that a refresh has occurred.
        .sink(receiveCompletion: didReceiveDataRefreshCompletion) { [weak self] in
            let (characters, films, planets) = $0
            let (spaceships, species, vehicles) = $1

            self?.characters = characters.results
            self?.films = films.results
            self?.planets = planets.results
            self?.spaceships = spaceships.results
            self?.species = species.results
            self?.vehicles = vehicles.results

            self?.loadingState = .loaded
        }
    }

    private func didReceiveDataRefreshCompletion(completion: Subscribers.Completion<NetworkRequestError>) {
        switch completion {
        case let .failure(error): handleDataRefreshError(error)
        default: loadingState = .loaded
        }
    }

    private func handleDataRefreshError(_ error: NetworkRequestError) {
        switch error {
        case .failedToConnectToInternet, .requestTimedOut: loadingState = .noConnection
        default: loadingState = .loaded
        }

        if error.isFatal { ErrorManager.reportError(error) }
    }
}

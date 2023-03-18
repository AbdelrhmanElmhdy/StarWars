//
//  HomeViewModel.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Combine
import Foundation

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

    private var dataRefreshSubscription: AnyCancellable?
    
    // MARK: State

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

    func fetchCharacters() {
        let characterRefreshSubscription = characterService.fetchAllFromServer(inPage: 9)
        let filmRefreshSubscription = filmService.fetchAllFromServer(inPage: 1)
        let planetRefreshSubscription = planetService.fetchAllFromServer(inPage: 6)
        let spaceshipRefreshSubscription = spaceshipService.fetchAllFromServer(inPage: 4)
        let speciesRefreshSubscription = speciesService.fetchAllFromServer(inPage: 4)
        let vehicleRefreshSubscription = vehicleService.fetchAllFromServer(inPage: 4)

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

            print(characters)
            print(films)
            print(planets)
            print(spaceships)
            print(species)
            print(vehicles)

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

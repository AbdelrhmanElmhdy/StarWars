//
//  DependencyContainer.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Foundation

class DependencyContainer {
    // MARK: Managers

    let networkManager = NetworkManagerFactory.make()
    let userDefaultsManager = UserDefaultsManagerFactory.make()

    let inMemoryCache = NSCache<NSString, NSData>()

    // MARK: Services

    lazy var characterService = CharacterService(networkManager: networkManager, cache: inMemoryCache)
    lazy var filmService = FilmService(networkManager: networkManager, cache: inMemoryCache)
    lazy var planetService = PlanetService(networkManager: networkManager, cache: inMemoryCache)
    lazy var spaceshipService = SpaceshipService(networkManager: networkManager, cache: inMemoryCache)
    lazy var speciesService = SpeciesService(networkManager: networkManager, cache: inMemoryCache)
    lazy var vehicleService = VehicleService(networkManager: networkManager, cache: inMemoryCache)
    lazy var userPreferencesService: UserPreferencesService = UserPreferencesService(
        userDefaultsManager: userDefaultsManager
    )
}

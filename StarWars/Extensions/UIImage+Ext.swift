//
//  UIImage+Ext.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import UIKit

// MARK: + Static Images

extension UIImage {
    private static let allImagePaths = Bundle.main.paths(forResourcesOfType: "jpg", inDirectory: nil)

    static let homeIcon = UIImage(named: "HomeIcon")!
    static let gear = UIImage(systemName: "gear")!
    static let arrowForward = UIImage(systemName: "arrow.forward.circle.fill")!

    static func getCharacterImage(ofID id: Int) -> UIImage? {
        getImage(ofID: id, type: "Character")
    }

    static func getFilmImage(ofID id: Int) -> UIImage? {
        getImage(ofID: id, type: "Film")
    }

    static func getPlanetImage(ofID id: Int) -> UIImage? {
        getImage(ofID: id, type: "Planet")
    }

    static func getSpeciesImage(ofID id: Int) -> UIImage? {
        getImage(ofID: id, type: "Species")
    }

    static func getSpaceshipImage(ofID id: Int) -> UIImage? {
        getImage(ofID: id, type: "Spaceship")
    }

    static func getVehicleImage(ofID id: Int) -> UIImage? {
        getImage(ofID: id, type: "Vehicle")
    }

    private static func getImage(ofID id: Int, type: String) -> UIImage? {
        guard let path = Bundle.main.path(forResource: "\(type)\(id)", ofType: "jpg") else {
            return getRandomImage(from: allImagePaths.filter { $0.contains(type) })
        }

        return UIImage(contentsOfFile: path)
    }

    static func getRandomImage(from paths: [String]) -> UIImage? {
        UIImage(contentsOfFile: paths[Int.random(in: 0 ..< paths.count)])
    }
}

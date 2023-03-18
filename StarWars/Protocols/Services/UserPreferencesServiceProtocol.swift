//
//  UserPreferencesServiceProtocol.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import UIKit

protocol UserPreferencesServiceProtocol: AutoMockable {
    func updateUserInterfaceStyle(with state: UIUserInterfaceStyle)
    func saveChanges()
}

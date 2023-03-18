//
//  UserPreferences.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Foundation
import UIKit

struct UserPreferences: Codable {
    static let defaultPreferences = UserPreferences(userInterfaceStyle: .unspecified)

    // MARK: General Settings Preferences

    var userInterfaceStyle: UIUserInterfaceStyle
}

extension UIUserInterfaceStyle: Codable {}
